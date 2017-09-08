$def=Get-Content C:\SICZ\app_default.json | ConvertFrom-json
$app=Get-Content C:\SICZ\app.json | ConvertFrom-json


$vysledek=Compare-Object $def $app | ?{$_.sideIndicator -eq "=>"} | select inputobject
Write-Host "$vysledek"

Compare-Object -ReferenceObject $app_default -DifferenceObject $app | ?{$_.sideIndicator -eq "<="} |select inputobject