#nacteni konfigurace z ini souboru

$scriptpath = $MyInvocation.MyCommand.Path | Split-Path


if (!(Test-Path -Path "$scriptpath\config.ini")) 
{
  Write-Host -Object "$(Get-Date) - Nelze najit soubor $scriptpath\config.ini `r"
  Stop-Transcript
  exit
}

Get-Content -Path "$scriptpath\config.ini"  | ForEach-Object -Begin {
  $set = @{}
} -Process {
  $k = [regex]::split($_,'=')
  if(($k[0].CompareTo('') -ne 0) -and ($k[0].StartsWith('#') -ne $true)) 
  {
    $set.Add($k[0], $k[1])
  }
}

    if($set.debug -eq '1')
  {
   Start-Transcript -Path "$scriptpath/vypis$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).txt"
    }
    
    else
    {
   Write-Host -message "zvlastni vypis neni aktivni, pokracuji dal"
    }
   

    if($set.admin -eq '1')
    {
        Write-Verbose -Message "$(Get-Date) - zjisteni zda je uzivatel admin"
        #overeni ze je uzivatel administrator
        Write-Warning -Message 'Kontroluji admin prava'
        if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] 'Administrator'))
        {
          Write-Warning -Message "Skript je nutne spustit s opravneni Administrator!  `n"
          Break 
        }      }
      
      else
      {
     Write-Host -message "pokracuji ve zpracovani"
      }
     
  