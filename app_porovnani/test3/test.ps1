Start-Transcript -Path "temp/transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

$appdef1=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher
$appdef2=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
$appdef3=Get-AppxPackage | Select-Object Name, Version, Publisher
$appdef=$appdef1+$appdef2+$appdef3
$appdef
$appdef | ConvertTo-Json | Out-File "temp/app_default.json"
$appdef |Out-File "temp/app_default.txt"
$appdef1 | Export-Csv "temp/appdef1$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$appdef2 | Export-Csv "temp/appdef2$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$appdef3 | Export-Csv "temp/appdef3$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"

$app1=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher
$app2=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
$app=$app1+$app2
$app1 | Export-Csv "temp/app1$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$app2 | Export-Csv "temp/app2$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$app
$app | ConvertTo-Json | Out-File "temp/app.json"
$app |Out-File "temp/app.txt"

$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app_default.json) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app.json)
$rozdil
$rozdil | ConvertTo-Json | Out-File "temp/rozdil.json"
$rozdil | Export-Csv "temp/rozdil$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"