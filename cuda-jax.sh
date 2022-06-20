set -o errexit

export DEBIAN_FRONTEND=noninteractive
sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list
apt update
apt install -y nvidia-smi

eval "$(micromamba shell hook --shell=bash)"
micromamba create -n cuda-jax
micromamba install -q -y -n cuda-jax -f env.yml
micromamba clean --all --yes
micromamba activate cuda-jax
poetry install
