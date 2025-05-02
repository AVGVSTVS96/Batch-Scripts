@echo off
SETLOCAL enabledelayedexpansion

:: Check for administrative privileges and self-elevate if needed
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
    pushd "%CD%"
    CD /D "%~dp0"

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

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
