$json = Get-Content -Path d:\SICZ\hash_mica.json | ConvertFrom-Json
$json.Logs_System
Read-Host -Prompt 'Press any key to exit...'
exit