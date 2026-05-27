#pragma once
#include "Process.h"
#include <cstdint>
#include <vector>

class Memory {
public:
  explicit Memory(Process &process);

  template <typename T> T Read(uintptr_t address) const;

  bool ReadBytes(uintptr_t address, void *buffer, size_t size) const;

private:
  Process &m_process;
};