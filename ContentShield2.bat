@echo off
:: Install Barracuda Content Shield silently using the setup executable and key file in the same directory
BarracudaContentShieldSetup-2.3.23.1.exe KEYPATH="bcs.key" /silent

echo Installation completed.
pause
