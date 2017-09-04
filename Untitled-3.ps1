Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
Write-Host -Object "$(Get-Date) - Nacitam GUI"

Write-Host -Object "$(Get-Date) -Nacitani json konfiguracniho souboru"

$json= gc C:\SICZ\hash.json | ConvertFrom-Json

$txtbox_operacnisystem=$json.OS
Write-Host $txtbox_operacnisystem


#####################################################################################
# Skripty a funkcionality - začátek
#####################################################################################


#$oWMIOS = Get-WmiObject win32_OperatingSystem
#$txtHostName.Text = $oWMIOS.PSComputerName
Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem.Text=$json.OS
Write-Host $txtbox_operacnisystem

Write-Host -Object "$(Get-Date) txtbox_nazevstanice"
$txtbox_nazevstanice=$json.ComputerName;
Write-Host $txtbox_nazevstanice

Write-Host -Object "$(Get-Date) txtbox_aktivaceprovedenadne"
$txtbox_aktivaceprovedenadne $json.InstallDate

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

#####################################################################################
# Skripty a funkcionality - konec
#####################################################################################


#===========================================================================
# Zobrazeni formu
#===========================================================================
Write-Host -Object "$(Get-Date) Okno aplikace bylo nacteno"
#$Form.ShowDialog() | out-null
Write-Host -Object "$(Get-Date) Okno aplikace bylo zavreno"