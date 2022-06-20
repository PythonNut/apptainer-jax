#!/bin/bash

#SBATCH --job-name=cuda-jax-build
#SBATCH --account=stf
#SBATCH --partition=compute
#SBATCH --requeue
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=5:00:00
#SBATCH --mem=64G
#SBATCH --export=all

module load apptainer
export APPTAINER_CACHEDIR=/scr APPTAINER_TMPDIR=/scr
apptainer build --fakeroot /scr/cuda-jax.sif cuda-jax.def
mv -v /scr/cuda-jax.sif .
