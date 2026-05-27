#include "Memory.h"
#include "Process.h"
#include "Vector.h"
#include <chrono>
#include <iostream>
#include <thread>

int main() {
  Process proc;

  if (!proc.Attach("aces")) {
    return 1;
  }

  Memory mem(proc);

  std::cout << "Successfully connected to War Thunder!\n\n";

  while (true) {
    std::cout << "Program works... (Ctrl+C to exit)\n";

    std::this_thread::sleep_for(std::chrono::seconds(3));
  }

  return 0;
}