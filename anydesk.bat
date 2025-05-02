@echo off
SETLOCAL

echo This script will download and add AnyDesk to the desktop without installing it.

:: Check if AnyDesk is already on desktop, download if not present
echo Checking for AnyDesk...
set "AnyDeskURL=https://download.anydesk.com/AnyDesk.exe"

for %%P in ("%USERPROFILE%\Desktop\AnyDesk.exe" "C:\Users\vboxuser\Desktop\AnyDesk.exe" "C:\Users\public\Desktop\AnyDesk.exe") do (
    if exist "%%P" (
        echo AnyDesk found at: %%P
        goto :FoundAnyDesk
    )
)

echo Downloading AnyDesk...
PowerShell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%AnyDeskURL%' -OutFile '%USERPROFILE%\Desktop\AnyDesk.exe'" && (
    echo AnyDesk has been downloaded and added to the Desktop.
) || (
    echo Failed to download AnyDesk.
)

:FoundAnyDesk
pause
