@echo off

echo This script will create desktop shortcuts to Office365 and Outlook Online.

:: Create desktop shortcuts to Office365 and Outlook Online
echo [InternetShortcut] >"%userprofile%\desktop\Office365.url"
echo URL=https://www.office.com/ >>"%userprofile%\desktop\Office365.url"


echo [InternetShortcut] >"%userprofile%\desktop\Outlook Online.url"
echo URL=https://outlook.office.com/ >>"%userprofile%\desktop\Outlook Online.url"
