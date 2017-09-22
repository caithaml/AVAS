
$patche=Get-Content "D:\SICZ\avas\AVAS_LuKA\hotfixy.csv" | ConvertFrom-Csv
#$patche
$patche | Out-GridView
#Read-Host "Press any key to exit..."
Write-Host $patche
#exit
