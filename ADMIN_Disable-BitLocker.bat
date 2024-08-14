@echo off
SETLOCAL enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

:: Check for administrative privileges
net session >nul 2>&1 || (
    echo %ESC%[1;91mError: This script requires administrative privileges.%ESC%[0m
    echo Run this script as an administrator to disable BitLocker.
    pause
    exit /b 1
)

:: Check and disable BDE for C: drive if enabled
echo %ESC%[1;94mChecking BitLocker encryption status and disabling if enabled...%ESC%[0m

manage-bde -off C: > nul 2>&1 && (
    echo %ESC%[1;92mBitLocker encryption has been disabled for drive C:.%ESC%[0m
) || echo %ESC%[1;92mBitLocker encryption is already disabled.%ESC%[0m

echo.
pause