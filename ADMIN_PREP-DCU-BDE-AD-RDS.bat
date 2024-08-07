@echo off
SETLOCAL enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

:: Check for Dell Command Update
echo Checking for Dell Command Update...
if exist "%ProgramFiles(x86)%\Dell\CommandUpdate" goto FoundDellCommandUpdate
if exist "%ProgramFiles%\Dell\CommandUpdate" goto FoundDellCommandUpdate

:: If not found, proceed with installation
SET "MSIPath=%~dp0DellCommandUpdateApp.msi"
echo Dell Command Update not found. Installing...
msiexec /i "%MSIPath%" /qn
IF %ERRORLEVEL% EQU 0 (
    echo Dell Command Update Installed Successfully.
) ELSE (
    echo Dell Command Update Installation Failed.
    pause
) 
goto FinishedDellCommandUpdate

:FoundDellCommandUpdate
echo Dell Command Update is already installed.

:FinishedDellCommandUpdate
echo.

:: Check if AnyDesk is already on desktop, download if not present
echo Checking for AnyDesk...
SET AnyDeskURL=https://download.anydesk.com/AnyDesk.exe
SET DestinationPath=%USERPROFILE%\Desktop\AnyDesk.exe
IF EXIST "%DestinationPath%" (
    echo AnyDesk is already present on the Desktop.
) ELSE (
    echo Downloading AnyDesk
    PowerShell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%DestinationPath%'"
    IF EXIST "%DestinationPath%" (
        echo AnyDesk has been downloaded and added to the Desktop.
    ) ELSE (
        echo Failed to download AnyDesk.
    )
)
echo.

:: Check and disable BDE for C: drive if enabled
echo %ESC%[1;94mChecking BitLocker encryption status and disabling if enabled...%ESC%[0m

manage-bde -off C: > nul 2>&1
if %errorlevel% equ 0 (
    echo %ESC%[1;92mBitLocker encryption has been disabled for drive C:.%ESC%[0m
    echo Please restart your computer to complete the BitLocker disabling process.
) else (
    echo %ESC%[1;92mBitLocker encryption is already disabled.%ESC%[0m
)
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