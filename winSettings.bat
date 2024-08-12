@echo off
SETLOCAL enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

powercfg -change -monitor-timeout-dc 5
powercfg -change -standby-timeout-dc 10

powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0

echo %ESC%[1;92mPower settings applied successfully.%ESC%[0m

echo Opening screensaver settings...
control desk.cpl,,1

echo Opening default app settings for Chrome...
start ms-settings:defaultapps?registeredAppMachine=Google%%20Chrome

pause 