$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test2\app_default.txt) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test2\app.txt)
$rozdil
$rozdil | ConvertTo-Json | Out-File "rozdil.json"
$rozdil | Out-File "rozdil.txt"