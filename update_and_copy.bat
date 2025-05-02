:: Put this file in USB root, it will update all scripts on the USB
:: When adding new scripts, they must be moved from Batch Scripts/
:: to the USB root manually
:: This script will update all Batch Scripts/ and will sync the latest
:: scripts to the USB root.

@echo off
setlocal enabledelayedexpansion

:: This ensures .gitconfig is not modified if it exists on the system
:: Track if we should delete .gitconfig after script
set "DELETE_AFTER=0"
if not exist "%USERPROFILE%\.gitconfig" set "DELETE_AFTER=1"

:: Store the USB drive letter
set "USB_DRIVE=%~d0"

:: Use delayed expansion to fix errors with unexapanded variables
set "PORTABLE_GIT=!USB_DRIVE!\PortableGit"

:: Check if git is available
where git >nul 2>nul
if %errorlevel% equ 0 (
    REM echo System Git found, using system installation...
    set "GIT_COMMAND=git"
) else (
    REM echo System Git not found, using portable Git from USB...
    
    if not exist "!PORTABLE_GIT!\cmd\git.exe" (
        echo Error: Portable Git not found at !PORTABLE_GIT!
        echo Please ensure PortableGit is extracted to the USB root.
        echo Expected path: !PORTABLE_GIT!\cmd\git.exe
        pause
        exit /b 1
    )
    
    :: Set up Git environment variables
    set "PATH=!PORTABLE_GIT!\cmd;%PATH%"
    set "GIT_COMMAND=!PORTABLE_GIT!\cmd\git.exe"
)

REM echo Changing directory to Batch Scripts...
cd "Batch Scripts"

echo.

:: Add current directory to git's safe list
"%GIT_COMMAND%" config --global --add safe.directory "!CD!"

echo Fetching latest changes in Batch Scripts...
"%GIT_COMMAND%" pull
if %errorlevel% neq 0 (
    echo Error: Fetching latest changes failed. Exiting script.
    cd ..
    if %DELETE_AFTER%==1 if exist "%USERPROFILE%\.gitconfig" del "%USERPROFILE%\.gitconfig"
    pause
    exit /b %errorlevel%
)

echo.
echo Successfully updated Batch Scripts. Updating existing files in USB root...
echo.

robocopy . .. /XL /XX

cd ..
echo Update complete. All scripts are now up-to-date.
echo.

if %DELETE_AFTER%==1 if exist "%USERPROFILE%\.gitconfig" del "%USERPROFILE%\.gitconfig"

pause

