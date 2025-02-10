@echo off
setlocal enabledelayedexpansion

set "packages=Dell.CommandUpdate Dell.CommandUpdate.Universal Microsoft.Teams.Free"
set "found=0"

echo Starting cleanup...
for %%P in (%packages%) do (
    winget list --id %%P >nul 2>&1
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
