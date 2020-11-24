#!/bin/sh

module load gcc/5.3.0
module load cuda/10.1

cd $PBS_O_WORKDIR

for i in 2 4 8;
do
        echo "Running lab2-1 with $i threads:"
        export OMP_NUM_THREADS="$i"
        nvprof ./bin/lab2-1 2> cuda_prof_$i.txt;
        echo ""
done

echo "Running lab2-2 with offset:"
nvprof ./bin/lab2-2o 2> cuda_prof_off.txt;
echo ""
echo "Running lab2-2 with stride:"
nvprof ./bin/lab2-2s 2> cuda_prof_stride.txt;
