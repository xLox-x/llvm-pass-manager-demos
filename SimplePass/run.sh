#!/usr/bin/bash

cmake -B build
cmake --build build

mkdir tmp
clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone foo.c -o tmp/foo.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="my-pass" tmp/foo.ll -o tmp/foo_opt.ll