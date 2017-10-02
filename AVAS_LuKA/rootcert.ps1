$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.Computer_Root_Certificates
Read-Host "Press any key to exit..."
exit