@echo off
SETLOCAL EnableDelayedExpansion

:: Get the computer name
FOR /F "tokens=*" %%a IN ('hostname') DO SET COMPUTER_NAME=%%a
echo System Name: !COMPUTER_NAME!

:: Get the active power scheme
FOR /F "tokens=2 delims=:(" %%i IN ('powercfg /GETACTIVESCHEME') DO SET SCHEME_GUID=%%i

:: Remove spaces from the GUID
SET SCHEME_GUID=!SCHEME_GUID: =!

:: Get the setting for turning off the display (AC Power)
FOR /F "delims=" %%j IN ('powercfg /QUERY !SCHEME_GUID! SUB_VIDEO VIDEOIDLE ^| findstr /C:"Current AC Power Setting Index"') DO (
    SET line=%%j
    SET DISPLAY_OFF_TIME_HEX=!line:*: 0x=!
)


:: Check if the value is empty
IF "!DISPLAY_OFF_TIME_HEX!"=="" (
    echo Display off time hex value not found
    SET DISPLAY_OFF_TIME=Unknown
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


:: Check if the value is empty
IF "!SLEEP_TIME_HEX!"=="" (
    echo Sleep time hex value not found
    SET SLEEP_TIME=Unknown
) ELSE (
    :: Convert Hex to Dec
    SET /A SLEEP_TIME_DEC=0x!SLEEP_TIME_HEX!
    :: Convert to minutes
    SET /A SLEEP_TIME=!SLEEP_TIME_DEC! / 60
)

:: Display the settings
echo Display turns off after: !DISPLAY_OFF_TIME! minutes
echo PC goes to sleep after: !SLEEP_TIME! minutes

ENDLOCAL
pause
