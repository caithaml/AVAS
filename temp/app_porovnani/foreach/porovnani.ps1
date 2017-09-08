$def=(Get-Content C:\SICZ\app_default.json) | ConvertFrom-json
$app=(Get-Content C:\SICZ\app.json) | ConvertFrom-json
$defname=$def|foreach-Object {$_.DisplayName}
$appname=$app|foreach-Object {$_.DisplayName}
$defpor=$def|foreach-Object {$_.DisplayName; $_.Version; $_.Publisher; $_.Name}
$apppor=$app|foreach-Object {$_.DisplayName; $_.Version; $_.Publisher; $_.Name}
$vysledek=Compare-Object $defpor $apppor 
$vysledek


