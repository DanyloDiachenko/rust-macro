/*
 * Local input assist helper.
 *
 * Posts relative pointing reports through the system VirtualHID service
 * (Karabiner DriverKit) with an IOHIDPostEvent fallback. Movement curves
 * run on a realtime thread for stable 1 ms timing.
 *
 * Must run as root: the service socket is in a root-only directory.
 *
 * Control TCP 127.0.0.1:49173 (one command per line)
 *   pat <path>     load curve ("dx dy delay_ms" per line)
 *   start / stop   run / halt the curve
 *   mul <f>        A/D hold scale
 *   stand <f>      standing+ADS scale (Ctrl up + RMB down; default 1.75)
 *   jit <f>        per-step magnitude jitter (default 0.10 = ±10%)
 *   tick <ms>      tick interval (default 1)
 *   m <dx> <dy>    one-off relative move
 *   ping           -> pong ok=.. ready=.. n=.. run=..
 *   quit
 */

#include <CoreGraphics/CoreGraphics.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDShared.h>
#include <IOKit/hidsystem/IOLLEvent.h>
#include <arpa/inet.h>
#include <errno.h>
#include <mach/mach_init.h>
#include <mach/mach_time.h>
#include <mach/thread_act.h>
#include <mach/thread_policy.h>
#include <math.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define PORT 49173
#define MAX_CHUNK 100
#define MAX_STEPS 8192
#define LOG_TAG "[ia]"

#define VHID_SOCKET_PATH                                                       \
  "/Library/Application "                                                      \
  "Support/org.pqrs/tmp/rootonly/karabiner_virtual_hid_device_service.sock"

/* pqrs::karabiner::driverkit protocol constants (SDK 8.2.0 / driver 1.8.0). */
#define CLIENT_PROTOCOL_VERSION 7
#define REQ_VIRTUAL_HID_POINTING_INITIALIZE 3
#define REQ_POST_POINTING_INPUT_REPORT 11
#define RESP_VIRTUAL_HID_POINTING_READY 5

/* pqrs::unix_domain_stream frame types. */
#define FRAME_HEARTBEAT 0
#define FRAME_USER_DATA 1
#define FRAME_HEALTH_CHECK 2
#define FRAME_HEALTH_CHECK_RESPONSE 3
#define FRAME_REQUEST 4
#define FRAME_RESPONSE 5

#ifndef kVK_ANSI_A
#define kVK_ANSI_A 0x00
#endif
#ifndef kVK_ANSI_D
#define kVK_ANSI_D 0x02
#endif
#ifndef kVK_Control
#define kVK_Control 0x3B
#endif
#ifndef kVK_RightControl
#define kVK_RightControl 0x3E
#endif

#ifndef NX_NONCOALESCEDMASK
#define NX_NONCOALESCEDMASK (1 << 8)
#endif

typedef struct {
  double dx;
  double dy;
  int delay;
} step_t;

static volatile int gRunning = 1;

/* VirtualHID state */
static int gVhidFd = -1;
static int gPointingReady = 0;
static uint64_t gRequestId = 1;
static pthread_mutex_t gVhidMutex = PTHREAD_MUTEX_INITIALIZER;

/* IOHIDPostEvent fallback */
static io_connect_t gHid = IO_OBJECT_NULL;
static pthread_mutex_t gHidMutex = PTHREAD_MUTEX_INITIALIZER;

/* Pattern engine */
static step_t gSteps[MAX_STEPS];
static int gStepCount = 0;
static volatile int gSpraying = 0;
/* Only the connection that started a spray may cancel it: a stray `ping`
 * from another client must not abort an in-flight spray when it disconnects. */
static volatile int gSprayOwnerFd = -1;
static double gStrafeMul = 1.25;
/* Standing ADS (Ctrl up + RMB): multiply compensation. Else 1.0 for this axis. */
static double gStandMul = 1.75;
/* Magnitude jitter amplitude: 0.10 keeps ~90% fidelity to the base curve. */
static double gJitter = 0.30;
static volatile int gTickMs = 1;
static pthread_mutex_t gPatternMutex = PTHREAD_MUTEX_INITIALIZER;
static uint64_t gRngState = 0x9e3779b97f4a7c15ULL;

static uint64_t rngNext(void) {
  /* xorshift64* — fast, good enough for micro-jitter */
  uint64_t x = gRngState;
  x ^= x >> 12;
  x ^= x << 25;
  x ^= x >> 27;
  gRngState = x;
  return x * 0x2545F4914F6CDD1DULL;
}

