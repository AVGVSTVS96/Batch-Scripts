@echo off
SETLOCAL

:: Set the download URL for AnyDesk
SET AnyDeskURL=https://download.anydesk.com/AnyDesk.exe

:: Set the destination path on the Desktop
SET DestinationPath=%USERPROFILE%\Desktop\AnyDesk.exe

:: Use PowerShell to download the file
PowerShell -Command "Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%DestinationPath%'"

echo AnyDesk has been downloaded to your Desktop.
pause
