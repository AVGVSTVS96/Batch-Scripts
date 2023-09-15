@echo off

:: Create shortcut for Microsoft Word
powershell -ExecutionPolicy Bypass -Command "$TargetFile = 'C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE'; $ShortcutFile = \"$env:Userprofile\Desktop\Word.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

:: Create shortcut for Microsoft Excel
powershell -ExecutionPolicy Bypass -Command "$TargetFile = 'C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE'; $ShortcutFile = \"$env:Userprofile\Desktop\Excel.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

:: Create shortcut for Microsoft Outlook
powershell -ExecutionPolicy Bypass -Command "$TargetFile = 'C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE'; $ShortcutFile = \"$env:Userprofile\Desktop\Outlook.lnk\"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile); $Shortcut.TargetPath = $TargetFile; $Shortcut.Save();"

echo Shortcuts created successfully!
