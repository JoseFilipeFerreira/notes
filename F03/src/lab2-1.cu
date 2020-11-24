/**************************************************************
 *
 * --== Simple CUDA kernel ==--
 * author: ampereira
 *
 *
 * Fill the rest of the code
 *
 * Insert the functions for time measurement in the correct
 * sections (i.e. do not account for filling the vectors with random data)
 *
 *
 * The stencil array size must be set to the SIZE #define, i.e., float stencil[SIZE];
 **************************************************************/
#include <stdio.h>
#include <cstdlib>
#include <iostream>
#include <sys/time.h>
#include <omp.h>

#define TIME_RESOLUTION 1000000	// time measuring resolution (us)

#define NUM_BLOCKS 2560
#define NUM_THREADS_PER_BLOCK 5120
#define SIZE NUM_BLOCKS*NUM_THREADS_PER_BLOCK
#define NEIGHBOURS 4

using namespace std;

long long unsigned cpu_time;
cudaEvent_t start, stop;
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

// These are specific to measure the execution of only the kernel execution - might be useful
void startKernelTime (void) {
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
}

void stopKernelTime (void) {
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    cout << milliseconds << " ms have elapsed for the CUDA execution" << endl;
}

void checkCUDAError (const char *msg) {
    cudaError_t err = cudaGetLastError();
    if( cudaSuccess != err) {
        cerr << "Cuda error: " << msg << ", " << cudaGetErrorString( err) << endl;
        exit(-1);
    }
}

// Fill the input parameters and kernel qualifier
__global__
void stencilKernel (double *dev_array, double *dev_output) {
    // the id of the current thread on the GPU - only valid for 1D thread structure
    int id = blockIdx.x*blockDim.x+threadIdx.x;

    // REMEMBER: code this as it should only computes a single element of dev_array
    // this kernel will be executed by all CUDA threads that have different ids
    dev_output[id] = 0.0;
    for (int j = -NEIGHBOURS; j <= NEIGHBOURS; j++) {
        // do not do anything if the array is out of bounds
        if (id + j >= 0 &&  id + j < SIZE) {
            dev_output[id] += dev_array[id+j];
        }
    }

}

// Fill with the code required for the GPU stencil (mem allocation, transfers, kernel launch of stencilKernel)
double* stencilGPU (double *array) {
    double *dev_array, *dev_output;
    double *array_output = new double [SIZE];

    // allocate the memory on the device
    cudaMalloc((void**) &dev_array, sizeof(double) * SIZE);
    cudaMalloc((void**) &dev_output, sizeof(double) * SIZE);

    startKernelTime();
    // copy inputs to the device
    cudaMemcpy(dev_array, array, sizeof(double) * SIZE, cudaMemcpyHostToDevice);

    // launch the kernel
    stencilKernel <<< NUM_THREADS_PER_BLOCK, NUM_BLOCKS >>> (dev_array, dev_output);

    // copy the output to the host
    cudaMemcpy(array_output, dev_output, sizeof(double) * SIZE, cudaMemcpyDeviceToHost);
    stopKernelTime();

    // free the device memory
    cudaFree(dev_array);
    cudaFree(dev_output);

    return array_output;
}

// The CPU stencil - add a value with its 4 neighbours
double* stencilCPU (double *array) {
    double *output_array = new double [SIZE];

    #pragma omp parallel for
    for (int i = 0; i < SIZE; i++) {
        output_array[i] = 0.0;

        for (int j = -NEIGHBOURS; j <= NEIGHBOURS; j++) {
            // do not do anything if the array is out of bounds
            if (i + j >= 0 &&  i + j < SIZE) {
                output_array[i] += array[i+j];
            }
        }
    }

    return output_array;
}

int main (int argc, char** argv) {

    double array [SIZE];

    // initialize array with random values
    for (unsigned i = 0; i < SIZE; i++)
        array[i] = ((double) rand()) / ((double) RAND_MAX);


    stencilGPU(array);

    startTime();
    stencilCPU(array);
    stopTime();


    return 0;
}