static double rngUnit(void) {
  return (double)(rngNext() >> 11) * (1.0 / 9007199254740992.0);
}

/* Uniform in [lo, hi]. */
static double rngRange(double lo, double hi) {
  return lo + (hi - lo) * rngUnit();
}

static void rngSeed(void) {
  gRngState =
      mach_absolute_time() ^ ((uint64_t)getpid() << 32) ^ 0xA5A5A5A5A5A5A5A5ULL;
  if (gRngState == 0)
    gRngState = 0x9e3779b97f4a7c15ULL;
  /* Warm up */
  for (int i = 0; i < 8; ++i)
    (void)rngNext();
}

static int keyIsDown(CGKeyCode key) {
  return CGEventSourceKeyState(kCGEventSourceStateHIDSystemState, key) ||
         CGEventSourceKeyState(kCGEventSourceStateCombinedSessionState, key);
}

static int isStrafing(void) {
  return keyIsDown(kVK_ANSI_A) || keyIsDown(kVK_ANSI_D);
}

static int isCrouching(void) {
  return keyIsDown(kVK_Control) || keyIsDown(kVK_RightControl);
}

static int isAds(void) {
  return CGEventSourceButtonState(kCGEventSourceStateHIDSystemState,
                                  kCGMouseButtonRight)
      || CGEventSourceButtonState(kCGEventSourceStateCombinedSessionState,
                                  kCGMouseButtonRight);
}

static double liveScale(void) {
  double scale = 1.0;
  /* Standing hip-fire: no stand boost. Standing ADS: × standMul. Crouch: 1.0. */
  if (!isCrouching() && isAds())
    scale *= gStandMul;
  if (isStrafing())
    scale *= gStrafeMul;
  return scale;
}

static int clampDelta(int v) {
  if (v > MAX_CHUNK)
    return MAX_CHUNK;
  if (v < -MAX_CHUNK)
    return -MAX_CHUNK;
  return v;
}

/* ------------------------------------------------------------------ */
/* VirtualHID client                                                   */
/* ------------------------------------------------------------------ */

static void encodeU32BE(uint8_t *out, uint32_t v) {
  out[0] = (uint8_t)(v >> 24);
  out[1] = (uint8_t)(v >> 16);
  out[2] = (uint8_t)(v >> 8);
  out[3] = (uint8_t)v;
}

static void encodeU64BE(uint8_t *out, uint64_t v) {
  for (int i = 0; i < 8; ++i) {
    out[i] = (uint8_t)(v >> (56 - 8 * i));
  }
}

static int writeAll(int fd, const uint8_t *buf, size_t len) {
  size_t sent = 0;
  while (sent < len) {
    ssize_t n = send(fd, buf + sent, len - sent, 0);
    if (n <= 0) {
      if (n < 0 && errno == EINTR)
        continue;
      return -1;
    }
    sent += (size_t)n;
  }
  return 0;
}

/* Frame: [u32 BE body_size][u8 type][body] */
static int vhidSendFrame(uint8_t type, const uint8_t *body, size_t bodyLen) {
  if (gVhidFd < 0)
    return -1;

  uint8_t frame[1200];
  size_t total = 4 + 1 + bodyLen;
  if (total > sizeof(frame))
    return -1;

  encodeU32BE(frame, (uint32_t)(1 + bodyLen));
  frame[4] = type;
  if (body && bodyLen)
    memcpy(frame + 5, body, bodyLen);

  return writeAll(gVhidFd, frame, total);
}

/* Request body: [u64 BE request_id][u16 LE proto][u8 request][payload] */
static int vhidSendRequest(uint8_t request, const uint8_t *payload,
                           size_t payloadLen) {
  uint8_t body[512];
  size_t bodyLen = 8 + 2 + 1 + payloadLen;
  if (bodyLen > sizeof(body))
    return -1;

  encodeU64BE(body, gRequestId++);
  body[8] = (uint8_t)(CLIENT_PROTOCOL_VERSION & 0xff);
  body[9] = (uint8_t)((CLIENT_PROTOCOL_VERSION >> 8) & 0xff);
  body[10] = request;
  if (payload && payloadLen)
    memcpy(body + 11, payload, payloadLen);

  return vhidSendFrame(FRAME_REQUEST, body, bodyLen);
}

static void vhidDisconnect(void) {
  if (gVhidFd >= 0) {
    close(gVhidFd);
    gVhidFd = -1;
  }
  gPointingReady = 0;
}

