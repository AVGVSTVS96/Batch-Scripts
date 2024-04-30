@echo off
SETLOCAL

:: Install Dell Command Update
SET "MSIPath=%~dp0DellCommandUpdateApp.msi"
echo Installing Dell Command Update
start "" /B msiexec /i "%MSIPath%" /qn
echo Dell Command Update Installed Successfully.
echo.

:: Download AnyDesk exe and add to desktop without installing
echo Downloading AnyDesk
SET AnyDeskURL=https://download.anydesk.com/AnyDesk.exe
SET DestinationPath=%USERPROFILE%\Desktop\AnyDesk.exe
start "" PowerShell -Command "Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%DestinationPath%'"
echo AnyDesk has been downloaded and added to your Desktop.
echo.

:: Disable BDE for C: drive
echo Disabling Bit Locker Encryption
start "" /B manage-bde -off c:
echo Bit Locker Encryption Disabled

:: Add remote desktop icon to desktop
echo Adding Remote Desktop icon to desktop
powershell -ExecutionPolicy Bypass -Command "$TargetFile = \"$env:SystemRoot\System32\mstsc.exe\"; $ShortcutFile = \"$env:Userprofile\Desktop\Remote Desktop Connection.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

pause