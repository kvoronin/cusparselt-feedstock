#!/bin/bash
set -ex

# skip symbol/compilation tests on non-x86 archs due to the usage of newer glibc symbols
if [[ $target_platform == "linux-64" ]]; then
    export CUDA_STUB="$PREFIX/lib/stubs/libcuda.so"

    ${GCC} test/test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
    LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcusparseLt.so

    # for cuSPARSE header
    if [[ "${cuda_compiler_version}" =~ 12.* ]]; then
        CUDA_INC_PATH="${PREFIX}/include"
    elif [[ "${cuda_compiler_version}" =~ 11.* ]]; then
        CUDA_INC_PATH="${CUDA_PATH}/include"
    fi

    git clone https://github.com/NVIDIA/CUDALibrarySamples.git sample_linux/
    cd sample_linux/cuSPARSELt/matmul
    error_log=$(nvcc --std=c++14 -I$CUDA_INC_PATH -I$PREFIX/include -L$PREFIX/lib -L$PREFIX/lib/stubs -lcusparse -lcusparseLt -lcuda -lnvrtc matmul_example.cpp -o matmul_example 2>&1)
    echo $error_log
fi
