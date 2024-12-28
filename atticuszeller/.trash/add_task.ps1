# 创建一个 .ps1 脚本文件
$scriptContent = @'
Start-Process -FilePath "C:\Users\18317\OneDrive\Downloads\mihomo-windows-amd64-v1.18.9\mihomo-windows-amd64.exe" -ArgumentList '-ext-ctl "127.0.0.1:9090"', '-f "C:\Users\18317\OneDrive\Proxy\config.yaml"' -WindowStyle Hidden
'@

# 保存到文件
$scriptContent | Out-File "$env:USERPROFILE\Documents\StartMihomo.ps1"

# 创建计划任务
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$env:USERPROFILE\Documents\StartMihomo.ps1`""
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName "Start Mihomo" -Action $action -Trigger $trigger -Principal $principal -Settings $settings
