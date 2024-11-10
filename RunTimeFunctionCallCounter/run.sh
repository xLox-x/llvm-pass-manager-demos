#!/usr/bin/bash

rm -rf build
rm -rf tmp
mkdir tmp

cmake -B build
cmake --build build

clang -S -emit-llvm foo.c -o tmp/foo.ll

opt -load-pass-plugin=build/libmypass.so -passes="runtime-function-call-counter" tmp/foo.ll -o tmp/foo_mypass.bin

lli tmp/foo_mypass.bin

llvm-dis tmp/foo_mypass.bin -o tmp/foo_mypass.ll
