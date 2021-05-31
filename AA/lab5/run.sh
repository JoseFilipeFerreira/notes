#!/bin/sh

module load gcc/5.3.0
module load cuda/10.1

cd $PBS_O_WORKDIR


nvprof --print-summary ./bin/matrix_mult 2>matrix_mult_cuda_prof.txt