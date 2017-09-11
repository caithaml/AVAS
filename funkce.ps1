Start-Transcript -Path "./funkce-transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) Active DC"
$json.Active_DC

Write-Host -Object "$(Get-Date) Allow deviceclasses"
$json.Allow_DeviceClasses

Write-Host -Object "$(Get-Date) Allow deviceids"
$json.Allow_DeviceIDs

Write-Host -Object "$(Get-Date) app log lenght"
$json.Application_Log_Length

Write-Host -Object "$(Get-Date) applocker"
$json.AppLocker

Write-Host -Object "$(Get-Date) bios"
$json.BIOS

Write-Host -Object "$(Get-Date) bios datum"
$json.BIOS_Date

Write-Host -Object "$(Get-Date) bitlocker"
$json.Bitlocker

Write-Host -Object "$(Get-Date) root certifikaty"
$json.Computer_Root_Certificates

Write-Host -Object "$(Get-Date) PC nazev"
$json.ComputerName

Write-Host -Object "$(Get-Date) zeme - lokalizace"
$json.Country

Write-Host -Object "$(Get-Date) default locale"
$json.Default_Locale

Write-Host -Object "$(Get-Date) deny device class"
$json.Deny_DeviceClasses

Write-Host -Object "$(Get-Date) deny devices ID"
Write-Host -Object " ($json.Deny_DeviceIDs)"