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
find /opt/intel -name libmpi.so.12
cat /opt/intel/bin/compilervars.sh
source /opt/intel/bin/compilervars.sh intel64 
export SINGULARITYENV_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
echo $SINGULARITYENV_LD_LIBRARY_PATH
cmd=$(eval echo "${SHIPYARD_SINGULARITY_COMMAND}")
echo $cmd
mpirun -hosts $AZ_BATCH_HOST_LIST -perhost 1 -np $nodes $cmd /usr/bin/a.out