static int vhidConnect(void) {
  int fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (fd < 0)
    return -1;

  struct sockaddr_un addr;
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strncpy(addr.sun_path, VHID_SOCKET_PATH, sizeof(addr.sun_path) - 1);

  if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    close(fd);
    return -1;
  }

  gVhidFd = fd;
  gPointingReady = 0;
  return 0;
}

static void vhidPostPointing(int dx, int dy) {
  /* pointing_input (packed): u32 buttons, i8 x, i8 y, i8 vwheel, i8 hwheel */
  uint8_t report[8];
  memset(report, 0, sizeof(report));
  report[4] = (uint8_t)(int8_t)clampDelta(dx);
  report[5] = (uint8_t)(int8_t)clampDelta(dy);

  pthread_mutex_lock(&gVhidMutex);
  if (vhidSendRequest(REQ_POST_POINTING_INPUT_REPORT, report, sizeof(report)) !=
      0) {
    vhidDisconnect();
  }
  pthread_mutex_unlock(&gVhidMutex);
}

/* Server pushes status as [response_type, value] pairs. */
static void vhidHandleStatus(const uint8_t *data, size_t len) {
  for (size_t i = 0; i + 1 < len; i += 2) {
    if (data[i] == RESP_VIRTUAL_HID_POINTING_READY) {
      int ready = data[i + 1] ? 1 : 0;
      if (ready != gPointingReady) {
        fprintf(stderr, LOG_TAG " pointing ready=%d\n", ready);
        fflush(stderr);
      }
      gPointingReady = ready;
    }
  }
}

static int readExact(int fd, uint8_t *buf, size_t len) {
  size_t got = 0;
  while (got < len) {
    ssize_t n = recv(fd, buf + got, len - got, 0);
    if (n <= 0) {
      if (n < 0 && errno == EINTR)
        continue;
      return -1;
    }
    got += (size_t)n;
  }
  return 0;
}

static void *vhidReaderThread(void *arg) {
  (void)arg;

  while (gRunning) {
    if (gVhidFd < 0) {
      pthread_mutex_lock(&gVhidMutex);
      int ok = (vhidConnect() == 0);
      if (ok) {
        fprintf(stderr, LOG_TAG " service connected\n");
        fflush(stderr);
        vhidSendRequest(REQ_VIRTUAL_HID_POINTING_INITIALIZE, NULL, 0);
      }
      pthread_mutex_unlock(&gVhidMutex);

      if (!ok) {
        sleep(1);
        continue;
      }
    }

    uint8_t header[4];
    if (readExact(gVhidFd, header, 4) != 0) {
      pthread_mutex_lock(&gVhidMutex);
      vhidDisconnect();
      pthread_mutex_unlock(&gVhidMutex);
      sleep(1);
      continue;
    }

    uint32_t bodySize = ((uint32_t)header[0] << 24) |
                        ((uint32_t)header[1] << 16) |
                        ((uint32_t)header[2] << 8) | (uint32_t)header[3];
    if (bodySize < 1 || bodySize > 4096) {
      pthread_mutex_lock(&gVhidMutex);
      vhidDisconnect();
      pthread_mutex_unlock(&gVhidMutex);
      continue;
    }

    uint8_t body[4096];
    if (readExact(gVhidFd, body, bodySize) != 0) {
      pthread_mutex_lock(&gVhidMutex);
      vhidDisconnect();
      pthread_mutex_unlock(&gVhidMutex);
      continue;
    }

    uint8_t type = body[0];
    if (type == FRAME_REQUEST && bodySize >= 9) {
      /* Status push: reply with an empty response carrying the same id. */
      vhidHandleStatus(body + 9, bodySize - 9);

      uint8_t resp[8];
      memcpy(resp, body + 1, 8);
      pthread_mutex_lock(&gVhidMutex);
      vhidSendFrame(FRAME_RESPONSE, resp, sizeof(resp));
      pthread_mutex_unlock(&gVhidMutex);
    } else if (type == FRAME_RESPONSE && bodySize >= 9) {
      vhidHandleStatus(body + 9, bodySize - 9);
    } else if (type == FRAME_HEALTH_CHECK) {
      pthread_mutex_lock(&gVhidMutex);
      vhidSendFrame(FRAME_HEALTH_CHECK_RESPONSE, NULL, 0);
      pthread_mutex_unlock(&gVhidMutex);
    }
  }

  return NULL;
}

