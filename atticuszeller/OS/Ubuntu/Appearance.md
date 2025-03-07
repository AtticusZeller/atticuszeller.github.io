# Appearance

## Fonts

Install __bold__ [[OS/Ubuntu/Terminal#Install Fonts|Nerd Fonts]] and [[OS/Ubuntu/Gnome#Tweaks|Tweak]] your system fonts, sharp and slim fonts would easy your eyes.

> `Comic Sans MS` in obsidian looks like handwriting fonts.

## Theme

1. [theme\_manager.sh](https://github.com/AtticusZeller/scripts/blob/main/theme_manager.sh)
2. [WhiteSur-gtk-theme](https://github.com/vinceliuice/WhiteSur-gtk-theme)

### Basic Extension

- [user-themes](https://extensions.gnome.org/extension/19/user-themes/) to enable gnome-shell theme (and not just the application theme)
- [dash-to-dock](https://extensions.gnome.org/extension/307/dash-to-dock)
- [blur-my-shell](https://extensions.gnome.org/extension/3193/blur-my-shell)

### Install

```bash
git clone git@github.com:vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSure-gtk-theme
```

```bash
./install.sh --libadwaita \
-c Dark \
-t blue \
--gnome-shell \
--round
```

> [!NOTE]
> enable solid one in `Tweaks`

Flatpak

```bash
sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
```

### Tweak

Firefox , GDE, Flatpak

```bash
./tweaks.sh -F \
-f \
--dash-to-dock \
--color Dark \
--theme blue
```

Lock Screen

```bash
sudo ./tweaks.sh -g -N
```

## Icons

[GitHub - vinceliuice/WhiteSur-icon-theme: MacOS Big Sure style icon theme for linux desktops](https://github.com/vinceliuice/WhiteSur-icon-theme)

```bash
git clone git@github.com:vinceliuice/WhiteSur-icon-theme.git
cd WhiteSure-icon-theme
./install.sh -a -b
```

## Cursors

```bash
git clone git@github.com:vinceliuice/McMojave-cursors.git
cd McMojave-cursors
sudo ./install.sh
```

## Wallpaper

![[assets/Pasted image 20241126135048.png]]
[OneDrive share link](https://1drv.ms/f/s!ApUonPPT2w2F1cQRzAErW2pdi_c0fA?e=X51X5Y)
