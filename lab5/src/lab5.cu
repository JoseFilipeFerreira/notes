#include <stdio.h>
#include <cstdlib>
#include <cmath>
#include <iostream>
#include <sys/time.h>

#define TIME_RESOLUTION 1000000	// time measuring resolution (us)

#define NUM_BLOCKS 128				// this is wrong
#define NUM_THREADS_PER_BLOCK 256	// this is wrong
#define SIZE 2048
#define TILE_SIZE 16

using namespace std;

float m1[SIZE][SIZE], m2[SIZE][SIZE], result[SIZE][SIZE], _result[SIZE][SIZE];
long long unsigned cpu_time;
timeval t;

void startTime (void) {
    gettimeofday(&t, NULL);
    cpu_time = t.tv_sec * TIME_RESOLUTION + t.tv_usec;
}

void stopTime (void) {
    gettimeofday(&t, NULL);
    long long unsigned final_time = t.tv_sec * TIME_RESOLUTION + t.tv_usec;

    final_time -= cpu_time;

    cout << final_time << " us have elapsed for the CPU execution" << endl;
}

void fillMatrices (void) {

    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {
            result[i][j] = 0.0;
            _result[i][j] = 0.0;
            m1[i][j] = ((float) rand()) / ((float) RAND_MAX);
            m2[i][j] = ((float) rand()) / ((float) RAND_MAX);
        }
    }
}

void checkCUDAError (const char *msg) {
    cudaError_t err = cudaGetLastError();
    if( cudaSuccess != err) {
        cerr << "Cuda error: " << msg << ", " << cudaGetErrorString( err) << endl;
        exit(-1);
    }
}

// You need to optimize AND parallelize this first
void regularMatrixMult (void) {
    for (unsigned i = 0; i < SIZE; ++i) {
        for (unsigned j = 0; j < SIZE; ++j) {

            result[i][j] = 0;
            for (unsigned k = 0; k < SIZE; ++k) {
                result[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
}

void tiledMatrixMult (void) {
    for (unsigned m = 0; m < SIZE; m += TILE_SIZE) {
        for (unsigned n = 0; n < SIZE; n += TILE_SIZE) {
            //...
        }
    }
}

// Fill the input parameters and kernel qualifier
__global__
void matrixMultKernel (double *dev_m1, double *dev_m2, double *dev_res) {
    int id = blockIdx.x*blockDim.x+threadIdx.x;



}

// Fill with the code required for the GPU stencil (mem allocation, transfers, kernel launch of stencilKernel)
double* matrixMultGPU (void) {
    // you can either:
    // 1 - use 2D matrices, as in CPU
    // 2 - use 1D matrices, but YOU have to convert them here

    return NULL;
}

int main (int argc, char** argv) {

    fillMatrices ();

    // GPU stuff
    matrixMultGPU ();

    // CPU stuff
    startTime();
    regularMatrixMult ();
    stopTime();


    return 0;
}
