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

sifname=cuda-jax.sif
tmpdir=/tmp

# if [[ $(state -c "%d" $scriptdir) != ]]
if [[ ! -f $tmpdir/$sifname || $tmpdir/$sifname -ot $scriptdir/$sifname ]]; then
    if [[ -z $SLURM_NNODES || $SLURM_NNODES == 1 ]]; then
        echo -n "copying SIF to local node using cp... " 1>&2
        cp $scriptdir/$sifname $tmpdir/$sifname
    else
        echo -n "copying SIF to local node using sbcast... " 1>&2
        sbcast $scriptdir/$sifname $tmpdir/$sifname
    fi
    echo done 1>&2
fi


apptainer -q run ${mount_flags[@]} --nv $tmpdir/cuda-jax.sif "$@"
