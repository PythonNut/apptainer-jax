#!/bin/env bash

module load apptainer
module load cuda/11.6.2
scriptdir="$(dirname -- $(readlink $BASH_SOURCE))";
apptainer run -B /gscratch -B /mmfs1 -B /sw --nv $scriptdir/cuda-jax.sif "$@"
