#include "Process.h"
#include <iostream>
#include <sys/sysctl.h>
#include <vector>

bool Process::Attach(const std::string& processName) {
    // clear previous data
    Detach();

    int mib[4] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0 };
    size_t length;

    // process list length
    if(sysctl(mib, 4, nullptr, &length, nullptr, 0) < 0) {
        std::cerr << "sysctl failed\n";
        return false;
    }

    std::vector<kinfo_proc> processes(length / sizeof(kinfo_proc));
    if(sysctl(mib, 4, processes.data(), &length, nullptr, 0) < 0) {
        std::cerr << "sysctl failed\n";
        return false;
    }

    // process by name
    for(const auto& proc : processes) {
        if(std::string(proc.kp_proc.p_comm) == processName) {
            pid = proc.kp_proc.p_pid;
            break;
        }
    }

    if(pid == -1) {
        std::cerr << "Process " << processName << " not found\n";
        return false;
    }

    // getting task (access to memory)
    kern_return_t kr = task_for_pid(mach_task_self(), pid, &task);
    if(kr != KERN_SUCCESS) {
        std::cerr << "task_for_pid failed. Error code: " << kr << "\n";
        /* std::cerr << "Try start VS Code with Admin Rights or disable System Integrity Protection" */
        return false;
    }

    std::cout << "Attached to process: " << processName << "\n";
    std::cout << "PID: " << pid << "\n";
    
    return true;
};

void Process::Detach() {
    if(task != MACH_PORT_NULL) {
        mach_port_deallocate(mach_task_self(), task);
        task = MACH_PORT_NULL;
    }
    pid = -1;
};

bool Process::IsValid() const {
    return pid != - 1 && task != MACH_PORT_NULL;
};
