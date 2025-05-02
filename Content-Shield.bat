@echo off

echo This script will install Content Shield using the setup executable and key file in the same directory.
echo Ensure this script is in the same directory as the setup executable and key file.
echo.

:: Install Barracuda Content Shield by running the setup exe
BarracudaContentShieldSetup-2.3.23.1.exe KEYPATH="bcs.key" /silent

echo Content Shield installed successfully.
pause
