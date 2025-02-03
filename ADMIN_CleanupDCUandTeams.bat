@echo off
echo Checking for installed Dell Command Update versions...

:: Check if Dell.CommandUpdate is installed
winget list --id Dell.CommandUpdate >nul 2>&1
if %ERRORLEVEL% equ 0 (
    winget uninstall --id Dell.CommandUpdate
    if %ERRORLEVEL% equ 0 (
        echo Dell.CommandUpdate uninstalled successfully.
    ) else (
        echo Failed to uninstall Dell.CommandUpdate.
    )
    goto endDcu
)

:: Check if Dell.CommandUpdate.Universal is installed
winget list --id Dell.CommandUpdate.Universal >nul 2>&1
if %ERRORLEVEL% equ 0 (
    winget uninstall --id Dell.CommandUpdate.Universal
    if %ERRORLEVEL% equ 0 (
        echo Dell.CommandUpdate.Universal uninstalled successfully.
    ) else (
        echo Failed to uninstall Dell.CommandUpdate.Universal.
    )
    goto endDcu
)

:: If neither is found
echo No installed version of Dell Command Update found.
:endDcu

:: Check if Teams personal is installed
winget list --id Microsoft.Teams.Free >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Found Microsoft Teams personal. Uninstalling...
    winget uninstall --id Microsoft.Teams.Free
) else (
    echo Installing Microsoft Teams personal...
)


:: Uninstall Teams personal
echo Uninstalling Microsoft Teams personal...
winget uninstall --id Microsoft.Teams.Free
pause
