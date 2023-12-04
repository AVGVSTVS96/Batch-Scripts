@echo off

:: Adobe Acrobat 
if exist "%ProgramFiles%\Adobe\Acrobat 11.0" goto FoundAcro
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 11.0" goto FoundAcro

echo Adobe Acrobat is not installed.
goto EndAcro

:FoundAcro
echo Adobe Acrobat is already installed.

:EndAcro


:: AnyConnect
if exist "%ProgramFiles%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" goto FoundAnyConnect
if exist "%ProgramFiles(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe" goto FoundAnyConnect

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

echo Avaya Cloud is not installed.
goto EndAvaya

:FoundAvaya
echo Avaya Cloud is already installed.

:EndAvaya


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


:: Dell Command Update
if exist "%ProgramFiles(x86)%\Dell\CommandUpdate" goto FoundDellCommandUpdate
if exist "%ProgramFiles%\Dell\CommandUpdate" goto FoundDellCommandUpdate

echo Dell Command Update is not installed.
goto EndDellCommandUpdate

:FoundDellCommandUpdate
echo Dell Command Update is already installed.

:EndDellCommandUpdate


:: Google Chrome
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" goto FoundChrome
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" goto FoundChrome

echo Google Chrome is not installed.
goto EndChrome

:FoundChrome
echo Google Chrome is already installed.

:EndChrome


:: Microsoft Teams
if exist "%LOCALAPPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams
if exist "%APPDATA%\Microsoft\Teams\current\Teams.exe" goto FoundTeams

echo Microsoft Teams is not installed.
goto EndTeams

:FoundTeams
echo Microsoft Teams is already installed.

:EndTeams


:: Microsoft Office 365
if exist "%ProgramFiles%\Microsoft Office" goto FoundOffice
if exist "%ProgramFiles(x86)%\Microsoft Office" goto FoundOffice

echo Microsoft Office is not installed.
goto EndOffice

:FoundOffice
echo Microsoft Office is already installed.

:EndOffice


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
if exist "%LOCALAPPDATA%\WebEx" goto FoundWebex

echo Webex is not installed.
goto EndWebex

:FoundWebex
echo Webex is already installed.

:EndWebex


:: Zoom
if exist "%APPDATA%\Zoom" goto FoundZoom
if exist "%ProgramFiles%\Zoom" goto FoundZoom
if exist "%ProgramFiles(x86)%\Zoom" goto FoundZoom

echo Zoom is not installed.
goto EndZoom

:FoundZoom
echo Zoom is already installed.

:EndZoom


echo Installation checks complete.
pause