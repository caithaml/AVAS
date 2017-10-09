$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.services
Read-Host "Press any key to exit..."
exit