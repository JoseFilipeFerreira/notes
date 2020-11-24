#!/bin/sh

module load intel/2019
module load gcc/5.3.0
module load papi/5.4.1

cd $PBS_O_WORKDIR

source /share/apps/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/linux/bin/compilervars.sh intel64

echo "Compiling..."

make

echo "Running the vtune tests"

/share/apps/intel/vtune_amplifier_2018/bin64/amplxe-cl -c hotspots -r vtune_results /home/a83683/AA/F02/bin/lab1 8 1

echo "Running the workload tests"

for tc in 1 2 4 8; do

echo "Running with $tc threads"

/home/a83683/AA/F02/bin/lab1 "$tc" 1

done
echo "You can now view timings.dat"
