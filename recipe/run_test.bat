@echo on
setlocal EnableDelayedExpansion

if not exist %LIBRARY_INC%\\cusparseLt.h exit 1
if not exist %LIBRARY_BIN%\\cusparseLt.dll exit 1
if not exist %LIBRARY_LIB%\\cusparseLt.lib exit 1

git clone "https://github.com/NVIDIA/CUDALibrarySamples.git" sample_linux
cd sample_linux\cuSPARSELt\spmma
call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcusparse -lcusparseLt spmma_example.cpp -o spmma_example
