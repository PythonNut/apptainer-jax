set -o errexit

export DEBIAN_FRONTEND=noninteractive
sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list
apt update
apt install -y nvidia-smi slurm-wlm libslurm-dev libslurm-perl libslurmdb-perl slurm-wlm-basic-plugins-dev git gcc gcc-multilib strace gdb
apt clean
export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/slurm-wlm/:$LIBRARY_PATH

mkdir -p /run/slurm /etc/slurm
ln -s /var/spool/slurmd/conf-cache/ /run/slurm/conf
ln -s /var/spool/slurmd/conf-cache/ /etc/slurm

eval "$(micromamba shell hook --shell=bash)"
micromamba create -n cuda-jax
micromamba install -q -y -n cuda-jax -f env.yml
micromamba clean --all --yes
micromamba activate cuda-jax

poetry install
