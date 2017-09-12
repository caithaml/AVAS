Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"

