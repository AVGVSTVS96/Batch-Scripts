@echo off
setlocal enabledelayedexpansion

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
