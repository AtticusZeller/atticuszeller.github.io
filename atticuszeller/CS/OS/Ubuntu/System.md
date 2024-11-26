# System

## System

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

### Change Password

```powershell
# admin
wsl -u root
passwd %username% # empty for root
```

### Upgrade to Root

```shell
usermod -aG sudo %username%
sudo chown -R %username%  %filepath%
# sudo chown -R atticuszz /etc/

```

## Basic Tools for Desktop

### Browse

#### [FireFox](https://www.omgubuntu.co.uk/2022/04/how-to-install-firefox-deb-apt-ubuntu-22-04)

```bash
sudo snap remove firefox
```

```bash
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt update && sudo apt remove FireFox
sudo apt install firefox
```

[PWA plugin](https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/)

### Use Eye Protection Mode

setting-> display-> night light

### Keyboard

```bash
sudo apt-get update
sudo apt-get install ibus ibus-pinyin ibus-libpinyin
```

> [!WARNING]
> remember to reboot and add input resources in `setting->keyboard`

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

### Gpu Monito

```bash
conda install -c conda-forge nvtop
```

### Fan Mode

use `Legion` in windows to set mode

### Screenshot

[Snipaste Downloads](https://www.snipaste.com/download.html)

```bash
sudo apt-get update
sudo apt-get install fuse
chmod +x /home/atticuszz/Downloads/Snipaste-2.8.9-Beta-x86_64.AppImage
/home/atticuszz/Downloads/Snipaste-2.8.9-Beta-x86_64.AppImage --appimage-extract
# create desktop app then
mkdir -p ~/.config/autostart/
cp ~/Desktop/Snipaste.desktop ~/.config/autostart/
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

[Windows + Linux(Ubuntu)双系统扩展Linux磁盘空间\_双系统下 windows 为 ubuntu 扩充新空间 | linux 扩容原理介绍 + 填坑-CSDN博客](https://blog.csdn.net/jayoungo/article/details/105598613#:~:text=Windows%20%2B%20Linux%20%28Ubuntu%29%E5%8F%8C%E7%B3%BB%E7%BB%9F%E6%89%A9%E5%B1%95Linux%E7%A3%81%E7%9B%98%E7%A9%BA%E9%97%B4%201%20%E9%87%8D%E8%A6%81%EF%BC%81%201.%20%E6%89%A7%E8%A1%8C%E7%A1%AC%E7%9B%98%E5%88%86%E5%8C%BA%E4%BF%AE%E6%94%B9%E6%93%8D%E4%BD%9C%E5%89%8D%E5%BB%BA%E8%AE%AE%E5%A4%87%E4%BB%BDWindows%E5%8F%8ALinux%E7%B3%BB%E7%BB%9F%E9%87%8D%E8%A6%81%E6%96%87%E4%BB%B6%EF%BC%8C%E4%BB%A5%E9%98%B2%E6%93%8D%E4%BD%9C%E5%A4%B1%E8%B4%A5%E5%AF%BC%E8%87%B4,%E6%8F%92%E5%85%A5%E6%AD%A5%E9%AA%A4%E4%B8%80%E5%88%9B%E5%BB%BA%E7%9A%84%E5%8F%AF%E5%90%AF%E5%8A%A8U%E7%9B%98%202.%20...%205%20%E5%8F%82%E8%80%83%E8%B5%84%E6%96%99%20http%3A%2F%2Fjoejanuszk.com%2Fblog%2Fincreasing-ubuntu-partition-size-dual-boot-windows%20%E6%96%87%E7%AB%A0%E5%9C%B0%E5%9D%80%EF%BC%9Ahttps%3A%2F%2Fblog.csdn.net%2Fjayoungo%2Farticle%2Fdetails%2F105598613%20%E8%BD%AC%E8%BD%BD%E8%AF%B7%E6%B3%A8%E6%98%8E%E5%87%BA%E5%A4%84%E3%80%82)

### Increase Swap Space via Swap File

_extend to 16gb for example_
[How to increase swap space? - Ask Ubuntu](https://askubuntu.com/questions/178712/how-to-increase-swap-space)

_extend to 16gb for example_

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

threads = "64"
```

#### [Usage](https://github.com/abraunegg/onedrive/blob/master/docs/usage.md#first-steps)

once

```bash
onedrive --sync --verbose --resync
```

monitor

```bash
onedrive --monitor
```

monitor as startup

```bash
...
```

### Zotero

[GitHub - retorquere/zotero-deb: Packaged versions of Zotero and Juris-M for Debian-based systems](https://github.com/retorquere/zotero-deb)

```bash
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
sudo apt install zotero
```

### LibreOffice

theme [LibreOffice • Dracula Theme](https://draculatheme.com/libreoffice)
