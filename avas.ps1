##########################################
#NACTENI KONFIGURACE
##########################################
#nacteni konfigurace z ini souboru
#popis konfigurace v ini souboru
#
#
#################################################################################################

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
   Start-Transcript -Path "$scriptpath/debug-$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).txt"
    }
    
    else
    {
   Write-Host -message "debug log neni aktivni, pokracuji dal"
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
     


      if($set.appdifftest -eq '1')
      {
        Write-Host "spoustim test app diff"
        function appdiff
        {
          $app = Get-Content -Path D:\SICZ\app_default.json | ConvertFrom-Json  
          $app2 = Get-Content -Path D:\SICZ\app.json | ConvertFrom-Json  
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
              {
                IF ($line1.DisplayVersion -ne $line2.DisplayVersion)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    DisplayName    = $line1.DisplayName
                    DisplayVersion = $line1.DisplayVersion
                    Publisher      = $line1.Publisher
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property DisplayName, DisplayVersion, Publisher 
        
        }
  appdiff
  $apps = appdiff
  
          }      
        
        else
        {
       Write-Host -message "pokracuji ve zpracovani bez testu applikaci"
        }


     
