#!/usr/bin/bash

rm -rf build

cmake -B build
cmake --build build

clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone tmp/foo.c -o tmp/foo.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="loop-pass" tmp/foo.ll -o tmp/foo_mypass.ll

clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone tmp/bar.c -o tmp/bar.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="loop-pass" tmp/bar.ll -o tmp/bar_mypass.ll