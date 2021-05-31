#!/bin/sh
#PBS -N LOOP
#PBS -l walltime=00:01:00,nodes=1:ppn=32
#PBS -q acomp

module load gcc/5.3.0
module load papi/5.4.1

cd $PBS_O_WORKDIR

echo
echo NO VEC KERNEL
echo
./novec-kernel $1

echo
echo VEC KERNEL
echo
./vec-kernel $1

