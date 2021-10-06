#ifndef __GEMM__
#define __GEMM__

#define M_SIZE 2048

void gemm1(float*, float*, float*, int);
void gemm2(float*, float*, float*, int);
void gemm3(float*, float*, float*, int);
void gemm4(float*, float*, float*, int);
void gemm5(float*, float*, float*, int);
void gemm6(float*, float*, float*, int);
void gemm7(float*, float*, float*, int);
void gemm8(float*, float*, float*, int);
void gemm9(float*, float*, float*, int);
void gemm10(float*, float*, float*, int);
void gemm11(float*, float*, float*, int);
void gemm12(float*, float*, float*, int);

static char* Version_desc[13] = {
    "Unoptimized algorithm",
    "Loop reordering",
    "Using a local for aik",
    "Manual UNROLL",
    "Compiler UNROLL",
    "Auto-vectorize",
    "Compiler vectorization and UNROLL",
    "Vectorization with intrinsics",
    "Vectorization with intrinsics and compiler UNROLL",
    "OpenMP",
    "Compiler vectorization plus OpenMP",
    "vectorization intrinsics and OpenMP",
    "N/A"};

#endif
