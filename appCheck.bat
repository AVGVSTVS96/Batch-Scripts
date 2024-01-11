@echo off
SETLOCAL EnableDelayedExpansion
set "missingApps="

:: Adobe Acrobat 
if exist "%ProgramFiles%\Adobe\Acrobat 11.0" goto FoundAcro
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 11.0" goto FoundAcro

set "missingApps=%missingApps% Adobe Acrobat"

echo Adobe Acrobat is not installed.
goto EndAcro

:FoundAcro
echo Adobe Acrobat is already installed.

:EndAcro


:: AnyConnect
if exist "%ProgramFiles%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" goto FoundAnyConnect
if exist "%ProgramFiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" goto FoundAnyConnect

set "missingApps=%missingApps% AnyConnect"

echo AnyConnect is not installed.
goto EndAnyConnect

:FoundAnyConnect
echo AnyConnect is already installed.

:EndAnyConnect


:: AnyDesk
if exist "%ProgramFiles%\AnyDesk\AnyDesk.exe" goto FoundAnyDeskInstall
if exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" goto FoundAnyDeskInstall

if exist "%USERPROFILE%\Downloads\AnyDesk.exe" goto FoundAnyDeskDownload
if exist "%USERPROFILE%\Desktop\AnyDesk.exe" goto FoundAnyDeskDownload

set "missingApps=%missingApps% AnyDesk"

echo AnyDesk is not downloaded or installed.
goto EndAnyDesk

:FoundAnyDeskInstall
echo AnyDesk is already installed.
goto EndAnyDesk

:FoundAnyDeskDownload
echo AnyDesk is downloaded but not installed.

:EndAnyDesk


::Avaya
if exist "%ProgramFiles%\Avaya Cloud" goto FoundAvaya
if exist "%ProgramFiles(x86)%\Avaya Cloud" goto FoundAvaya
if exist "%LOCALAPPDATA%\Programs\AvayaCloud" goto FoundAvaya

set "missingApps=%missingApps% Avaya Cloud"

echo Avaya Cloud is not installed.
goto EndAvaya

:FoundAvaya
echo Avaya Cloud is already installed.

:EndAvaya


:: Carbon Black
if exist "%ProgramFiles%\Confer" goto FoundCarbonBlack
if exist "%ProgramFiles(x86)%\Confer" goto FoundCarbonBlack

set "missingApps=%missingApps% Carbon Black"

echo Carbon Black is not installed.
goto EndCarbonBlack

:FoundCarbonBlack
echo Carbon Black is already installed.

:EndCarbonBlack


:: Content Shield
if exist "%ProgramFiles%\Barracuda\Content Shield" goto FoundContentShield
if exist "%ProgramFiles(x86)%\Barracuda\Content Shield" goto FoundContentShield

set "missingApps=%missingApps% Content Shield"

echo Content Shield is not installed.
goto EndContentShield

:FoundContentShield
echo Content Shield is already installed.

:EndContentShield


:: Dell Command Update
if exist "%ProgramFiles(x86)%\Dell\CommandUpdate" goto FoundDellCommandUpdate
if exist "%ProgramFiles%\Dell\CommandUpdate" goto FoundDellCommandUpdate

set "missingApps=%missingApps% Dell Command Update"

echo Dell Command Update is not installed.
goto EndDellCommandUpdate

:FoundDellCommandUpdate
echo Dell Command Update is already installed.

:EndDellCommandUpdate


:: Google Chrome
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" goto FoundChrome

set "missingApps=%missingApps% Google Chrome"

echo Google Chrome is not installed.
goto EndChrome

:FoundChrome
echo Google Chrome is already installed.

:EndChrome


:: Microsoft Teams
if exist "%LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams
if exist "%APPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams

set "missingApps=%missingApps% Microsoft Teams"

echo Microsoft Teams is not installed.
goto EndTeams

:FoundTeams
echo Microsoft Teams is already installed.

:EndTeams


:: Microsoft Office 365
if exist "%ProgramFiles%\Microsoft Office" goto FoundOffice
if exist "%ProgramFiles(x86)%\Microsoft Office" goto FoundOffice

set "missingApps=%missingApps% Microsoft Office"

echo Microsoft Office is not installed.
goto EndOffice

