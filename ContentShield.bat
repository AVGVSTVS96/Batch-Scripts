@echo off
SETLOCAL

:: Set the name of your Barracuda Content Shield setup executable
:: Make sure to replace [version] with the actual version number
SET FileName=BarracudaContentShieldSetup-2.3.23.1.exe

:: Set the name of your bcs.key file
SET KeyPath=bcs.key

:: Install Barracuda Content Shield silently
"%FileName%" KEYPATH="%KeyPath%" /silent

echo Installation completed.
pause
