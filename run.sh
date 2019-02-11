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
cmd=$(eval echo "${SHIPYARD_SINGULARITY_COMMAND}")
mpirun -hosts $AZ_BATCH_HOST_LIST -perhost 1 -np $nodes $cmd /usr/bin/a.out