static void *vhidHeartbeatThread(void *arg) {
  (void)arg;
  while (gRunning) {
    sleep(3);
    if (gVhidFd >= 0) {
      pthread_mutex_lock(&gVhidMutex);
      if (vhidSendFrame(FRAME_HEARTBEAT, NULL, 0) != 0) {
        vhidDisconnect();
      }
      pthread_mutex_unlock(&gVhidMutex);
    }
  }
  return NULL;
}

/* ------------------------------------------------------------------ */
/* IOHIDPostEvent fallback                                             */
/* ------------------------------------------------------------------ */

static int openHidSystem(void) {
  io_service_t service = IOServiceGetMatchingService(
      kIOMainPortDefault, IOServiceMatching(kIOHIDSystemClass));
  if (!service)
    return -1;

  kern_return_t kr =
      IOServiceOpen(service, mach_task_self(), kIOHIDParamConnectType, &gHid);
  IOObjectRelease(service);
  if (kr != KERN_SUCCESS) {
    gHid = IO_OBJECT_NULL;
    return -1;
  }
  return 0;
}

static void postRelativeLegacy(int dx, int dy) {
  if (gHid == IO_OBJECT_NULL || (dx == 0 && dy == 0))
    return;

  NXEventData data;
  memset(&data, 0, sizeof(data));
  data.mouseMove.dx = clampDelta(dx);
  data.mouseMove.dy = clampDelta(dy);

  IOGPoint loc = {0, 0};
  pthread_mutex_lock(&gHidMutex);
  IOHIDPostEvent(gHid, NX_MOUSEMOVED, loc, &data, kNXEventDataVersion,
                 NX_NONCOALESCEDMASK, kIOHIDSetRelativeCursorPosition);
  pthread_mutex_unlock(&gHidMutex);
}

static void emitMove(int dx, int dy) {
  if (dx == 0 && dy == 0)
    return;

  if (gVhidFd >= 0 && gPointingReady) {
    vhidPostPointing(dx, dy);
  } else {
    postRelativeLegacy(dx, dy);
  }
}

/* ------------------------------------------------------------------ */
/* Pattern engine                                                      */
/* ------------------------------------------------------------------ */

static int loadPattern(const char *path) {
  FILE *f = fopen(path, "r");
  if (!f)
    return -1;

  pthread_mutex_lock(&gPatternMutex);
  gStepCount = 0;
  char line[256];
  while (fgets(line, sizeof(line), f) && gStepCount < MAX_STEPS) {
    double dx, dy;
    int delay;
    if (sscanf(line, "%lf %lf %d", &dx, &dy, &delay) == 3) {
      gSteps[gStepCount].dx = dx;
      gSteps[gStepCount].dy = dy;
      gSteps[gStepCount].delay = delay < 1 ? 1 : delay;
      gStepCount++;
    }
  }
  int count = gStepCount;
  pthread_mutex_unlock(&gPatternMutex);
  fclose(f);

  fprintf(stderr, LOG_TAG " curve loaded n=%d\n", count);
  fflush(stderr);
  return count;
}

static void makeThreadRealtime(void) {
  mach_timebase_info_data_t tb;
  mach_timebase_info(&tb);
  double ns2abs = (double)tb.denom / (double)tb.numer;

  thread_time_constraint_policy_data_t policy;
  policy.period = (uint32_t)(1000000 * ns2abs);     /* 1 ms */
  policy.computation = (uint32_t)(100000 * ns2abs); /* 100 us */
  policy.constraint = (uint32_t)(300000 * ns2abs);  /* 300 us */
  policy.preemptible = 0;

  thread_policy_set(pthread_mach_thread_np(pthread_self()),
                    THREAD_TIME_CONSTRAINT_POLICY, (thread_policy_t)&policy,
                    THREAD_TIME_CONSTRAINT_POLICY_COUNT);
}

