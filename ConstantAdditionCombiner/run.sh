#!/usr/bin/bash

rm -rf build
mr -rf tmp
mkdir tmp

cmake -B build
cmake --build build

opt -load-pass-plugin=build/libmypass.so -passes="constant-addition-printer" test.ll -disable-output

opt -S -load-pass-plugin=build/libmypass.so -passes="constant-addition-combiner" test.ll -o tmp/test_mypass.ll