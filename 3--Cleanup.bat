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

set "packages=Dell.CommandUpdate Dell.CommandUpdate.Universal Microsoft.Teams.Free"
set "found=0"

echo This script will uninstall Dell Command Update, and the old Microsoft Teams app.
echo.
echo Starting cleanup...
for %%P in (%packages%) do (
    winget list --id %%P --accept-source-agreements >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        set "found=1"
        winget uninstall --id %%P
        if !ERRORLEVEL! equ 0 (
            echo %%P uninstalled successfully.
        ) else (
            echo Failed to uninstall %%P.
        )
    )
)

if !found! equ 0 echo System is already clean.
pause
