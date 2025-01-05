# Terminal

## Zsh and Oh My ZSH

> __Oh My Zsh__ is a framework for [Zsh](https://www.zsh.org), the Z shell.[\[1\]](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

### [Install ohmyzsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation)

```bash
sudo apt install zsh
# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install Fonts

> [!INFO] Nerd-fonts
> __Nerd Fonts__ is a project that patches developer targeted fonts with a high number of glyphs (icons). Specifically to add a high number of extra glyphs from popular 'iconic fonts' such as [Font Awesome](https://github.com/FortAwesome/Font-Awesome), [Devicons](https://github.com/devicons/devicon), [Octicons](https://github.com/primer/octicons), and [others](https://github.com/ryanoasis/nerd-fonts#glyph-sets).[\[2\]](https://github.com/ryanoasis/nerd-fonts)

download and update cache

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm JetBrainsMono.tar.xz
fc-cache -fv
```

select `JetBrainsMono <Nerd fonts> ` in `preferences-->profiles->Text->Custom font`

restart terminal and test icons

```bash
echo -e "\ue62b \uf296 \ue62b"
```

![[assets/Pasted image 20250105150327.png|200]]

### [Install Theme](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh)

> [!WARNING] `Nerd-fonts` is prepared for displaying the `powerlevel10k` icon

```bash
# install as oh-my-zsh plugin
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Open `~/.zshrc`, find the line that sets `ZSH_THEME`, and change its value to `"powerlevel10k/powerlevel10k"` as following:

```text
# correct the old ZSH_THEME or can not find p10k command
ZSH_THEME="powerlevel10k/powerlevel10k"
```

then restart terminal and config themes

```bash
p10k configure
```

🥳
![[assets/Pasted image 20250105153158.png]]

### Install Plugins

> update plugins via `omz update` manually or it will prompt you to update sometimes

install extra plugin from GitHub

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
```

activate the _built-in_ or _extra_ plugins in `~/.zshrc`

```bash
plugins=(
    command-not-found
    extract
    docker
    history-substring-search
    web-search
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    ohmyzsh-full-autoupdate
)
```

> [!NOTE]
 > plugin config must before the `source $ZSH/oh-my-zsh.sh`

#### Command-not-found

this plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.

#### Extract

this plugin defines a function called `extract` that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.

#### History-substring-search

As its title, it's extremely useful for finding the previous executed command when you can only recall part of it.
Use ⬆️ or ⬇️ to match commands from history
![[assets/Pasted image 20250105170317.png]]

#### Web-search

open your browser with terminal search content
![[assets/Pasted image 20250105165205.png]]

#### Z

> Zsh-z is a command-line tool that allows you to jump quickly to directories that you have visited frequently or recently.[\[3\]](https://github.com/agkozak/zsh-z)

![[assets/Pasted image 20250105164146.png]]
1. `cd` needs the specific directory, _keywords_ of your directory which visited before is enough for `z`
2. `tab` with `z` show the scope that the _keywords_ would match.
![[assets/Pasted image 20250105164354.png]]

#### Zsh-autosuggestions

It suggests commands based on your _history_ of previous commands and completions
![[assets/Pasted image 20250105154644.png]]

#### Zsh-syntax-highlighting

Alert the wrong syntax with red color
![[assets/Pasted image 20250105155224.png]]

#### Zsh-bat

This plugin will replace `cat` with `bat`
![[assets/Pasted image 20250105162357.png|300]]

### VS Code Terminal Config

VS Code terminal, add these properties to the user `settings.json` to enable `zsh`
and `mono` fonts. you have to restart it to enable fonts.

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font Mono"
  "terminal.integrated.fontSize": 15,
  "terminal.integrated.shellIntegration.enabled": true,
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.defaultProfile.linux": "zsh"
}
```

## Shortcut

![[assets/Pasted image 20250105103733.png]]

## Reference

1. [The Only 5 Zsh Plugins You Need](https://catalins.tech/zsh-plugins/)
2. [ZSH + Oh My ZSH! on Windows with WSL](https://dev.to/equiman/zsh-on-windows-with-wsl-1jck)
3. [[Reference/linux/12 Linux Terminal Shortcuts Every Power Linux User Must Know|12 Linux Terminal Shortcuts Every Power Linux User Must Know]]
4. [Plugins-oh my zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
