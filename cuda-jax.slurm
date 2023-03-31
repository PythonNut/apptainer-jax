#!/bin/bash

#SBATCH --job-name=cuda-jax-build
#SBATCH --account=stf
#SBATCH --partition=compute
#SBATCH --requeue
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=5:00:00
#SBATCH --mem=16G
#SBATCH --export=all

module load apptainer
module load cuda/11.8.0
export APPTAINER_CACHEDIR=/scr APPTAINER_TMPDIR=/scr
apptainer build --fakeroot /scr/cuda-jax.sif cuda-jax.def
mv -v /scr/cuda-jax.sif .
