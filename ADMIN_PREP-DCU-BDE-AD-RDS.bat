@echo off
SETLOCAL

:: Install Dell Command Update
SET "MSIPath=%~dp0DellCommandUpdateApp.msi"
echo Installing Dell Command Update
msiexec /i "%MSIPath%" /qn
IF %ERRORLEVEL% EQU 0 (
    echo Dell Command Update Installed Successfully.
) ELSE (
    echo Dell Command Update Installation Failed.
)
echo.

:: Download AnyDesk exe and add to desktop without installing
echo Downloading AnyDesk
SET AnyDeskURL=https://download.anydesk.com/AnyDesk.exe
SET DestinationPath=%USERPROFILE%\Desktop\AnyDesk.exe
start "" PowerShell -Command "Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%DestinationPath%'"
echo AnyDesk has been downloaded and added to your Desktop.
echo.

:: Check and disable BDE for C: drive if enabled
echo Checking BitLocker status and disabling if enabled...
manage-bde -off C: > nul 2>&1
if %errorlevel% equ 0 (
    echo BitLocker encryption has been disabled for drive C:.
    echo Please restart your computer to complete the BitLocker disabling process.
) else (
    echo BitLocker is already disabled or an error occurred while disabling.
)
echo.

:: Add remote desktop icon to desktop
echo Adding Remote Desktop icon to desktop
powershell -ExecutionPolicy Bypass -Command "$TargetFile = \"$env:SystemRoot\System32\mstsc.exe\"; $ShortcutFile = \"$env:Userprofile\Desktop\Remote Desktop Connection.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

pause