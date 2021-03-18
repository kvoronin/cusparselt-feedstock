#!/bin/bash
set -ex


git clone https://github.com/NVIDIA/CUDALibrarySamples.git sample_linux/
cd sample_linux/cuSPARSELt/spmma
error_log=$(nvcc -I$PREFIX/include -L$PREFIX/lib -lcusparseLt spmma_example.cpp -o spmma_example 2>&1)
echo $error_log
