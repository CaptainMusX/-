param(
    [string]$TaskName = "AbleSci Auto Sign"
)

$ErrorActionPreference = "Stop"
$runner = Join-Path $PSScriptRoot "run_local.ps1"

$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$runner`""

$triggers = @(
    (New-ScheduledTaskTrigger -Daily -At "07:40"),
    (New-ScheduledTaskTrigger -Daily -At "21:40")
)

$settings = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries

Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $action `
    -Trigger $triggers `
    -Settings $settings `
    -Description "科研通自动签到（本地兜底，不依赖 GitHub Actions）"

Write-Host "已注册计划任务：$TaskName"
Write-Host "请先在仓库根目录创建 .env（参考 .env.example），再手动运行一次 scripts\run_local.ps1 验证。"
