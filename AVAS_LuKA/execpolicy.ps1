$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.Execution_Policy
Read-Host "Press any key to exit..."
exit