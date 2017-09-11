$def= Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json
$default=$def.hotfixes
$inst=Get-Content C:\SICZ\hash_luka.json | ConvertFrom-Json
$installed=$inst.hotfixes
Compare-Object -ReferenceObject $default -DifferenceObject $installed  -Property HotFixID

$hotfixy=$def.Hotfixes
$hotfixy2=$inst.Hotfixes