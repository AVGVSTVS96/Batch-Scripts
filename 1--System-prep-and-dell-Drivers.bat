@echo off
SETLOCAL enabledelayedexpansion

:: Check for administrative privileges and self-elevate if needed
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
    pushd "%CD%"
    CD /D "%~dp0"

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

echo This script will run prep tasks for the system:
echo - Setup WiFi networks
echo - Disable BitLocker
echo - Install Dell Command Update
echo - Add AnyDesk to desktop without installing
echo - Add Remote Desktop shortcut to desktop
echo.

:: Setup WiFi networks with credentials
echo Configuring WiFi networks...
for %%n in (NYCBAR-GN NYCBAR-AN NYCBAR-KN) do (
    echo Creating WiFi profile for %%n...
    > "%TEMP%\%%n.xml" (
        echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
        echo    ^<name^>%%n^</name^>
        echo    ^<SSIDConfig^>
        echo       ^<SSID^>
        echo          ^<name^>%%n^</name^>
        echo       ^</SSID^>
        echo    ^</SSIDConfig^>
        echo    ^<connectionType^>ESS^</connectionType^>
        echo    ^<connectionMode^>auto^</connectionMode^>
        echo    ^<MSM^>
        echo       ^<security^>
        echo          ^<authEncryption^>
        echo             ^<authentication^>WPA2PSK^</authentication^>
        echo             ^<encryption^>AES^</encryption^>
        echo             ^<useOneX^>false^</useOneX^>
        echo          ^</authEncryption^>
        echo          ^<sharedKey^>
        echo             ^<keyType^>passPhrase^</keyType^>
        echo             ^<protected^>false^</protected^>
        echo             ^<keyMaterial^>abcnycenter^</keyMaterial^>
        echo          ^</sharedKey^>
        echo       ^</security^>
        echo    ^</MSM^>
        echo ^</WLANProfile^>
    )
    netsh wlan add profile filename="%TEMP%\%%n.xml" >nul && (
        echo WiFi profile for %%n added successfully.
    ) || (
        echo Failed to add WiFi profile for %%n.
    )
)
echo.

:: Disable active BitLocker encryption processes
echo %ESC%[1;94mDisabling active BitLocker encryption processes...%ESC%[0m
manage-bde -off C: > nul 2>&1

:: Stop and disable the BitLocker service itself
echo %ESC%[1;94mDisabling BitLocker service...%ESC%[0m
net stop BDESVC >nul 2>&1
sc config "BDESVC" start= disabled >nul 2>&1
if !errorlevel! neq 0 (
    echo %ESC%[1;91mError: Could not disable the BitLocker service.%ESC%[0m
) else (
    echo %ESC%[1;92mBitLocker service has been disabled.%ESC%[0m
)

echo.

:: Check for Dell Command Update
echo Checking for Dell Command Update...
for %%P in ("%ProgramFiles(x86)%\Dell\CommandUpdate" "%ProgramFiles%\Dell\CommandUpdate") do (
    if exist "%%~P" (
        echo Dell Command Update found at: %%~P
        goto :FinishedDellCommandUpdate
    )
)

echo Installing Dell Command Update using winget...
winget install -e --id Dell.CommandUpdate --accept-source-agreements --silent && (
    echo Dell Command Update installed successfully.
) || (
    echo Winget installation failed, falling back to local MSI...
    msiexec /i "%~dp0DellCommandUpdateApp.msi" /qn && (
        echo Dell Command Update installed successfully using local MSI ^(may be outdated^).
    ) || (
        echo Dell Command Update installation failed.
    )
)

:FinishedDellCommandUpdate
echo.

:: Wait for internet connection to be established
echo Waiting for internet connection...
:CheckConnection
ping -n 1 www.google.com >nul 2>&1
if errorlevel 1 (
    echo Internet not ready. Retrying in 1 second...
    timeout /t 1 /nobreak >nul
    goto :CheckConnection
)
echo Internet connection detected.
echo.

:: Check if AnyDesk is already on desktop, download if not present
echo Checking for AnyDesk...
set "AnyDeskURL=https://download.anydesk.com/AnyDesk.exe"

for %%P in ("%USERPROFILE%\Desktop\AnyDesk.exe" "C:\Users\vboxuser\Desktop\AnyDesk.exe" "C:\Users\public\Desktop\AnyDesk.exe") do (
    if exist "%%P" (
        echo AnyDesk found at: %%P
        goto :FoundAnyDesk
    )
)

echo Downloading AnyDesk...
PowerShell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%USERPROFILE%\Desktop\AnyDesk.exe'" && (
    echo AnyDesk has been downloaded and added to the Desktop.
) || (
    echo Failed to download AnyDesk.
)

:FoundAnyDesk
echo.

:: Add remote desktop shortcut to desktop
echo Checking for Remote Desktop shortcut...
SET "ShortcutFile=%Userprofile%\Desktop\Remote Desktop Connection.lnk"

IF EXIST "%ShortcutFile%" (
    echo Remote Desktop shortcut is already present on the Desktop.
) ELSE (
    echo Adding Remote Desktop shortcut to desktop
    powershell -ExecutionPolicy Bypass -Command "$TargetFile = \"$env:SystemRoot\System32\mstsc.exe\"; $ShortcutFile = \"$env:Userprofile\Desktop\Remote Desktop Connection.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"
    IF EXIST "%ShortcutFile%" (
        echo Remote Desktop shortcut has been added to the Desktop.
    ) ELSE (
        echo Failed to create Remote Desktop shortcut.
    )
)
echo.

pause
