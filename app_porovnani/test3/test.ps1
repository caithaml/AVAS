Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

$appdef1=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher
$appdef2=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
$appdef3=Get-AppxPackage | Select-Object Name, Version, Publisher
$appdef=$appdef1+$appdef2+$appdef3
$appdef
$appdef | ConvertTo-Json | Out-File "app_default.json"
$appdef |Out-File "app_default.txt"
$appdef1 | Export-Csv "appdef1$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$appdef2 | Export-Csv "appdef2$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$appdef3 | Export-Csv "appdef3$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"

$app1=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher
$app2=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
$app=$app1+$app2
$app1 | Export-Csv "app1$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$app2 | Export-Csv "app2$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"
$app
$app | ConvertTo-Json | Out-File "app.json"
$app |Out-File "app.txt"

$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app_default.json) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app.json)
$rozdil
$rozdil | ConvertTo-Json | Out-File "rozdil.json"
$rozdil | Export-Csv "rozdil$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"