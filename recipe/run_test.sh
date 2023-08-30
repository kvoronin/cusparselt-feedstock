#!/bin/bash
set -ex

test -f $PREFIX/include/cusparseLt.h
test -f $PREFIX/lib/libcusparseLt.so
# skip symbol tests on non-x86 archs due to the usage of newer glibc symbols
if [[ $target_platform == "linux64" ]]; then
    ${GCC} test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
    ./test_load_elf $PREFIX/lib/libcusparseLt.so
fi

git clone https://github.com/NVIDIA/CUDALibrarySamples.git sample_linux/
cd sample_linux/cuSPARSELt/matmul
error_log=$(nvcc --std=c++14 -I$PREFIX/include -L$PREFIX/lib -lcusparse -lcusparseLt -lnvrtc matmul_example.cpp -o matmul_example 2>&1)
echo $error_log
