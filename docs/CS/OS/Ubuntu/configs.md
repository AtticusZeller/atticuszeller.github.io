# Configs

> ubuntu could be install via usb or wsl

## Install System

### Usb

- official tutorial[Install Ubuntu desktop | Ubuntu](https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview)

1. download `ios file` [Download Ubuntu Desktop | Download | Ubuntu](https://ubuntu.com/download/desktop)
2. download `Flash OS images app`[balenaEtcher - Flash OS images to SD cards & USB drives](https://etcher.balena.io/)
3. let device start by the __flashed__ drivers

### Wsl

- in Microsoft Store download `wsl` and `ubuntu 22`

### Connection

connect by vscode or gateway,wsl mode or ssh

#### Wsl

> before connection

remember to set default user as root for more power [set root](Learning/CS/OS/Ubuntu/wsl#set default user as root)
_optional: if docker installed ,set default wsl distro as ubuntu 22 by [set default distro](Learning/CS/OS/Ubuntu/wsl#set default distro)_

#### Native Ubuntu

_upgrade power_

1. add into `sudo` group

```bash
sudo usermod -aG sudo yourusername
# check it
groups yourusername
```

1. avoid be asked input passwd call `sudo` every time

```bash
sudo visudo
# fine the line begin with %sudo and replace it
%sudo ALL=(ALL) NOPASSWD: ALL
```

[ssh](Learning/CS/OS/Ubuntu/net#install ssh)
connect by ssh ,enter password first time and try to connect by ssh-key

## Initialization

### Set Proxies

> before any download from web, set proxies first for too slow speed

#### Wsl

[proxy](CS/OS/Ubuntu/wsl.md#proxy)

1. set shared proxies first!!

#### Native Ubuntu

1. run clash itself by [clash](CS/OS/Ubuntu/net.md#clash)
2. or in the same subnet ,share your clash proxy by open allow lan

### Basic Web Tools

```bash
sudo apt update
sudo apt upgrade
sudo apt install net-tools
sudo apt install curl
sudo apt-get update
sudo apt-get install unzip
```

### Shell

1. install `zsh` for friendly development experience [zsh](Learning/CS/OS/Ubuntu/shell#install zsh)
2. set auto read envs [auto read env](Learning/CS/OS/Ubuntu/shell#auto read envs)

### Code Envs

[code_env](CS/OS/Ubuntu/code_env.md)

- python, conda ,pip, poetry ,cmake…
