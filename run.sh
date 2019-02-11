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
mpirun -hosts $AZ_BATCH_HOST_LIST -perhost 1 -np $nodes singularity exec /usr/bin/a.out
