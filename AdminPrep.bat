@echo off
REM Launch the PowerShell script with an unrestricted policy and keep the window open
powershell.exe -NoProfile -ExecutionPolicy Bypass -NoExit -File "%~dp0\AdminPrep.ps1"
