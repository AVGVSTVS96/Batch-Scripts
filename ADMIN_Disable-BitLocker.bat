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

:: Disable active BitLocker encryption processes
echo %ESC%[1;94mDisabling active BitLocker encryption processes...%ESC%[0m
manage-bde -off C: > nul 2>&1

:: Stop and disable the BitLocker service itself
echo %ESC%[1;94mDisabling BitLocker service...%ESC%[0m
net stop BDESVC >nul 2>&1
sc config "BDESVC" start= disabled >nul 2>&1
if !errorlevel! neq 0 (
    echo %ESC%[1;91mError: Could not disable the BitLocker service.%ESC%[0m
) else (
    echo %ESC%[1;92mBitLocker service has been disabled.%ESC%[0m
)
echo.
pause
