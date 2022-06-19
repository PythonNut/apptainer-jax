set -o errexit

eval "$(micromamba shell hook --shell=bash)"
micromamba create -n cuda-jax
micromamba install -q -y -n cuda-jax -f env.yml
micromamba clean --all --yes
micromamba activate cuda-jax
poetry install
