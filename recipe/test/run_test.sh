#!/bin/bash
set -ex

export CUDA_STUB="$PREFIX/lib/stubs/libcuda.so"

${GCC} test/test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcusparseLt.so

# for cuSPARSE header
export CUDA_INC_PATH="${CUDA_PATH}/include"

git clone https://github.com/NVIDIA/CUDALibrarySamples.git sample_linux/
cd sample_linux/cuSPARSELt/matmul
error_log=$(nvcc --std=c++14 -I$CUDA_INC_PATH -I$PREFIX/include -L$PREFIX/lib -L$PREFIX/lib/stubs -lcusparse -lcusparseLt -lcuda -lnvrtc matmul_example.cpp -o matmul_example  2>&1)
echo $error_log
