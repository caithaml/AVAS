#####################################################################################
# Skripty a funkcionality - začátek
#####################################################################################
Write-Host -Object "$(Get-Date) Probiha import json"
$data = gc C:\SICZ\hash.json



Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem=$data.OS
#Write-Host $data.os

Write-Host -Object "$(Get-Date) txtbox_nazevstanice"
$txtbox_nazevstanice=$data.ComputerName
Write-Host -object $txtbox_nazevstanice

Write-Host -Object "$(Get-Date) txtbox_aktivaceprovedenadne"
$txtbox_aktivaceprovedenadne

Write-Host -Object "$(Get-Date) txtbox_nazevsite"
$txtbox_nazevsite=$data.DomainName

Write-Host -Object "$(Get-Date) txtbox_tester"
$txtbox_tester

Write-Host -Object "$(Get-Date) txtbox_nazevuzivatele"
$txtbox_nazevuzivatele=$data.User

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
$txtbox_operacnisystem=$data.OS

Write-Host -Object "$(Get-Date) txtbox_protect"
$txtbox_protect=$data.Protect

Write-Host -Object "$(Get-Date) txtbox_logy"
$txtbox_logy

Write-Host -Object "$(Get-Date) txtbox_zaplnenidisku"
$txtbox_zaplnenidisku

Write-Host -Object "$(Get-Date) txtbox_aplikacegp"
$txtbox_aplikacegp

Write-Host -Object "$(Get-Date) label_chyboveokno"
$label_chyboveokno

Write-Host -Object "$(Get-Date) nacteni aplikaci"
#$label_aplikace=(Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)

#####################################################################################
# Skripty a funkcionality - konec
#####################################################################################

$data.OS
$data.ComputerName