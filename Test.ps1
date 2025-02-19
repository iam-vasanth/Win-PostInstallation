# Save the original execution policy
#$originalPolicy = Get-ExecutionPolicy

# Enable Execution Policy(Which temporarily allows scripts to run)
#Set-ExecutionPolicy Bypass -Scope Process -Force

$oldPolicy = Get-ExecutionPolicy; Set-ExecutionPolicy Bypass -Scope Process -Force; & "D:/Project/Win-PostInstallation/Test.ps1"; Set-ExecutionPolicy $oldPolicy -Scope Process -Force

# Script starts the process here
Write-Host "Running script..." -ForegroundColor Green

function Show-Menu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "  Windows 11 Post-Install CLI  🚀  " -ForegroundColor Yellow
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "1. Install Applications" -ForegroundColor Green
    Write-Host "2. Enable Ultimate Performance Mode" -ForegroundColor Green
    Write-Host "3. Enable Developer Mode" -ForegroundColor Green
    Write-Host "4. Disable Windows Telemetry" -ForegroundColor Green
    Write-Host "5. Show File Extensions & Hidden Files" -ForegroundColor Green
    Write-Host "6. Disable OneDrive" -ForegroundColor Green
    Write-Host "7. Update Windows" -ForegroundColor Green
    Write-Host "8. Exit" -ForegroundColor Red
    Write-Host "====================================" -ForegroundColor Cyan
}

function Show-AppMenu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "   Application Installation Menu    " -ForegroundColor Yellow
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "1. Install Google Chrome" -ForegroundColor Green
    Write-Host "2. Install Mozilla Firefox" -ForegroundColor Green
    Write-Host "3. Install Microsoft Edge" -ForegroundColor Green
    Write-Host "4. Install 7-Zip" -ForegroundColor Green
    Write-Host "5. Install Notepad++" -ForegroundColor Green
    Write-Host "6. Install VLC Media Player" -ForegroundColor Green
    Write-Host "7. Install Git" -ForegroundColor Green
    Write-Host "8. Install Visual Studio Code" -ForegroundColor Green
    Write-Host "9. Install Docker Desktop" -ForegroundColor Green
    Write-Host "10. Install Postman" -ForegroundColor Green
    Write-Host "11. Install All Apps" -ForegroundColor Green
    Write-Host "12. Back to Main Menu" -ForegroundColor Red
    Write-Host "====================================" -ForegroundColor Cyan
}

function Install-App($appId, $appName) {
    Write-Host "Installing $appName..." -ForegroundColor Green
    winget install --id=$appId --accept-source-agreements --silent
}

function Install-AllApps {
    Install-App "Google.Chrome" "Google Chrome"
    Install-App "Mozilla.Firefox" "Mozilla Firefox"
    Install-App "Microsoft.Edge" "Microsoft Edge"
    Install-App "7zip.7zip" "7-Zip"
    Install-App "Notepad++.Notepad++" "Notepad++"
    Install-App "VideoLAN.VLC" "VLC Media Player"
    Install-App "Git.Git" "Git"
    Install-App "Valve.Steam" "Steam"
    Install-App "Python.Python.3.11" "Python"
    Install-App "9PF4KZ2VN4W9" "TransclucentTB"
    Install-App "9NBLGGH30XJ3" "Xbox Accessories"
}

function Install-Apps {
    do {
        Show-AppMenu
        $appChoice = Read-Host "Enter your choice (1-12)"

        switch ($appChoice) {
            1 { Install-App "Google.Chrome" "Google Chrome" }
            2 { Install-App "Mozilla.Firefox" "Mozilla Firefox" }
            3 { Install-App "Microsoft.Edge" "Microsoft Edge" }
            4 { Install-App "7zip.7zip" "7-Zip" }
            5 { Install-App "Notepad++.Notepad++" "Notepad++" }
            6 { Install-App "VideoLAN.VLC" "VLC Media Player" }
            7 { Install-App "Git.Git" "Git" }
            8 { Install-App "Valve.Steam" "Steam" }
            9 { Install-App "Python.Python.3.11" "Python" }
            10 { Install-App "9PF4KZ2VN4W9" "TransclucentTB" }
            11 { Install-App "9NBLGGH30XJ3" "Xbox Accessories" }
            12 { Install-AllApps }
            13 { return }
            default { Write-Host "Invalid choice. Please try again." -ForegroundColor Red }
        }

        Write-Host "`nPress Enter to continue..." -ForegroundColor Cyan
        Read-Host

    } while ($true)
}

function Enable-PerformanceMode {
    Write-Host "Enabling Ultimate Performance Mode..." -ForegroundColor Green
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
}

function Enable-DeveloperMode {
    Write-Host "Enabling Developer Mode..." -ForegroundColor Green
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /v AllowDevelopmentWithoutDevLicense /d 1 /f
}

function Disable-Telemetry {
    Write-Host "Disabling Windows Telemetry & Tracking..." -ForegroundColor Green
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
}

function Show-FileExtensions {
    Write-Host "Showing File Extensions & Hidden Files..." -ForegroundColor Green
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
}

function Disable-OneDrive {
    Write-Host "Disabling OneDrive..." -ForegroundColor Green
    taskkill /f /im OneDrive.exe
    C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall
}

function Update-Windows {
    Write-Host "Updating Windows..." -ForegroundColor Green
    winget upgrade --all
}

# Main Menu Loop
do {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-8)"

    switch ($choice) {
        1 { Install-Apps }
        2 { Enable-PerformanceMode }
        3 { Enable-DeveloperMode }
        4 { Disable-Telemetry }
        5 { Show-FileExtensions }
        6 { Disable-OneDrive }
        7 { Update-Windows }
        8 { Write-Host "Exiting..."; exit }
        default { Write-Host "Invalid choice. Please try again." -ForegroundColor Red }
    }

    Write-Host "`nPress Enter to continue..." -ForegroundColor Cyan
    Read-Host

} while ($true)
