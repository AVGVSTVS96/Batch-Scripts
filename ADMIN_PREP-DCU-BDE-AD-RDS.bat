@echo off
SETLOCAL

:: Check for Dell Command Update
echo Checking if Dell Command Update is already installed...
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
)

:FoundDellCommandUpdate
echo Dell Command Update is already installed.
echo.

:: Check if AnyDesk is already on desktop, download if not present
SET AnyDeskURL=https://download.anydesk.com/AnyDesk.exe
SET DestinationPath=%USERPROFILE%\Desktop\AnyDesk.exe
IF EXIST "%DestinationPath%" (
    echo AnyDesk is already present on the Desktop.
) ELSE (
    echo Downloading AnyDesk
    PowerShell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%DestinationPath%'"
    IF EXIST "%DestinationPath%" (
        echo AnyDesk has been downloaded and added to your Desktop.
    ) ELSE (
        echo Failed to download AnyDesk.
    )
)
echo.

:: Check and disable BDE for C: drive if enabled
echo Checking BitLocker status and disabling if enabled...
manage-bde -off C: > nul 2>&1
if %errorlevel% equ 0 (
    echo BitLocker encryption has been disabled for drive C:.
    echo Please restart your computer to complete the BitLocker disabling process.
) else (
    echo BitLocker is already disabled.
)
echo.

:: Add remote desktop icon to desktop
echo Adding Remote Desktop icon to desktop
powershell -ExecutionPolicy Bypass -Command "$TargetFile = \"$env:SystemRoot\System32\mstsc.exe\"; $ShortcutFile = \"$env:Userprofile\Desktop\Remote Desktop Connection.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

pause