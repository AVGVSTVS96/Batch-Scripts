@echo off
setlocal enabledelayedexpansion

:: Define the escape character for color
for /f %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"

:: Check for administrative privileges
:: Required for installing Dell Command Update
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo %ESC%[1;91mError:%ESC%[0m Installing  Dell Command Update scripts require administrative privileges...
    echo Run this script in an admin terminal.
    goto :FinishedDellCommandUpdate
)

echo Checking for Dell Command Update...
for %%P in ("%ProgramFiles(x86)%\Dell\CommandUpdate" "%ProgramFiles%\Dell\CommandUpdate") do (
    if exist "%%~P" (
        echo Dell Command Update found at: %%~P
        goto :FinishedDellCommandUpdate
    )
)

echo Installing Dell Command Update...
msiexec /i "%~dp0DellCommandUpdateApp.msi" /qn && (
    echo Dell Command Update Installed Successfully.
) || (
    echo Dell Command Update Installation Failed.
)

:FinishedDellCommandUpdate
echo.
pause
