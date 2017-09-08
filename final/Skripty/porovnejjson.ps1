function Compare-Json {
$default=C:\SICZ\hash_mica.json 
$mujntb=C:\SICZ\hash_luka.json

$obj1 = $($default | ConvertFrom-Json | ConvertTo-Json) -split ([Environment]::NewLine)
$obj2 = $($mujntb | ConvertFrom-Json | ConvertTo-Json) -split ([Environment]::NewLine)

Compare-Object $obj1 $obj2
#Compare-Object -ReferenceObject $obj1 -DifferenceObject $obj2
#Compare-Object -ReferenceObject $default -DifferenceObject $mujntb
Compare-Object -referenceobject $default -differenceobject $mujntb | Select-Object InputObject 
}
Compare-Json

$default=C:\SICZ\hash_mica.json 
$mujntb=C:\SICZ\hash_luka.json
Compare-Object -referenceobject $default -differenceobject $mujntb | Select-Object InputObject