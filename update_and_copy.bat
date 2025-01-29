:: Put this file in USB root, it will update all scripts on the USB
:: When adding new scripts, they must be moved from Batch Scripts/ to the USB root manually
:: This script will update all Batch Scripts/ as well as all scripts that also exist in the USB root

@echo off
setlocal enabledelayedexpansion

:: Get the current directory's drive letter
for %%I in (.) do set "USB_DRIVE=%%~dI"

:: Check if git is available
where git >nul 2>nul
if %errorlevel% equ 0 (
    echo System Git found, using system installation...
    set "GIT_COMMAND=git"
) else (
    echo System Git not found, using portable Git from USB...
    
    :: Set up portable Git environment
    set "PORTABLE_GIT=%USB_DRIVE%\PortableGit"
    
    if not exist "%PORTABLE_GIT%\cmd\git.exe" (
        echo Error: Portable Git not found at %PORTABLE_GIT%
        echo Please ensure PortableGit is extracted to the USB root.
        echo Expected path: %PORTABLE_GIT%\cmd\git.exe
        pause
        exit /b 1
    )
    
    :: Set up Git environment variables
    set "PATH=%PORTABLE_GIT%\cmd;%PATH%"
    set "GIT_COMMAND=%PORTABLE_GIT%\cmd\git.exe"
)

echo Changing directory to Batch Scripts...
cd "Batch Scripts"

echo.

echo Running git pull in Batch Scripts...
"%GIT_COMMAND%" pull
if %errorlevel% neq 0 (
    echo Error: Git pull failed. Exiting script.
    cd ..
    pause
    exit /b %errorlevel%
)

echo.
echo Git pull successful. Updating existing files in USB root...
echo.

robocopy . .. /XL /XX

cd ..
echo Update complete. Scripts in USB root are now up-to-date.
echo.
pause
