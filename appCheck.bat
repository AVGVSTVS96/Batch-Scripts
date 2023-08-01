@echo off

:: AnyDesk
if not exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" (
    echo AnyDesk is not installed.
) else (
    echo AnyDesk is already installed.
)


:: Zoom
if not exist "%APPDATA%\Zoom" (
    if not exist "%ProgramFiles%\Zoom" (
        if not exist "%ProgramFiles(x86)%\Zoom" (
            echo Zoom is not installed.
        )
    )
) else (
    echo Zoom is already installed.
)


:: Microsoft Teams
if not exist "%LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe" (
    if not exist "%APPDATA%\Microsoft\Teams\current\Teams.exe" (
        echo Microsoft Teams is not installed.
    )
) else (
    echo Microsoft Teams is already installed.
)


:: Google Chrome
if not exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    if not exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
        echo Google Chrome is not installed.
        )
) else (
    echo Google Chrome is already installed.
)


:: AnyConnect
if not exist "%ProgramFiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" (
    echo AnyConnect is not installed.
) else (
    echo AnyConnect is already installed.
)


:: Trend Micro
if not exist "%ProgramFiles(x86)%\Trend Micro" (
    echo Trend Micro WFBS-SVC is not installed.
) else (
    echo Trend Micro is already installed.
)


:: Webex
if not exist "%LOCALAPPDATA%\CiscoSparkLauncher\CiscoCollabHost" (
    if not exist "%APPDATA%\CiscoSparkLauncher\CiscoCollabHost" (
        echo Webex is not installed.
    )
) else (
    echo Webex is already installed.
)


:: Check for Carbon Black installation
if not exist "%ProgramFiles%\Confer" (
    if not exist "%ProgramFiles(x86)%\Confer" (
        echo Carbon Black is not installed.
    )
) else (
    echo Carbon Black is already installed.
)


echo Installation checks complete.
pause