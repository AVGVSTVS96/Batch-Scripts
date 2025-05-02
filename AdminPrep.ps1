# AdminPrep.ps1
# PowerShell 5.1+ / 7.x, Windows

# — Elevation check & relaunch as admin —
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Host "!! Elevation required -- relaunching as administrator ..." -ForegroundColor Yellow
  $args = "-NoProfile","-ExecutionPolicy","Bypass","-File","`"$PSCommandPath`""
  Start-Process -FilePath powershell.exe -ArgumentList $args -Verb RunAs
  exit
}

# — Task implementations with ASCII hyphens —
function Setup-WiFi {
  Write-Host "Adding Wi-Fi profiles..." -ForegroundColor Cyan
  $ssids = "NYCBAR-GN","NYCBAR-AN","NYCBAR-KN"
  foreach ($s in $ssids) {
    Write-Host ("  - {0,-12} " -f $s) -NoNewline
    $tmp = Join-Path $env:TEMP ("{0}.xml" -f $s)
    @"
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
  <name>$s</name>
  <SSIDConfig><SSID><name>$s</name></SSID></SSIDConfig>
  <connectionType>ESS</connectionType><connectionMode>auto</connectionMode>
  <MSM><security>
    <authEncryption>
      <authentication>WPA2PSK</authentication>
      <encryption>AES</encryption>
      <useOneX>false</useOneX>
    </authEncryption>
    <sharedKey>
      <keyType>passPhrase</keyType>
      <protected>false</protected>
      <keyMaterial>abcnycenter</keyMaterial>
    </sharedKey>
  </security></MSM>
</WLANProfile>
"@ | Out-File -FilePath $tmp -Encoding ASCII

    if (netsh wlan add profile filename="$tmp" | Out-Null) {
      Write-Host "[OK]" -ForegroundColor Green
    } else {
      Write-Host "[ERROR]" -ForegroundColor Red
    }
  }
}

function Disable-BitLocker {
  Write-Host "Disabling BitLocker..." -ForegroundColor Cyan
  Write-Host -NoNewline "  - Turn off encryption:     "
  manage-bde -off C: | Out-Null
  Write-Host "[OK]" -ForegroundColor Green

  Write-Host -NoNewline "  - Stop & disable service:  "
  net stop BDESVC | Out-Null
  & sc.exe config BDESVC start=disabled | Out-Null
  if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK]" -ForegroundColor Green
  } else {
    Write-Host "[ERROR]" -ForegroundColor Red
  }
}

function Install-AnyDesk {
  Write-Host "Installing AnyDesk..." -ForegroundColor Cyan
  Write-Host -NoNewline "  - Checking internet:       "
  while (-not (Test-Connection www.google.com -Count 1 -Quiet)) {
    Start-Sleep -Seconds 1
  }
  Write-Host "[OK]" -ForegroundColor Green

  $url  = "https://download.anydesk.com/AnyDesk.exe"
  $dst  = Join-Path $env:USERPROFILE "Desktop\AnyDesk.exe"
  Write-Host -NoNewline "  - Download to Desktop:     "
  if (Test-Path $dst) {
    Write-Host "[SKIP]" -ForegroundColor Yellow
  } else {
    Invoke-WebRequest $url -OutFile $dst -UseBasicParsing -ErrorAction SilentlyContinue
    if (Test-Path $dst) {
      Write-Host "[OK]" -ForegroundColor Green
    } else {
      Write-Host "[ERROR]" -ForegroundColor Red
    }
  }
}

function Add-RDPShortcut {
  Write-Host "Adding RDP shortcut..." -ForegroundColor Cyan
  $lnk = Join-Path $env:USERPROFILE "Desktop\Remote Desktop Connection.lnk"
  Write-Host -NoNewline "  - Create link:            "
  if (Test-Path $lnk) {
    Write-Host "[SKIP]" -ForegroundColor Yellow
  } else {
    $shell = New-Object -ComObject WScript.Shell
    $sc    = $shell.CreateShortcut($lnk)
    $sc.TargetPath = "C:\Windows\System32\mstsc.exe"
    $sc.Save()
    if (Test-Path $lnk) {
      Write-Host "[OK]" -ForegroundColor Green
    } else {
      Write-Host "[ERROR]" -ForegroundColor Red
    }
  }
}

# — Menu items & cursor setup —
$menu = @(
  @{Name="Setup Wi-Fi";        Action={ Setup-WiFi }},
  @{Name="Disable BitLocker"; Action={ Disable-BitLocker }},
  @{Name="Install AnyDesk";   Action={ Install-AnyDesk }},
  @{Name="Add RDP Shortcut";  Action={ Add-RDPShortcut }},
  @{Name="Run All Tasks";     Action={
      for ($i=0; $i -lt 4; $i++) {
        Write-Host "`n>> $($menu[$i].Name)" -ForegroundColor Magenta
        & $menu[$i].Action
      }
    }},
  @{Name="Exit";              Action={ exit }}
)
$cursor = 0

function Draw-Menu {
  Clear-Host
  Write-Host "+--------------------------------+" -ForegroundColor Cyan
  Write-Host "|        ADMIN PREP TASKS        |" -ForegroundColor Cyan
  Write-Host "+--------------------------------+" -ForegroundColor Cyan
  for ($i=0; $i -lt $menu.Count; $i++) {
    if ($i -eq $cursor) {
      Write-Host ("> {0}" -f $menu[$i].Name) -ForegroundColor White -BackgroundColor DarkBlue
    } else {
      Write-Host ("  {0}" -f $menu[$i].Name)
    }
  }
}

# — Main loop: arrow navigation + Enter to select —
while ($true) {
  Draw-Menu
  $key = [Console]::ReadKey($true).Key
  switch ($key) {
    'UpArrow'   { if ($cursor -gt 0) { $cursor-- } }
    'DownArrow' { if ($cursor -lt $menu.Count - 1) { $cursor++ } }
    'Enter'     {
      Clear-Host
      & $menu[$cursor].Action
      Write-Host "`nPress any key to return to main menu..." -ForegroundColor DarkGray
      [Console]::ReadKey($true) | Out-Null
    }
  }
}
