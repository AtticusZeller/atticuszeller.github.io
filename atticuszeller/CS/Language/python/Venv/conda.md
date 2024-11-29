# Conda


## Install Conda

1. install by wget

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
# note it may show that conda installed in /root/miniconda3
```

> remember set no to auto activate in your shell if u use poetry,etc to manage py-env

1. add `/root/miniconda3/bin` to `PATH` in `/etc/environment`

```bash
PATH="/root/miniconda3/bin:"
source /etc/environment
# or
export PATH="/root/miniconda3/bin:$PATH"
```

1. test conda

```bash
conda info
```

1. optional, enable auto activate conda

```bash
conda config --set auto_activate_base true
```

> repeat to warn `conda init` ,try `conda init <shell>`

## Channels

- 3rd

```bash
conda config --add channels conda-forge
conda config --set channel_priority strict
```

```bash
conda config --show channels
```

- search

```bash
conda search cudnn --channel conda-forge
```

## Install Deps

- install from environment.yml

```bash
conda env create -f environment.yml
```

- output current env deps to environment.yml

```bash
conda env export --from-history > environment.yml
```

- update from environment.yml `--prune` for auto update deps

```bash
conda env update -f environment.yml
```

- install by auto update deps

```bash
conda install <package> --update-all
```

## Info Check

- show conda info

```bash
conda info
```

- show all conda envs

```bash
conda env list
```

- current env packages

```bash
conda list
```

- specified env packages

```bash
conda list -n <env>
```
