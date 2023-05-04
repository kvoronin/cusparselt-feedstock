@echo on
setlocal EnableDelayedExpansion

if not exist %LIBRARY_INC%\\cusparseLt.h exit 1
if not exist %LIBRARY_BIN%\\cusparseLt.dll exit 1
if not exist %LIBRARY_LIB%\\cusparseLt.lib exit 1

rem temporarily disable compilation tests, as the samples for v0.4.0 are not up yet
rem git clone "https://github.com/NVIDIA/CUDALibrarySamples.git" sample_linux
rem cd sample_linux\cuSPARSELt\spmma
rem call nvcc -I%LIBRARY_INC% -L%LIBRARY_LIB% -lcusparse -lcusparseLt spmma_example.cpp -o spmma_example
