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

### Add Personal Repo

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
- Add two secrets:
  - `GPG_PRIVATE_KEY`: private key content
  - `GPG_PASSPHRASE`: key passphrase

Update CI config (.github/workflows/build.yml):

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Import GPG key
        run: |
          echo "${{ secrets.GPG_PRIVATE_KEY }}" | gpg --batch --import
          echo "allow-preset-passphrase" > ~/.gnupg/gpg-agent.conf
          gpg-connect-agent RELOADAGENT /bye
          echo "${{ secrets.GPG_PASSPHRASE }}" | gpg --batch --yes --pinentry-mode loopback --passphrase-fd 0 --sign --armor --output /dev/null /dev/null

      - name: Update Repository
        run: |
          mkdir -p {pool,dists,version-lock}/

          for config in configs/*.json; do
            echo "Processing config: $config"
            bash scripts/build-repo.sh "$config"
          done

          bash scripts/build-repo.sh --generate-metadata
```

1. Update generate_repo_metadata function:

```bash
generate_repo_metadata() {
    ROOT_DIR="$(cd "$(dirname "$(dirname "$0")")" && pwd)"
    CONF_FILE="${ROOT_DIR}/apt-ftparchive.conf"

    for arch in amd64 arm64 armhf; do
        mkdir -p "dists/stable/main/binary-${arch}"
        if ls pool/*/*_${arch}.deb 1> /dev/null 2>&1; then
            dpkg-scanpackages --arch ${arch} pool/ > "dists/stable/main/binary-${arch}/Packages"
            gzip -k -f "dists/stable/main/binary-${arch}/Packages"
        fi
    done

    cd dists/stable
    apt-ftparchive -c "${CONF_FILE}" release . > Release

    # Sign with imported GPG key
    gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --clearsign -o InRelease Release
    gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" -abs -o Release.gpg Release

    cd ../..
}
```

1. Add public key to repo (e.g. in `public-key.asc`)
2. Users can import the key:

```bash
curl -fsSL https://your-repo-url/public-key.asc | sudo apt-key add -
```

1. Users can then add repo without `[trusted=yes]`:

```
deb https://username.github.io/repo-name stable main
```

Key steps:
1. Generate GPG key pair
2. Configure GitHub Secrets
3. Update CI to import key
4. Update scripts to sign with key
5. Publish public key
6. Users import public key

Remember to keep private key and passphrase secure.

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
> ├── manifest
> └── packages
>  └── <your_packages>
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
