
$souborapp = Read-Host "Soubor default"
$default = Read-Host "Soubor app"

$outsouborapp = Read-Host "Kam ulozit"

Try{
    $prvni = Get-Content -Raw $souborapp
    $druhy = Get-Content -Raw $default
} 
Catch{
    Write-Host "neplatna cesta nebo neexistujici soubor "    
}

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
   Out-File $outsouborapp
$porovnej | Format-List

  Write-Host "Hotovo"