@echo on
setlocal EnableDelayedExpansion

if not exist %LIBRARY_INC%\\cusparseLt.h exit 1
if not exist %LIBRARY_BIN%\\cusparseLt.dll exit 1
if not exist %LIBRARY_LIB%\\cusparseLt.lib exit 1

git clone "https://github.com/NVIDIA/CUDALibrarySamples.git" sample_linux
cd sample_linux\cuSPARSELt\matmul
call nvcc --std=c++14 -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcusparse -lcusparseLt -lnvrtc matmul_example.cpp -o matmul_example
