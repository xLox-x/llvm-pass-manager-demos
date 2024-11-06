#!/usr/bin/bash

rm -rf build

cmake -B build
cmake --build build

clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone tmp/foo.c -o tmp/foo.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="compile-time-function-call-counter" tmp/foo.ll -o tmp/foo_mypass.ll
