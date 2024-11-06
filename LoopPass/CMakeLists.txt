cmake_minimum_required(VERSION 3.10)
project(MyPass)

set(CMAKE_CXX_STANDARD 14)

set(LLVM_PATH /usr/lib/llvm-14)

include_directories(${LLVM_PATH}/include)

add_library(mypass MODULE MyPass.cpp)

set_target_properties(mypass PROPERTIES
        COMPILE_FLAGS "-fno-rtti"
        )

target_link_libraries(mypass ${LLVM_PATH}/lib/libLLVM-14.so)