#!/usr/bin/bash

rm -rf build

cmake -B build
cmake --build build

rm -rf mkdir
mkdir tmp
clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone foo.c -o tmp/foo.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="module-pass" tmp/foo.ll -o tmp/foo_mypass.ll