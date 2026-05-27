#include "Memory.h"
#include <iostream>
#include <mach/mach_vm.h>

Memory::Memory(Process &process) : m_process(process) {}

bool Memory::ReadBytes(uintptr_t address, void *buffer, size_t size) const {
  if (!m_process.IsValid() || address == 0) {
    return false;
  }

  mach_vm_size_t bytesRead = 0;
  kern_return_t kr = mach_vm_read_overwrite(
      m_process.task, address, size, (mach_vm_address_t)buffer, &bytesRead);

  return (kr == KERN_SUCCESS && bytesRead == size);
}
