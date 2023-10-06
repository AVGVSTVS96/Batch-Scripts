@echo off


:: AnyDesk
if exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" goto FoundAnyDesk

echo AnyDesk is not installed.
goto EndAnyDesk

:FoundAnyDesk
echo AnyDesk is already installed.

:EndAnyDesk


:: Zoom
if exist "%APPDATA%\Zoom" goto FoundZoom
if exist "%ProgramFiles%\Zoom" goto FoundZoom
if exist "%ProgramFiles(x86)%\Zoom" goto FoundZoom

echo Zoom is not installed.
goto EndZoom

:FoundZoom
echo Zoom is already installed.

:EndZoom


:: Microsoft Teams
if exist "%LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams
if exist "%APPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams

echo Microsoft Teams is not installed.
goto EndTeams

:FoundTeams
echo Microsoft Teams is already installed.

:EndTeams


:: Google Chrome
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" goto FoundChrome

echo Google Chrome is not installed.
goto EndChrome

:FoundChrome
echo Google Chrome is already installed.

:EndChrome


:: AnyConnect
if exist "%ProgramFiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" goto FoundAnyConnect

echo AnyConnect is not installed.
goto EndAnyConnect

:FoundAnyConnect
echo AnyConnect is already installed.

:EndAnyConnect

:: Trend Micro
if exist "%ProgramFiles(x86)%\Trend Micro" goto FoundTrendMicro

echo Trend Micro WFBS-SVC is not installed.
goto EndTrendMicro

:FoundTrendMicro
echo Trend Micro is already installed.

:EndTrendMicro

:: Webex
if exist "%LOCALAPPDATA%\CiscoSparkLauncher\CiscoCollabHost" goto FoundWebex
if exist "%APPDATA%\CiscoSparkLauncher\CiscoCollabHost" goto FoundWebex

echo Webex is not installed.
goto EndWebex

:FoundWebex
echo Webex is already installed.

:EndWebex

:: Carbon Black
if exist "%ProgramFiles%\Confer" goto FoundCarbonBlack
if exist "%ProgramFiles(x86)%\Confer" goto FoundCarbonBlack

echo Carbon Black is not installed.
goto EndCarbonBlack

:FoundCarbonBlack
echo Carbon Black is already installed.

:EndCarbonBlack

:: Content Shield
if exist "%ProgramFiles%\Barracuda\Content Shield" goto FoundContentShield
if exist "%ProgramFiles(x86)%\Barracuda\Content Shield" goto FoundContentShield

echo Content Shield is not installed.
goto EndContentShield

:FoundContentShield
echo Content Shield is already installed.

:EndContentShield

echo Installation checks complete.
pause