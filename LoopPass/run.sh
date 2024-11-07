#!/usr/bin/bash

rm -rf build
rm -rf tmp
mkdir tmp

cmake -B build
cmake --build build

clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone foo.c -o tmp/foo.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="loop-pass" tmp/foo.ll -o tmp/foo_mypass.ll

clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone bar.c -o tmp/bar.ll
opt -S -load-pass-plugin=build/libmypass.so -passes="loop-pass" tmp/bar.ll -o tmp/bar_mypass.ll