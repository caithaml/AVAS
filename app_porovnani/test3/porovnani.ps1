Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app_default.json) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test3\app.json)
$rozdil
$rozdil | ConvertTo-Json | Out-File "rozdil.json"
$rozdil | Export-Csv "rozdil$(get-date -f yyyy-MM-dd-hh-mm-ss).csv"