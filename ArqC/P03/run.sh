for i in {1..3}; do qsub -N "Run1024v$i" -F "1024 $i" gemm.sh; done; qstat -u a83683
