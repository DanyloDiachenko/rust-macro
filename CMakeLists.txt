cmake_minimum_required(VERSION 3.20)
project(TEST_CPP)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_OSX_ARCHITECTURES "arm64")   # M2 Pro

add_executable(test_cpp 
    main.cpp
    Process.cpp
    Memory.cpp
)

target_link_libraries(test_cpp 
    "-framework Foundation"
    "-framework CoreGraphics"
    "-framework AppKit"
)