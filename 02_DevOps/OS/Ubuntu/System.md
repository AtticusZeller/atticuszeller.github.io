# System

## System

### [Install](https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview)

1. download `ios file` [Download Ubuntu Desktop | Download | Ubuntu](https://ubuntu.com/download/desktop)
2. download `Flash OS images app`[balenaEtcher - Flash OS images to SD cards & USB drives](https://etcher.balena.io/)
3. let device start by the __flashed__ drivers

### Ignore Lid Switch

```bash
sudo nano /etc/systemd/logind.conf
# make sure
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
# then run
sudo systemctl restart systemd-logind
```

### Lock Screen on Lid Switch

```bash
sudo nano /etc/systemd/logind.conf
# make sure
HandleLidSwitch=lock
# then run
sudo systemctl restart systemd-logind
```

settings-> power, disable automatic suspend

> aim to prevent to fail to wake up ,black screen on Ubuntu + Nivida

### [usermod](https://phoenixnap.com/kb/usermod-linux)

add into `sudo` group

```bash
sudo usermod -aG sudo yourusername
# check it
groups yourusername
```

### [Sudoers](https://help.ubuntu.com/community/Sudoers)

avoid be asked input passwd call `sudo` every time

```bash
sudo visudo
# fine the line begin with %sudo and replace it
%sudo ALL=NOPASSWD: ALL
```

### SSH Server

#### Install and Enable

```bash
sudo apt update
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
sudo systemctl status ssh
```

#### Add Ssh Key

copy your key

```bash
cat ~/.ssh/id_ed25519.pub
```

write into ssh server

```bash
echo "your key content" >> ~/.ssh/authorized_keys
```

#### Add Ssh Config(optional)

```bash
code ~/.ssh/config
```

write the following into ssh config

```bash
Host ubuntu-laptop
	Hostname 192.168.0.107
	Port 22
	User root
```

we assume `192.168.0.107` is your ssh server IP which could be found after running `ifconfig`

#### Connect

```bash
# == ssh root@192.168.0.107
ssh ubuntu-laptop
```

### Current User

```bash
 whoami
```

change folder owner to current user

```bash
sudo chown -R $USER:$USER ~/DevSpace/repo/.venv
```

### Display Server

enable [wayland](https://linuxconfig.org/how-to-enable-disable-wayland-on-ubuntu-22-04-desktop)

```bash
code /etc/gdm3/custom.conf
# WaylandEnable=true
```

### Service

#### Service

> [!TIP] service.type
> It is recommended to use Type=exec for __long-running__ services, as it ensures that process setup errors (e.g. errors such as a missing service executable, or missing user) are properly tracked.[\[1\]](https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html#Type=)

```bash
journalctl --since "2025-01-14 08:09:00" --until "2025-01-14 08:09:30"
```

### CPU Mode

```bash
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | sort | uniq
```

the output is __powersave__/__performance__

enable performance via `cpupower`

```bash
sudo apt-get install linux-tools-common
cpupower frequency-info # Check available governors
sudo cpupower frequency-set -g performance # Set governor with root permissions
```

[^1]

## Basic Tools for Desktop

### Browser

#### [FireFox](https://launchpad.net/~mozillateam/+archive/ubuntu/ppa)

```bash
sudo snap remove firefox
```

```bash
sudo add-apt-repository ppa:mozillateam/ppa -y
# ignore snap firefox
echo 'Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update
sudo apt install firefox
```

#### Settings

1. enable Ctrl+Tab cycles through tabs in recently used order
2. Fonts settings

[PWA plugin](https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/) failed to work on my ubuntu 24.04 now

### Chrome

Setup key with:

```bash

mkdir /etc/apt/keyrings
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/keyrings/google.asc >/dev/null

```

Setup repository with:

```bash
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.asc] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
```

Setup package with:

```bash
sudo apt-get update
sudo apt-get install google-chrome-stable
```

### Use Eye Protection Mode

setting-> display-> night light

### Keyboard

```bash
sudo apt install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk4 fcitx5-frontend-gtk3 fcitx5-frontend-qt5
```

- add `fcitx5` into `Startup Applications` in `gnome-tweaks`
- run `im-config` and add `pinyin` input method

switch input method by pressing `ctrl+space`

#### Theme

![](https://github.com/thep0y/fcitx5-themes-candlelight/raw/main/images/mac-light.png)
![](https://github.com/thep0y/fcitx5-themes-candlelight/raw/main/images/mac-dark.png)

```bash
git clone https://github.com/thep0y/fcitx5-themes-candlelight.git
mkdir -p ~/.local/share/fcitx5/themes
cp -r fcitx5-themes-candlelight/macOS-light ~/.local/share/fcitx5/themes/
cp -r fcitx5-themes-candlelight/macOS-dark ~/.local/share/fcitx5/themes/
```

select the theme in `addons->Classic User Interface`
[^2][^3]

### System Backup

```bash
sudo apt-get update
sudo apt-get install timeshift
```

### Clipboard

[GitHub - Tudmotu/gnome-shell-extension-clipboard-indicator: The most popular clipboard manager for GNOME, with over 1M downloads](https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator)

[Clipboard Indicator - GNOME Shell Extensions](https://extensions.gnome.org/extension/779/clipboard-indicator/)

[Custom Shortcuts](https://esite.ch/2015/07/using-custom-shortcuts-of-de-as-diodon-hotkey/) `setting->Keyboard->Keyboard Shortcuts->Custom Shortcuts` set as `win+alt+v`

### OCR to Clipboard

[GitHub - tesseract-ocr/tesseract: Tesseract Open Source OCR Engine (main repository)](https://github.com/tesseract-ocr/tesseract)

```bash
sudo apt-get update
sudo apt-get install tesseract-ocr xclip gnome-screenshot

cd DevSpace
git clone git@github.com:Atticuszz/scripts.git
sudo chmod +x ./scripts/ocr_clipboard.sh
```

[scripts/ocr\_clipboard.sh at main · Atticuszz/scripts · GitHub](https://github.com/Atticuszz/scripts/blob/main/ocr_clipboard.sh)
`setting->keyboard->shortcuts`

- command :`~/DevSpace/ocr_clipboard.sh`
- shortcuts : `ctrl+win+Q`

### Gpu Monitor

```bash
uv tool install nvitop
```

### CPU ,RAM, SWAP Monitor

```bash
sudo apt install htop
```

### Clean Hard Driver

```bash
sudo apt install ncdu
```

### Fan Mode

use `Legion` in windows to set mode

### AppImage

[I get some errors related to something called “FUSE” — AppImage  documentation](https://docs.appimage.org/user-guide/troubleshooting/fuse.html#setting-up-fuse-2-x-alongside-of-fuse-3-x-on-recent-ubuntu-22-04-debian-and-their-derivatives)

```bash
sudo apt install libfuse2
```

### Install .tar.gz

```bash
tar -xzf filepath
```

### Apt Source Change

```bash
sudo nano /etc/apt/sources.list
sudo apt update
sudo apt upgrade
```

### Dual System Extend Disk for Ubuntu

[tutorial](https://blog.csdn.net/jayoungo/article/details/105598613#:~:text=Windows%20%2B%20Linux%20%28Ubuntu%29%E5%8F%8C%E7%B3%BB%E7%BB%9F%E6%89%A9%E5%B1%95Linux%E7%A3%81%E7%9B%98%E7%A9%BA%E9%97%B4%201%20%E9%87%8D%E8%A6%81%EF%BC%81%201.%20%E6%89%A7%E8%A1%8C%E7%A1%AC%E7%9B%98%E5%88%86%E5%8C%BA%E4%BF%AE%E6%94%B9%E6%93%8D%E4%BD%9C%E5%89%8D%E5%BB%BA%E8%AE%AE%E5%A4%87%E4%BB%BDWindows%E5%8F%8ALinux%E7%B3%BB%E7%BB%9F%E9%87%8D%E8%A6%81%E6%96%87%E4%BB%B6%EF%BC%8C%E4%BB%A5%E9%98%B2%E6%93%8D%E4%BD%9C%E5%A4%B1%E8%B4%A5%E5%AF%BC%E8%87%B4,%E6%8F%92%E5%85%A5%E6%AD%A5%E9%AA%A4%E4%B8%80%E5%88%9B%E5%BB%BA%E7%9A%84%E5%8F%AF%E5%90%AF%E5%8A%A8U%E7%9B%98%202.%20...%205%20%E5%8F%82%E8%80%83%E8%B5%84%E6%96%99%20http%3A%2F%2Fjoejanuszk.com%2Fblog%2Fincreasing-ubuntu-partition-size-dual-boot-windows%20%E6%96%87%E7%AB%A0%E5%9C%B0%E5%9D%80%EF%BC%9Ahttps%3A%2F%2Fblog.csdn.net%2Fjayoungo%2Farticle%2Fdetails%2F105598613%20%E8%BD%AC%E8%BD%BD%E8%AF%B7%E6%B3%A8%E6%98%8E%E5%87%BA%E5%A4%84%E3%80%82)

### Increase Swap Space via Swap File

[_extend to 16gb for example_](https://askubuntu.com/questions/178712/how-to-increase-swap-space)

```bash
sudo swapoff -a
sudo fallocate -l 16G /swapfile
# if failed fallocate try
sudo dd if=/dev/zero of=/swapfile bs=1G count=16

# then
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make it permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# test it
swapon --show
->
❯ swapon --show

NAME      TYPE SIZE USED PRIO
/swapfile file  16G   0B   -2
```

### Zip File

Note:

- The `-r` option stands for "recursive" and tells `zip` to include all files and `subfolders` in the specified folder.
- If you want to exclude certain files or folders, you can use the `-x` option followed by the file or folder name. For example:

```bash
zip -r myfolder.zip myfolder -x myfolder/excluded_file.txt
```

### OneDrive

[onedrive/docs/ubuntu-package-install.md at master · abraunegg/onedrive · GitHub](https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md#distribution-ubuntu-2404)

install

```bash
sudo apt remove onedrive
sudo rm /etc/systemd/user/default.target.wants/onedrive.service
wget -qO - https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /usr/share/keyrings/obs-onedrive.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/obs-onedrive.gpg] https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_24.10/ ./" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt-get update
sudo apt install --no-install-recommends --no-install-suggests onedrive
```

#### Login

```bash
onedrive
```

#### Config

```bash
code ~/.config/onedrive
```

and fill it with following:

```
# sync home

sync_dir = "~"

# Skip dot files

skip_dotfiles = "true"

# Skip github sync dir

skip_dir = "DevSpace"
skip_dir = "miniconda3"
skip_dir = "NVIDIA Nsight Compute"
skip_dir = "snap"
skip_dir = "cache"
skip_dir = "temp"

# upload_only = "true"

# https://github.com/abraunegg/onedrive/blob/master/docs/application-config-options.md#monitor_interval
monitor_interval = "600"

threads = "16"
```

#### [Usage](https://github.com/abraunegg/onedrive/blob/master/docs/usage.md#first-steps)

once

```bash
onedrive --sync --verbose
```

monitor

```bash
onedrive --monitor
```

monitor as startup

```bash
...
```

### [Compatibility with curl](https://github.com/abraunegg/onedrive/blob/master/docs/usage.md#compatibility-with-curl)

```bash
brew install curl
echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/curl/bin:$PATH"' >> ~/.zshrc
echo 'export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/opt/curl/lib:$LD_LIBRARY_PATH"' >> ~/.zshrc
```

### Zotero

[GitHub - retorquere/zotero-deb: Packaged versions of Zotero and Juris-M for Debian-based systems](https://github.com/retorquere/zotero-deb)

```bash
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
sudo apt install zotero
```

### [spotify](https://www.spotify.com/uk/download/linux/)

```bash
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
```

[^1]: [Simulation Performance and Tuning — Isaac Lab Documentation](https://isaac-sim.github.io/IsaacLab/main/source/how-to/simulation_performance.html)
[^2]: [GitHub - fcitx/fcitx5: Next generation of fcitx, cross-platform input method framework.](https://github.com/fcitx/fcitx5)
[^3]: [GitHub - thep0y/fcitx5-themes-candlelight: fcitx5的简约风格皮肤——烛光。](https://github.com/thep0y/fcitx5-themes-candlelight.git)
