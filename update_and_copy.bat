:: @echo off

:: Add this to USB root, run it to git pull batch scripts and copy ADMIN_PREP-DCU-BDE-AD-RDS.bat to USB root
:: cd "Batch Scripts"
:: git pull
:: copy "ADMIN_PREP-DCU-BDE-AD-RDS.bat" "..\ADMIN_PREP-DCU-BDE-AD-RDS.bat"
:: cd ..
:: echo Update complete and file copied to USB root.
:: pause

@echo off
setlocal enabledelayedexpansion

cd "Batch Scripts"

echo Updating repository...
git pull
if %errorlevel% neq 0 (
    echo Error: Git pull failed. Exiting script.
    cd ..
    pause
    exit /b %errorlevel%
)

echo Git pull successful. Copying changed files to USB root...
for /f "tokens=*" %%a in ('git diff --name-only HEAD@{1} HEAD') do (
    if exist "%%a" (
        if exist "..\%%~nxa" (
            echo Updating %%~nxa in USB root...
        ) else (
            echo Creating %%~nxa in USB root...
        )
        copy /Y "%%a" "..\%%~nxa"
    )
)

cd ..
echo Update complete. Files in USB root are now up-to-date.
pause