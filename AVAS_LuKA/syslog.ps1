$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.Logs_System
Read-Host "Press any key to exit..."
exit