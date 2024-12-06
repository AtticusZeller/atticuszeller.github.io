# Package

[Repositories official tutorial](https://help.ubuntu.com/community/Repositories/Ubuntu)

## APT (Advanced Package Tool)

### Basic Usage

- Update package list: `sudo apt update`
- Upgrade all packages: `sudo apt upgrade`
- Install software: `sudo apt install <package-name>`
- Uninstall software: `sudo apt remove <package-name>`
- Search for software: `apt search <keyword>`
- Display package information: `apt show <package-name>`

### Principles

APT is an advanced package management tool that uses dpkg as its backend. APT can:

- Resolve dependencies
- Fetch packages from configured sources
- Perform complex package management operations

### PPA Configuration

PPA (Personal Package Archive) allows developers and users to create their own software repositories.

- Add PPA: `sudo add-apt-repository ppa:<repository-name>`
- Remove PPA: `sudo add-apt-repository --remove ppa:<repository-name>`

PPA source files are located in the `/etc/apt/sources.list.d/` directory.

### Add Personal Repo
https://wiki.debian.org/DebianRepository/Format?action=show&redirect=RepositoryFormat
Here's how to configure GPG signing in CI:

Generate GPG key (locally):

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export-secret-key YOUR_KEY_ID > private.key
gpg --armor --export YOUR_KEY_ID > public.key
```

Add keys as GitHub Secrets:
- Go to repo Settings -> Secrets and variables -> Actions -> Repository secrets
- Add two secrets
	-  `GPG_PRIVATE_KEY`: private key content
	- `GPG_PASSPHRASE`: key passphrase

[GitHub - AtticusZeller/deb-index](https://github.com/AtticusZeller/deb-index)

## [Flatpak](https://flathub.org/)

Flatpak is a system for building and distributing desktop applications.

### Install Flatpak

```bash
sudo apt install flatpak
```

### Install the Software Flatpak Plugin

The Flatpak plugin for the Software app makes it possible to install apps without needing the command line. To install, run:

```bash
sudo apt install gnome-software-plugin-flatpak
```

> [!Note]
> the Software app is distributed as a Snap since Ubuntu 20.04 and does not support graphical installation of Flatpak apps. Installing the Flatpak plugin will also install a deb version of Software and result in two Software apps being installed at the same time.

### Add the Flathub Repository

Flathub is the best place to get Flatpak apps. To enable it, run:

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

### Restart

To complete setup, restart your system. Now all you have to do is [install some apps](https://flathub.org/)!

### Unsnap

[GitHub - popey/unsnap: Quickly migrate from using snap packages to flatpaks](https://github.com/popey/unsnap)

```bash
git clone git@github.com:popey/unsnap.git
cd unsnap
./unsnap auto
```

### Local Management

[GitHub - flattool/warehouse: A versatile toolbox for viewing flatpak info, managing user data, and batch managing installed flatpaks](https://github.com/flattool/warehouse)

```bash
flatpak install flathub io.github.flattool.Warehouse
```

### [Override](https://docs.flatpak.org/en/latest/flatpak-command-reference.html#flatpak-override)

global settings if no following with `flatpak list` got _Application ID_ like`com.example.App`

```bash
sudo flatpak override --filesystem=home
```

> [!Bug] BUG
>
> 1. use `flatpak-spawn --host --env=TERM=xterm-256color zsh` as shell path in `pycharm` [Can't use zsh in terminal · Issue #23 · flathub/com.jetbrains.IntelliJ-IDEA-Ultimate · GitHub](https://github.com/flathub/com.jetbrains.IntelliJ-IDEA-Ultimate/issues/23)

## [Homebrew](https://docs.brew.sh/Homebrew-on-Linux)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
