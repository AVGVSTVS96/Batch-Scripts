@echo off
SETLOCAL enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

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

pause