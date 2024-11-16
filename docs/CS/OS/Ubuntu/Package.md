# Package

[official tutorial](https://help.ubuntu.com/community/Repositories/Ubuntu)

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

## [Deb-Get](https://github.com/wimpysworld/deb-get)

Deb-Get is a tool for installing `.deb` packages, particularly useful for obtaining software from platforms like GitHub.

### Installing Deb-Get

```bash
sudo apt install curl lsb-release wget
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
```

### Configuring GitHub PAT (Personal Access Token)

1. Create a PAT on GitHub: Settings > Developer settings > Personal access tokens
2. Set environment variable:

   ```bash
   echo 'export DEBGET_TOKEN=your_token_here' >> ~/.zshrc
   source ~/.zshrc
   ```

### Basic Usage

- Search for software: `deb-get search <package>`
- Install software: `sudo deb-get install <package>`
- Update all software: `deb-get update && deb-get upgrade`

### [Adding External Repositories](https://github.com/wimpysworld/deb-get/tree/main?tab=readme-ov-file#adding-external-repositories)

Assume we have created a remote repository called `deb-get-index` belonging to user `Atticuszz`,with a structure looks like:

> [!EXAMPLE]
>
>```bash
>.
>└── 02-github
>	├── manifest
>	└── packages
>		└── <your_packages>
>```

- first line in `manifest` is same to the `02-github.repo` ,then each line is `<your_packages>`
- `<your_packages>` should be created follow the [deb-get/EXTREPO.md](https://github.com/wimpysworld/deb-get/blob/main/EXTREPO.md)

So, we create `02-github.repo` locally and put into our `url`

```bash
sudo touch /etc/deb-get/02-github.repo
sudo curl -s "https://raw.githubusercontent.com/Atticuszz/deb-get-index/main/02-github/manifest" | sudo tee /etc/deb-get/02-github.repo > /dev/null
```

Finally, update local index

```bash
deb-get update
```

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

> [!Bug] BUGs
>  1. use `flatpak-spawn --host --env=TERM=xterm-256color zsh` as shell path in `pycharm` [Can't use zsh in terminal · Issue #23 · flathub/com.jetbrains.IntelliJ-IDEA-Ultimate · GitHub](https://github.com/flathub/com.jetbrains.IntelliJ-IDEA-Ultimate/issues/23)

## [Homebrew](https://docs.brew.sh/Homebrew-on-Linux)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
