# code_env

## Install Cmake

```bash
sudo apt-get update
sudo apt-get install cmake
cmake --version
```

## Install Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
nano ~/.bashrc
# add it
export PATH="/root/.local/bin:$PATH"
source ~/.bashrc
poetry --version
```

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

## Install Node-js

```bash
cd ~/Downloads
mkdir ~/node
tar -xJvf node-v20.11.1-linux-x64.tar.xz -C ~/node

export PATH=~/node/node-v20.11.1-linux-x64/bin:$PATH
source ~/.zshrc
node -v
npm -v
```

## Vscode


[Running Visual Studio Code on Linux](https://code.visualstudio.com/docs/setup/linux#_updates)

```bash
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders
```
