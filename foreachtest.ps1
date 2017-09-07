Start-Transcript -Path "./transcriptporovnani$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"



$souborapp = gc C:\SICZ\app.json
$default = gc C:\SICZ\app_default.json




    $prvni = Get-Content $souborapp
    $druhy = Get-Content $default


Write-Host "Spoustim porovnani"
$porovnej = 
compare-Object $prvni $druhy

$porovnej | foreach  { 
      if ($_.sideindicator -eq '<=')
        {$_.sideindicator = $souborapp}

      if ($_.sideindicator -eq '=>')
        {$_.sideindicator = $default}
     }

 $porovnej | 
   select @{l='Hodnota';e={$_.InputObject}},@{l='V souboru';e={$_.SideIndicator}} |
   

  Write-Host "Hotovo"
