$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.Logs_Application
Read-Host "Press any key to exit..."
exit