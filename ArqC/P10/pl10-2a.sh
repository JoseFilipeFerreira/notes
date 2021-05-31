#!/bin/sh
#PBS -N PL10-2
#PBS -l walltime=00:01:00,nodes=1:ppn=32
#PBS -q acomp

module load gcc/5.3.0

cd $PBS_O_WORKDIR

if [[ -z $1 ]]; then
  export OMP_NUM_THREADS=8
  echo "Setting nbr of threads to 8";
else
  export OMP_NUM_THREADS=$1
fi

./pl10-2a

