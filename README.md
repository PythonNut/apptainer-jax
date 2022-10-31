# apptainer-jax
Apptainer "kitchen sink" ML environment using Poetry

# Building a new container with Slurm

```bash
sbatch cuda-jax.slurm
```

# Running the container

```
cuda-jax-wrapper.sh <program> <arg1> <arg2> ...
```

You may want to give `cuda-jax-wrapper.sh` a convenient name (and put it in your `PATH`).
