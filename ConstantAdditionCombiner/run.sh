#!/usr/bin/bash

rm -rf build

cmake -B build
cmake --build build

# clang -S -emit-llvm tmp/foo.c -o tmp/foo.ll

opt -load-pass-plugin=build/libmypass.so -passes="constant-addition-printer" tmp/test.ll -disable-output

opt -S -load-pass-plugin=build/libmypass.so -passes="constant-addition-combiner" tmp/test.ll -o tmp/test_mypass.ll