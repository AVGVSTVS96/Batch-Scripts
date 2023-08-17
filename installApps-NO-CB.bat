@echo off

:: Set the standard Downloads folder
set DOWNLOADS_FOLDER=%USERPROFILE%\Downloads

:: Download AnyDesk installer if not installed
if not exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" (
    echo Downloading AnyDesk...
    powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://download.anydesk.com/AnyDesk.exe' -OutFile '%DOWNLOADS_FOLDER%\AnyDesk.exe'"
) else (
    echo AnyDesk is already installed.
)

:: Download and Install Zoom if not installed
if exist "%APPDATA%\Zoom" (
    echo Zoom is already installed...
) else if exist "%ProgramFiles%\Zoom" (
    echo Zoom is already installed...
) else if exist "%ProgramFiles(x86)%\Zoom" (
    echo Zoom is already installed...
    
) else (
    echo Downloading Zoom...
    powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://zoom.us/client/latest/ZoomInstallerFull.msi?archType=x64' -OutFile '%DOWNLOADS_FOLDER%\ZoomInstallerFull.msi'"
    echo Installing Zoom...
    start "" msiexec /i "%DOWNLOADS_FOLDER%\ZoomInstallerFull.msi" 
)

:: Download Microsoft Teams installer if not installed
if not exist "%LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe" (
    if not exist "%APPDATA%\Microsoft\Teams\current\Teams.exe" (
        echo Installing Microsoft Teams...
        start "" "%~dp0TeamsSetup_c_w_.exe" 
        )
) else (
    echo Microsoft Teams is already installed.
)

:: Install Google Chrome installer if not installed
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    echo Google Chrome is already installed.
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    echo Google Chrome is already installed.
) else (
    echo Installing Chrome...
    start "" "%~dp0ChromeSetup.exe" 
)

:: Install AnyConnect from USB if not installed
if not exist "%ProgramFiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" (
    echo Installing AnyConnect...
    start "" "%~dp0anyconnect-4.5.05030.exe" 
) else (
    echo AnyConnect is already installed.
)

:: Install Trend Micro WFBS-SVC_Agent_Installer.msi if not installed
if not exist "%ProgramFiles(x86)%\Trend Micro" (
    echo Installing Trend Micro WFBS-SVC...
    start "" msiexec /i "%~dp0WFBS-SVC_Agent_Installer.msi" 
) else (
    echo Trend Micro is already installed.
)


echo Installation checks complete.
pause
