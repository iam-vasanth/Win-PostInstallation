# Enable Execution Policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Update System
Write-Host "Updating Windows..." -ForegroundColor Green
winget upgrade --all

# Install Essential Apps
Write-Host "Installing Applications..." -ForegroundColor Green
$apps = @(
    "Mozilla.Firefox",
    "7zip.7zip",
    "Notepad++.Notepad++",
    "VideoLAN.VLC",
    "Git.Git",
    "Valve.Steam",
	"Python.Python.3.11"
	"9PF4KZ2VN4W9" #TransclucentTB,
	"9NBLGGH30XJ3" #XBOX accessories
)
foreach ($app in $apps) {
    winget install --id=$app --accept-source-agreements --silent
}

# Adds and activate Ultimate performance mode
Write-Host "Enabling Ultimate Performance Mode..." -ForegroundColor Green
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# Enable Developer Mode
Write-Host "Enabling Developer Mode..." -ForegroundColor Green
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /v AllowDevelopmentWithoutDevLicense /d 1 /f

# Disable Telemetry & Tracking
Write-Host "Disabling Windows Telemetry & Tracking..." -ForegroundColor Green
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

# Show File Extensions & Hidden Files
Write-Host "Showing File Extensions & Hidden Files..." -ForegroundColor Green
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f

# Disable OneDrive
Write-Host "Disabling OneDrive..." -ForegroundColor Green
taskkill /f /im OneDrive.exe
C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall

# Restart Explorer to Apply Changes
Write-Host "Restarting Explorer..." -ForegroundColor Green
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Setup Complete! Please restart your PC for full effect." -ForegroundColor Cyan
