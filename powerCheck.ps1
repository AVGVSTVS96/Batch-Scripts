# Get active power scheme
$powerScheme = powercfg /getactivescheme
$schemeGuid = ($powerScheme -split ' ')[3]

$settings = @(
    @{Name="Display"; Subgroup="SUB_VIDEO"; Setting="VIDEOIDLE"},
    @{Name="Sleep"; Subgroup="SUB_SLEEP"; Setting="STANDBYIDLE"}
)

$powerSourceLabels = @{
    "AC" = "When plugged in";
    "DC" = "On battery"
}

foreach ($powerSource in @("AC", "DC")) {
    Write-Host "$($powerSourceLabels[$powerSource]):"
    foreach ($setting in $settings) {
        $output = powercfg /query $schemeGuid $setting.Subgroup $setting.Setting
        $value = $output | Select-String "Current $powerSource Power Setting Index:"
        if ($value) {
            $hexValue = ($value -split '0x')[1].Trim()
            $decValue = [Convert]::ToInt32($hexValue, 16)
            $minutes = $decValue / 60
            $displayValue = if ($minutes -eq 0) { "Never" } else { "$minutes minutes" }
        } else {
            $displayValue = "Unable to retrieve"
        }
        Write-Host "$($setting.Name) set to: $displayValue"
    }
    Write-Host ""
}
