@echo off
echo Checking for installed Dell Command Update versions...

:: Check if Dell.CommandUpdate is installed
winget list --id Dell.CommandUpdate >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Found Dell.CommandUpdate. Uninstalling...
    winget uninstall --id Dell.CommandUpdate --silent
    if %ERRORLEVEL% equ 0 (
        echo Dell.CommandUpdate uninstalled successfully.
    ) else (
        echo Failed to uninstall Dell.CommandUpdate.
    )
    goto end
)

:: Check if Dell.CommandUpdate.Universal is installed
winget list --id Dell.CommandUpdate.Universal >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Found Dell.CommandUpdate.Universal. Uninstalling...
    winget uninstall --id Dell.CommandUpdate.Universal --silent
    if %ERRORLEVEL% equ 0 (
        echo Dell.CommandUpdate.Universal uninstalled successfully.
    ) else (
        echo Failed to uninstall Dell.CommandUpdate.Universal.
    )
    goto end
)

:: If neither is found
echo No installed version of Dell Command Update found.
:end
pause
