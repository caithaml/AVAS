$app1=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher
$app2=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
$app3=Get-AppxPackage -AllUsers
$app=$app1+$app2+$app3
$app
$app | ConvertTo-Json | Out-File "app_default.json"
$app |Out-File "app_default.txt"