:FoundOffice
echo Microsoft Office is already installed.

:EndOffice


:: Trend Micro
if exist "%ProgramFiles(x86)%\Trend Micro" goto FoundTrendMicro

set "missingApps=%missingApps% Trend Micro"

echo Trend Micro WFBS-SVC is not installed.
goto EndTrendMicro

:FoundTrendMicro
echo Trend Micro is already installed.

:EndTrendMicro


:: Webex
if exist "%LOCALAPPDATA%\CiscoSparkLauncher\CiscoCollabHost" goto FoundWebex
if exist "%APPDATA%\CiscoSparkLauncher\CiscoCollabHost" goto FoundWebex
if exist "%LOCALAPPDATA%\WebEx" goto FoundWebex

set "missingApps=%missingApps% Webex"

echo Webex is not installed.
goto EndWebex

:FoundWebex
echo Webex is already installed.

:EndWebex


:: Zoom
if exist "%APPDATA%\Zoom" goto FoundZoom
if exist "%ProgramFiles%\Zoom" goto FoundZoom
if exist "%ProgramFiles(x86)%\Zoom" goto FoundZoom

set "missingApps=%missingApps% Zoom"

echo Zoom is not installed.
goto EndZoom

:FoundZoom
echo Zoom is already installed.

:EndZoom

echo.
echo Installation checks complete.

:: Check if any apps are missing and display them
if not "%missingApps%"=="" (
    echo The following apps need to be installed:%missingApps%.
) else (
    echo All apps are installed.
)

echo.

:: Check Name and Power Settings

:: Get the computer name
FOR /F "tokens=*" %%a IN ('hostname') DO SET COMPUTER_NAME=%%a
echo System Name: !COMPUTER_NAME!

echo.

:: Get the active power scheme
FOR /F "tokens=2 delims=:(" %%i IN ('powercfg /GETACTIVESCHEME') DO SET SCHEME_GUID=%%i

:: Remove spaces from the GUID
SET SCHEME_GUID=!SCHEME_GUID: =!

:: Get the setting for turning off the display (AC Power)
FOR /F "delims=" %%j IN ('powercfg /QUERY !SCHEME_GUID! SUB_VIDEO VIDEOIDLE ^| findstr /C:"Current AC Power Setting Index"') DO (
    SET line=%%j
    SET DISPLAY_OFF_TIME_HEX=!line:*: 0x=!
)

:: Check if the value represents 'Never' (0x00000000)
IF "!DISPLAY_OFF_TIME_HEX!"=="00000000" (
    SET DISPLAY_OFF_TIME=Never
) ELSE (
    :: Convert Hex to Dec
    SET /A DISPLAY_OFF_TIME_DEC=0x!DISPLAY_OFF_TIME_HEX!
    :: Convert to minutes
    SET /A DISPLAY_OFF_TIME=!DISPLAY_OFF_TIME_DEC! / 60
)

:: Get the setting for sleep time (AC Power)
FOR /F "delims=" %%k IN ('powercfg /QUERY !SCHEME_GUID! SUB_SLEEP STANDBYIDLE ^| findstr /C:"Current AC Power Setting Index"') DO (
    SET line=%%k
    SET SLEEP_TIME_HEX=!line:*: 0x=!
)

:: Check if the value represents 'Never' (0x00000000)
IF "!SLEEP_TIME_HEX!"=="00000000" (
    SET SLEEP_TIME=Never
) ELSE (
    :: Convert Hex to Dec
    SET /A SLEEP_TIME_DEC=0x!SLEEP_TIME_HEX!
    :: Convert to minutes
    SET /A SLEEP_TIME=!SLEEP_TIME_DEC! / 60
)

:: Display the settings with conditional 'minutes'
IF NOT "!DISPLAY_OFF_TIME!"=="Never" (
    echo Display turns off after: !DISPLAY_OFF_TIME! minutes
) ELSE (
    echo Display turns off after: !DISPLAY_OFF_TIME!
)

IF NOT "!SLEEP_TIME!"=="Never" (
    echo PC goes to sleep after: !SLEEP_TIME! minutes
) ELSE (
    echo PC goes to sleep after: !SLEEP_TIME!
)

echo.

ENDLOCAL
pause