#pragma once
#include <mach/mach.h>
#include <string>

class Process {
public:
    pid_t pid = -1;
    mach_port_t task = MACH_PORT_NULL;

    bool Attach(const std::string& processName);
    void Detach();

    bool IsValid() const;
};
