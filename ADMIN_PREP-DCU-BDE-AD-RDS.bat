@echo off
SETLOCAL enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

:: Check for administrative privileges
:: Required for disabling BitLocker and installing Dell Command Update
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo %ESC%[1;91mError:%ESC%[0m BitLocker and Dell Command Update scripts require administrative privileges...
    echo Run this script in an admin terminal.
    goto :SkipBitLocker
)

echo Checking for Dell Command Update...
for %%P in ("%ProgramFiles(x86)%\Dell\CommandUpdate" "%ProgramFiles%\Dell\CommandUpdate") do (
    if exist "%%~P" (
        echo Dell Command Update found at: %%~P
        goto :FinishedDellCommandUpdate
    )
)

echo Installing Dell Command Update...
msiexec /i "%~dp0DellCommandUpdateApp.msi" /qn && (
    echo Dell Command Update Installed Successfully.
) || (
    echo Dell Command Update Installation Failed.
)

:FinishedDellCommandUpdate
echo.

:: Disable BDE for C: drive if enabled
echo %ESC%[1;94mChecking BitLocker encryption status and disabling if enabled...%ESC%[0m

manage-bde -off C: > nul 2>&1 && (
    echo %ESC%[1;92mBitLocker encryption has been disabled for drive C:.%ESC%[0m
) || echo %ESC%[1;92mBitLocker encryption is already disabled.%ESC%[0m

:SkipBitLocker

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
