:: Put this file in USB root, it will update all scripts on the USB

@echo off
setlocal enabledelayedexpansion

color 07

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
color 03
echo Git pull successful. Updating existing files in USB root...
color 07
echo.
for /f "tokens=*" %%a in ('git diff --name-only HEAD@{1} HEAD') do (
    if exist "%%a" (
        if exist "..\%%~nxa" (
            echo Updating %%~nxa in USB root...
            copy /Y "%%a" "..\%%~nxa"
        ) else (
            echo %%~nxa does not exist in USB root. Skipping...
        )
    )
)

cd ..
echo.
color 0A
echo Update complete. Files in USB root are now up-to-date.
color 07
echo.
pause