static void *patternThread(void *arg) {
  (void)arg;
  makeThreadRealtime();

  mach_timebase_info_data_t tb;
  mach_timebase_info(&tb);
  double ns2abs = (double)tb.denom / (double)tb.numer;

  int wasSpraying = 0;
  int stepIndex = 0;
  double patternTimeMs = 0.0;
  double owedX = 0.0, owedY = 0.0;
  double sessionScale = 1.0;
  uint64_t startAbs = 0;

  while (gRunning) {
    int spraying = gSpraying;

    if (spraying && !wasSpraying) {
      stepIndex = 0;
      patternTimeMs = 0.0;
      owedX = owedY = 0.0;
      startAbs = mach_absolute_time();
      rngSeed();
      /* Per-run overall scale ± half of jitter → still ~90% of base. */
      double j = gJitter;
      if (j < 0.0)
        j = 0.0;
      if (j > 0.25)
        j = 0.25;
      sessionScale = rngRange(1.0 - j * 0.5, 1.0 + j * 0.5);
    }
    if (!spraying) {
      if (wasSpraying) {
        owedX = owedY = 0.0;
      }
      wasSpraying = 0;
      usleep(2000);
      continue;
    }
    wasSpraying = 1;

    uint64_t nowAbs = mach_absolute_time();
    double elapsedMs = (double)(nowAbs - startAbs) *
                       ((double)tb.numer / (double)tb.denom) / 1e6;

    double scale = liveScale();
    double j = gJitter;
    if (j < 0.0)
      j = 0.0;
    if (j > 0.25)
      j = 0.25;

    pthread_mutex_lock(&gPatternMutex);
    int count = gStepCount;
    while (count > 0 && patternTimeMs <= elapsedMs) {
      if (stepIndex >= count)
        stepIndex = 0;
      step_t *s = &gSteps[stepIndex];

      /* Independent ±j on each axis — keeps shape, breaks identical curves. */
      double jx = (j > 0.0) ? rngRange(1.0 - j, 1.0 + j) : 1.0;
      double jy = (j > 0.0) ? rngRange(1.0 - j, 1.0 + j) : 1.0;
      owedX += s->dx * scale * sessionScale * jx;
      owedY += s->dy * scale * sessionScale * jy;

      double delay = (double)s->delay;
      /* Occasional ±1 ms timing wobble (human-like), never below 1. */
      if (j > 0.0 && rngUnit() < 0.35) {
        delay += (rngUnit() < 0.5) ? -1.0 : 1.0;
      }
      if (delay < 1.0)
        delay = 1.0;
      patternTimeMs += delay;
      stepIndex++;
    }
    pthread_mutex_unlock(&gPatternMutex);

    int ix = (int)(owedX >= 0 ? floor(owedX) : ceil(owedX));
    int iy = (int)(owedY >= 0 ? floor(owedY) : ceil(owedY));
    if (ix != 0 || iy != 0) {
      owedX -= ix;
      owedY -= iy;
      emitMove(ix, iy);
    }

    int tickMs = gTickMs < 1 ? 1 : gTickMs;
    uint64_t deadline =
        nowAbs + (uint64_t)((double)tickMs * 1000000.0 * ns2abs);
    mach_wait_until(deadline);
  }

  return NULL;
}

/* ------------------------------------------------------------------ */
/* Control server                                                      */
/* ------------------------------------------------------------------ */

static void handleLine(char *line, int clientFd) {
  char cmd[32];
  char arg[256];
  int dx = 0, dy = 0, n = 0;
  double f = 0.0;
  char resp[128];

  if (sscanf(line, "%31s", cmd) != 1)
    return;

  if (strcmp(cmd, "ping") == 0) {
    n = snprintf(resp, sizeof(resp), "pong ok=%d ready=%d n=%d run=%d\n",
                 gVhidFd >= 0 ? 1 : 0, gPointingReady, gStepCount, gSpraying);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "pat") == 0 &&
             sscanf(line, "%*s %255[^\n]", arg) == 1) {
    int count = loadPattern(arg);
    n = snprintf(resp, sizeof(resp), "n=%d\n", count);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "start") == 0) {
    gSprayOwnerFd = clientFd;
    gSpraying = 1;
    send(clientFd, "run=1\n", 6, 0);

  } else if (strcmp(cmd, "stop") == 0) {
    gSpraying = 0;
    gSprayOwnerFd = -1;
    send(clientFd, "run=0\n", 6, 0);

  } else if (strcmp(cmd, "mul") == 0 && sscanf(line, "%*s %lf", &f) == 1) {
    if (f < 0.1)
      f = 0.1;
    if (f > 20.0)
      f = 20.0;
    gStrafeMul = f;
    n = snprintf(resp, sizeof(resp), "mul=%.4f\n", gStrafeMul);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "stand") == 0 && sscanf(line, "%*s %lf", &f) == 1) {
    if (f < 0.1)
      f = 0.1;
    if (f > 20.0)
      f = 20.0;
    gStandMul = f;
    n = snprintf(resp, sizeof(resp), "stand=%.4f\n", gStandMul);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "jit") == 0 && sscanf(line, "%*s %lf", &f) == 1) {
    if (f < 0.0)
      f = 0.0;
    if (f > 0.25)
      f = 0.25;
    gJitter = f;
    n = snprintf(resp, sizeof(resp), "jit=%.4f\n", gJitter);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "tick") == 0 && sscanf(line, "%*s %d", &dx) == 1) {
    gTickMs = (dx < 1) ? 1 : (dx > 20 ? 20 : dx);
    n = snprintf(resp, sizeof(resp), "tick=%d\n", gTickMs);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "strafe") == 0) {
    n = snprintf(resp, sizeof(resp), "ad=%d\n", isStrafing() ? 1 : 0);
    send(clientFd, resp, (size_t)n, 0);

  } else if (strcmp(cmd, "quit") == 0) {
    gSpraying = 0;
    gRunning = 0;

  } else if (strcmp(cmd, "m") == 0 &&
             sscanf(line, "%*s %d %d", &dx, &dy) == 2) {
    emitMove(dx, dy);
  }
}

