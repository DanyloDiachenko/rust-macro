/*
 * Low-level mouse injector via IOHIDPostEvent → IOHIDSystem.
 * This is what keyboard/mouse daemons (ckb, Karabiner event path) use.
 * Unlike CGEvent, relative IOHID posts are seen by games with raw input
 * even when the physical mouse is completely still.
 *
 * TCP 127.0.0.1:39241
 *   m <dx> <dy>   relative move
 *   ping -> pong
 *   quit
 *
 * Needs Accessibility (same session user — not root).
 */

#include <IOKit/IOKitLib.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDShared.h>
#include <IOKit/hidsystem/IOLLEvent.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

#define PORT 39241
#define MAX_CHUNK 40

#ifndef NX_NONCOALESCEDMASK
#define NX_NONCOALESCEDMASK (1 << 8)
#endif

static volatile int gRunning = 1;
static io_connect_t gHid = IO_OBJECT_NULL;
static pthread_mutex_t gMutex = PTHREAD_MUTEX_INITIALIZER;

static int clampChunk(int v) {
  if (v > MAX_CHUNK)
    return MAX_CHUNK;
  if (v < -MAX_CHUNK)
    return -MAX_CHUNK;
  return v;
}

static int openHidSystem(void) {
  io_service_t service = IOServiceGetMatchingService(
      kIOMainPortDefault, IOServiceMatching(kIOHIDSystemClass));
  if (!service) {
    fprintf(stderr, "[hid_mouse] IOHIDSystem service not found\n");
    return -1;
  }
  kern_return_t kr =
      IOServiceOpen(service, mach_task_self(), kIOHIDParamConnectType, &gHid);
  IOObjectRelease(service);
  if (kr != KERN_SUCCESS) {
    fprintf(stderr, "[hid_mouse] IOServiceOpen failed: 0x%x\n", kr);
    gHid = IO_OBJECT_NULL;
    return -1;
  }
  fprintf(stderr, "[hid_mouse] IOHIDSystem opened\n");
  return 0;
}

static void postRelative(int dx, int dy) {
  if (gHid == IO_OBJECT_NULL || (dx == 0 && dy == 0))
    return;

  while (dx != 0 || dy != 0) {
    int sx = clampChunk(dx);
    int sy = clampChunk(dy);

    NXEventData data;
    memset(&data, 0, sizeof(data));
    data.mouseMove.dx = sx;
    data.mouseMove.dy = sy;

    IOGPoint loc = {0, 0};
    /*
     * Relative moves are only accepted for NX_MOUSEMOVED with
     * kIOHIDSetRelativeCursorPosition (ckb / Apple HID path).
     */
    pthread_mutex_lock(&gMutex);
    kern_return_t kr =
        IOHIDPostEvent(gHid, NX_MOUSEMOVED, loc, &data, kNXEventDataVersion,
                       NX_NONCOALESCEDMASK, kIOHIDSetRelativeCursorPosition);
    pthread_mutex_unlock(&gMutex);

    if (kr != KERN_SUCCESS) {
      fprintf(stderr, "[hid_mouse] IOHIDPostEvent failed: 0x%x\n", kr);
      return;
    }

    dx -= sx;
    dy -= sy;
    if (dx != 0 || dy != 0)
      usleep(150);
  }
}

static void handleLine(char *line, int clientFd) {
  char cmd[32];
  int dx = 0, dy = 0;
  if (sscanf(line, "%31s", cmd) != 1)
    return;

  if (strcmp(cmd, "ping") == 0) {
    send(clientFd, "pong\n", 5, 0);
  } else if (strcmp(cmd, "quit") == 0) {
    gRunning = 0;
  } else if ((strcmp(cmd, "m") == 0 || strcmp(cmd, "n") == 0) &&
             sscanf(line, "%*s %d %d", &dx, &dy) == 2) {
    postRelative(dx, dy);
  }
}

static void *clientThread(void *arg) {
  int fd = (int)(intptr_t)arg;
  char buf[256];
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
  close(fd);
  return NULL;
}

static void onSignal(int sig) {
  (void)sig;
  gRunning = 0;
}

int main(void) {
  signal(SIGINT, onSignal);
  signal(SIGTERM, onSignal);

  if (openHidSystem() != 0)
    return 1;

  /* Quick self-test so Lua knows the path is live */
  postRelative(0, 0);

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
  if (bind(serverFd, (struct sockaddr *)&addr, sizeof(addr)) < 0 ||
      listen(serverFd, 8) < 0) {
    perror("bind/listen");
    return 1;
  }

  fprintf(stderr, "[hid_mouse] IOHIDPostEvent injector on 127.0.0.1:%d\n",
          PORT);
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
    pthread_t tid;
    pthread_create(&tid, NULL, clientThread, (void *)(intptr_t)client);
    pthread_detach(tid);
  }

  if (gHid != IO_OBJECT_NULL)
    IOServiceClose(gHid);
  close(serverFd);
  return 0;
}
