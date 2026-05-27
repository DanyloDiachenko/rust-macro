#include "Memory.h"
#include "Process.h"
#include <chrono>
#include <iostream>
#include <thread>

int main() {
  Process proc;

  if (!proc.Attach("aces")) {
    return 1;
  }

  Memory mem(proc);

  std::cout << "Successfully connected! Starting memory reading...\n\n";

  while (true) {
    std::cout << "Memory reading works... (press Ctrl+C to exit)\n";

    std::this_thread::sleep_for(std::chrono::seconds(3));
  }

  return 0;
}