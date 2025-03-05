# Powershell

## [Oh My Posh](https://ohmyposh.dev/docs/installation/windows)

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
oh-my-posh font install
code  $PROFILE
```

```txt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\peru.omp.json" | Invoke-Expression
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Import-Module Terminal-Icons
```

set `powershell` as default instead of `windows powershell`
set front in config-> default -> appearance

[GitHub - marticliment/UniGetUI: UniGetUI: The Graphical Interface for your package managers. Could be terribly described as a package manager manager to manage your package managers](https://github.com/marticliment/UniGetUI)

```Powershell
winget install --exact --id MartiCliment.UniGetUI --source winget
```

## Tips

### __kill__ The Process by PID

```powershell
taskkill /PID <PID> /F
```

### Find out the Process Occupied the __port__

_the last line of output is PID_

```powershell
netstat -ano | findstr :<port>
```

### Find out the Process Occupied the __file__

[Sysinternals Suite - Microsoft Apps](https://www.microsoft.com/store/productId/9P7KNL5RWT25?ocid=pdpshare)

```powershell
handle.exe <file path>
```

### Get Command .exe Path

```PowerShell
where.exe poetry
```

`->C:\Users\18317\AppData\Roaming\Python\Scripts\poetry.exe`

### Add Path

_admin_

```powershell
# use Tab to autocomlete to make sure path exit
$newPath = "C:\Program Files\xpdf-tools-win-4.05\bin64"
$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*$newPath*") {
    $updatedPath = $currentPath + ";" + $newPath
    [Environment]::SetEnvironmentVariable("Path", $updatedPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Output "Path added successfully."
} else {
    Write-Output "Path already exists in the system PATH."
}
# check path
[Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine) -split ";"
```



### Using `bash` to handle shell 


1. add `"C:\Program Files\Git\bin"` into `PATH` in windows, then `bash`
2. append settings of `vscode` 
```json
{
	"terminal.integrated.env.windows": {
		"PATH": "${env:PATH};C:\\Program Files\\Git\\bin"
	}
}
```