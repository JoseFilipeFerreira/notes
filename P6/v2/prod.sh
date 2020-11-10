#!/bin/sh
#PBS -N PROD
#PBS -l walltime=00:01:00,nodes=1:ppn=1
#PBS -q acomp

module load gcc/5.3.0
module load papi/5.4.1

cd $PBS_O_WORKDIR

./prod $1

