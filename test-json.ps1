$json = ConvertFrom-Json -InputObject (gc C:\SICZ\hash.json -Raw)

gc C:\SICZ\hash.json


Write-Host $txtbox_nazevstanice=$json.psobject.properties.ComputerName | Select ComputerName -ExpandProperty Type
Write-Host $json ComputerName
Write-Host $txtbox_aktivaceprovedenadne=

Write-Host -Object "$(Get-Date) txtbox_nazevsite"
$txtbox_nazevsite

Write-Host -Object "$(Get-Date) txtbox_tester"
$txtbox_tester

Write-Host -Object "$(Get-Date) txtbox_nazevuzivatele"
$txtbox_nazevuzivatele

Write-Host -Object "$(Get-Date) txtbox_kancelar"
$txtbox_kancelar

Write-Host -Object "$(Get-Date) txtbox_cislozasuvky"
$txtbox_cislozasuvky

Write-Host -Object "$(Get-Date) txtbox_seriovecislo"
$txtbox_seriovecislo

Write-Host -Object "$(Get-Date) txtbox_integritadatovehosouboru"
$txtbox_integritadatovehosouboru

Write-Host -Object "$(Get-Date) txtbox_prostredi"
$txtbox_prostredi

Write-Host -Object "$(Get-Date) txtbox_stavantiviru"
$txtbox_stavantiviru

Write-Host -Object "$(Get-Date) txtbox_scripty"
$txtbox_scripty

Write-Host -Object "$(Get-Date) txtbox_ntsyslog"
$txtbox_ntsyslog

Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem

Write-Host -Object "$(Get-Date) txtbox_protect"
$txtbox_protect

Write-Host -Object "$(Get-Date) txtbox_logy"
$txtbox_logy

Write-Host -Object "$(Get-Date) txtbox_zaplnenidisku"
$txtbox_zaplnenidisku

Write-Host -Object "$(Get-Date) txtbox_aplikacegp"
$txtbox_aplikacegp

Write-Host -Object "$(Get-Date) label_chyboveokno"
$label_chyboveokno

Write-Host -Object "$(Get-Date) nacteni aplikaci"
$label_aplikace=(Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)

$json.psobject.properties.ComputerName | Select ComputerName -eq ComputerName

(Get-Content C:\SICZ\hash.json) -join "`n" | ConvertFrom-Json | Select-String UWF