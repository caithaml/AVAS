Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
$def= Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json
$default=$def.Services
$inst=Get-Content C:\SICZ\hash_luka.json | ConvertFrom-Json
$installed=$inst.Services
Compare-Object -ReferenceObject $default -DifferenceObject $installed  -Property DisplayName #| where $_.SideIndicator -EQ "=>"
$vysledek=Compare-Object -ReferenceObject $default -DifferenceObject $installed  -Property DisplayName | where $_.SideIndicator -EQ "=>"
$vysledek