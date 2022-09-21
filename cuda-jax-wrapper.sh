#!/bin/env bash

if command -v module &> /dev/null; then
    module load apptainer
    module load cuda/11.6.2
fi

scriptdir="$(dirname -- $(readlink -f $BASH_SOURCE))";

typeset -a mounts=(
    /gscratch
    /data
    /mmfs1
    /sw
    /run/munge
    /var/spool/slurmd/conf-cache
)

mount_flags=()
for m in ${mounts[@]}; do
    if [[ -d "$m" ]]; then
        mount_flags+=(-B)
        mount_flags+=("$m")
    fi
done

apptainer run ${mount_flags[@]} --nv $scriptdir/cuda-jax.sif "$@"
