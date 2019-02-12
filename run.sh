#!/usr/bin/env bash

set -e

# get nodes and compute number of processors
IFS=',' read -ra HOSTS <<< "$AZ_BATCH_HOST_LIST"
ppn=$(nproc)
nodes=${#HOSTS[@]}
echo num nodes: $nodes
echo ppn: $ppn

# export env vars
export OMP_NUM_THREADS=$ppn

# execute
ls -ltra /opt/intel/compilers_and_libraries/linux/mpi/bin64/mpivars.sh
source /opt/intel/compilers_and_libraries/linux/mpi/bin64/mpivars.sh
cmd=$(eval echo "${SHIPYARD_SINGULARITY_COMMAND}")
echo $cmd
mpirun -hosts $AZ_BATCH_HOST_LIST -perhost 1 -np $nodes $cmd /usr/bin/a.out
