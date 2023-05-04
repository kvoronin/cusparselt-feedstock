#!/bin/bash
set -ex

test -f $PREFIX/include/cusparseLt.h
test -f $PREFIX/lib/libcusparseLt.so
${GCC} test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
./test_load_elf $PREFIX/lib/libcusparseLt.so

# temporarily disable compilation tests, as the samples for v0.4.0 are not up yet
#git clone https://github.com/NVIDIA/CUDALibrarySamples.git sample_linux/
#cd sample_linux/cuSPARSELt/spmma
#error_log=$(nvcc -I$PREFIX/include -L$PREFIX/lib -lcusparse -lcusparseLt spmma_example.cpp -o spmma_example 2>&1)
#echo $error_log