static void *clientThread(void *arg) {
  int fd = (int)(intptr_t)arg;
  char buf[512];
  size_t used = 0;

  while (gRunning) {
    ssize_t n = recv(fd, buf + used, sizeof(buf) - used - 1, 0);
    if (n <= 0)
      break;
    used += (size_t)n;
    buf[used] = '\0';

    char *start = buf, *nl;
    while ((nl = strchr(start, '\n')) != NULL) {
      *nl = '\0';
      handleLine(start, fd);
      start = nl + 1;
    }
    size_t remain = strlen(start);
    memmove(buf, start, remain);
    used = remain;
  }

  /* A dropped control connection means Hammerspoon died mid-spray. */
  if (gSprayOwnerFd == fd) {
    gSpraying = 0;
    gSprayOwnerFd = -1;
  }
  close(fd);
  return NULL;
}

static void onSignal(int sig) {
  (void)sig;
  gSpraying = 0;
  gRunning = 0;
}

int main(int argc, char **argv) {
  signal(SIGINT, onSignal);
  signal(SIGTERM, onSignal);
  signal(SIGPIPE, SIG_IGN);

  /* Reload the pattern on startup so a daemon restart never leaves us armed
   * with an empty pattern while Hammerspoon still believes it uploaded one. */
  if (argc > 1) {
    loadPattern(argv[1]);
  }

  if (openHidSystem() == 0) {
    fprintf(stderr, LOG_TAG " fallback ready\n");
  } else {
    fprintf(stderr, LOG_TAG " fallback unavailable\n");
  }

  pthread_t tid;
  pthread_create(&tid, NULL, vhidReaderThread, NULL);
  pthread_detach(tid);
  pthread_create(&tid, NULL, vhidHeartbeatThread, NULL);
  pthread_detach(tid);
  pthread_create(&tid, NULL, patternThread, NULL);
  pthread_detach(tid);

  int serverFd = socket(AF_INET, SOCK_STREAM, 0);
  if (serverFd < 0)
    return 1;
  int yes = 1;
  setsockopt(serverFd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes));

  struct sockaddr_in addr;
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
  addr.sin_port = htons(PORT);
  /* A stale instance may still hold the port; wait it out instead of dying. */
  while (gRunning &&
         bind(serverFd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    fprintf(stderr, LOG_TAG " port %d busy\n", PORT);
    fflush(stderr);
    sleep(2);
  }
  if (listen(serverFd, 8) < 0) {
    perror("listen");
    return 1;
  }

  fprintf(stderr, LOG_TAG " listening on %d\n", PORT);
  fflush(stderr);

  while (gRunning) {
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(serverFd, &fds);
    struct timeval tv = {0, 200000};
    if (select(serverFd + 1, &fds, NULL, NULL, &tv) <= 0)
      continue;

    int client = accept(serverFd, NULL, NULL);
    if (client < 0)
      continue;
    int flag = 1;
    setsockopt(client, IPPROTO_TCP, TCP_NODELAY, &flag, sizeof(flag));

    pthread_t ctid;
    pthread_create(&ctid, NULL, clientThread, (void *)(intptr_t)client);
    pthread_detach(ctid);
  }

  gSpraying = 0;
  pthread_mutex_lock(&gVhidMutex);
  vhidDisconnect();
  pthread_mutex_unlock(&gVhidMutex);
  if (gHid != IO_OBJECT_NULL)
    IOServiceClose(gHid);
  close(serverFd);
  return 0;
}
