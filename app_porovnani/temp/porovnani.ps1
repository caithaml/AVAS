$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test\app_default.json) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test\app.json)
$rozdil
$rozdil | ConvertTo-Json | Out-File "rozdil.json"

#vyuziva cvicne soubory na me vlastni ceste - standardni cesta D:\SICZ\xxx