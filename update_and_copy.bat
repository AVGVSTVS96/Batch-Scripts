:: Put this file in USB root, it will update all scripts on the USB

@echo off
setlocal enabledelayedexpansion

echo Changing directory to Batch Scripts...
cd "Batch Scripts"

echo.

echo Running git pull in Batch Scripts...
git pull
if %errorlevel% neq 0 (
    echo Error: Git pull failed. Exiting script.
    cd ..
    pause
    exit /b %errorlevel%
)
echo.
echo Git pull successful. Updating existing files in USB root...
echo.

robocopy . .. /XL

cd ..
echo Update complete. Scripts in USB root are now up-to-date.
echo.
pause