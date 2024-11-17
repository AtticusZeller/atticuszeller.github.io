# SSH

_system: win11_
_in admin powershell_

## Start Ssh-agent

```powershell
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
```

## Generate Key-pair

```powershell
ssh-keygen -t ed25519 -C "1831768457@qq.com"
```

_in normal powersehll_

## Add Ssh-key-pair into Ssh-agent

```powershell
ssh-add C:\Users\18317\.ssh\id_ed25519
```

## Copy id_ed25519.pub into [github_ssh_setting](https://github.com/settings/keys) Set Auth Key Type

```powershell
cat ~/.ssh/id_ed25519.pub | clip
```

## Test Ssh Connect by Https

```shell
ssh -T -p 443 git@ssh.github.com
```

## Add Config

add the following text into `~/.ssh/config`

```text
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
```

## Test Test Ssh Connect

_you may need to enter yes as it's requiring to trust connection to github_

```powershell
ssh -T git@github.com
```

[Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
