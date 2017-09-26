$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.script_start_up
Read-Host "Press any key to exit..."
exit