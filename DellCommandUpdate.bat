@echo off
SETLOCAL

:: Set the path to your MSI file
SET "MSIPath=%~dp0DellCommandUpdateApp.msi"

:: Run the installer in quiet mode with no user interaction
msiexec /i "%MSIPath%" /qn

echo Installation completed.
pause