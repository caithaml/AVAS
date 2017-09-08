Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
$mica = Get-Content C:\SICZ\hash_mica.json #| ConvertFrom-Json
$luka = Get-Content C:\SICZ\hash_luka.json  #| ConvertFrom-Json
$app= $mica | ConvertFrom-Json
$app2 = $luka | ConvertFrom-Json

Compare-Object $app $app2 #| Where $_.SideIndicator –eq "=>"