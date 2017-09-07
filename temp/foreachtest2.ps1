Start-Transcript -Path "./transcriptporovnani$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

function porovnejapp {

$souborapp = Read-Host "Soubor default"
$default = Read-Host "Soubor app"

$outsouborapp = Read-Host "Kam ulozit"

Try{
    $prvni = Get-Content $souborapp
    $druhy = Get-Content $default
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

}

porovnejapp