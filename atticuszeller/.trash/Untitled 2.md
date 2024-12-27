## Set up your terminal[​](#set-up-your-terminal "Direct link to Set up your terminal")

While Oh My Posh works on the standard terminal, we advise using the [Windows Terminal](https://github.com/microsoft/terminal).

info

To display all icons, we recommend the use of a [Nerd Font](https://ohmyposh.dev/docs/installation/fonts).

caution

When using oh-my-posh inside the WSL, make sure to follow the [Linux](https://ohmyposh.dev/docs/installation/linux) installation guide.

[![msstore](https://ohmyposh.dev/img/msstore-light.svg)](https://apps.microsoft.com/detail/xp8k0hkjfrxgck?mode=mini)

## Installation[​](#installation "Direct link to Installation")

- winget
- manual
- chocolatey

Open a PowerShell prompt and run the following command:

```
winget install JanDeDobbeleer.OhMyPosh -s winget
```

This installs a couple of things:

- `oh-my-posh.exe` - Windows executable
- `themes` - The latest Oh My Posh [themes](https://ohmyposh.dev/docs/themes)

info

For the `PATH` to be reloaded, a restart of your terminal is advised. If oh-my-posh is not recognized as a command, you can run the installer again, or add it manually to your `PATH`. For example:

```
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
```

Antivirus software

Due to frequent updates of Oh My Posh, Antivirus software occasionally flags it (false positive). To ensure Oh My Posh isn't blocked you can either report it to your favorite Antivirus software as false positive (e.g. [Report a false positive/negative to Microsoft for analysis](https://docs.microsoft.com/en-us/microsoft-365/security/defender/m365d-autoir-report-false-positives-negatives#report-a-false-positivenegative-to-microsoft-for-analysis)) or create an exclusion for it. Exclusions should be added with the full path to the executable, you can get it with the following command from a PowerShell prompt:

```
(Get-Command oh-my-posh).Source
```

## Next[​](#next "Direct link to Next")

Now that Oh My Posh is installed, you can go ahead and configure your terminal and shell to get the prompt to look exactly like you want.

- install a [font](https://ohmyposh.dev/docs/installation/fonts)
- configure your terminal/editor to use the installed font
- configure your shell to [use Oh My Posh](https://ohmyposh.dev/docs/installation/prompt)
- (optional) configure a theme or [custom prompt configuration](https://ohmyposh.dev/docs/installation/customize)

## Update[​](#update "Direct link to Update")

- winget
- manual
- chocolatey

Open a PowerShell prompt and run the following command:

```
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
```

## Default themes[​](#default-themes "Direct link to Default themes")

You can find the themes in the folder indicated by the environment variable `POSH_THEMES_PATH`. For example, you can use `oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression` for the prompt initialization in PowerShell.