##########################################
#NACTENI KONFIGURACE
##########################################
#nacteni konfigurace z ini souboru
#popis konfigurace v ini souboru
#
#
#################################################################################################
$transcriptname = Get-Date -UFormat 'AVAS_%Y_%m_%d'


Start-Transcript -Path "$scriptpath\$transcriptname.log" -Append

## debug transcript - debug vymazat!!

Start-Transcript -Path "./transcript$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).txt"

######


#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
Function Get-FileName($initialDirectory)
{
  $null = [System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')
    
  $OpenFileDialog                  = New-Object -TypeName System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.filter           = 'JSON (*.json)| *.json'
  $null = $OpenFileDialog.ShowDialog()
  $OpenFileDialog.filename
}
$inputfile                                   = Get-FileName 'C:\SICZ'
$inputdata                                   = Get-Content $inputfile



$json                                        = $inputdata | ConvertFrom-Json
$jsondef                                     = Get-Content -Path D:\SICZ\hash_luka.json | ConvertFrom-Json





#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Verbose -Message "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json                        = Get-Content -Path D:\SICZ\hash_mica.json | ConvertFrom-Json
$jsondef                     = Get-Content -Path D:\SICZ\hash_luka.json | ConvertFrom-Json

Write-Verbose -Message "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"


Write-Verbose -Message "$(Get-Date) - zjisteni zda je uzivatel admin"
#overeni ze je uzivatel administrator
Write-Verbose -Message 'Kontroluji admin prava'
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
  Write-Warning -Message "Skript je nutne spustit s opravneni Administrator! Spustne skript znovu! `n"
  #Break 
  # z duvodu vyvoje nen� povoleno zastaveni!!
}





$scriptpath = $MyInvocation.MyCommand.Path | Split-Path

$hash                  = New-Object -TypeName PSObject 


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
   Start-Transcript -Path "$scriptpath/debug-$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).log"
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
          <#$def = Get-Content -Path $scriptpath\hash_mica.json | ConvertFrom-Json  
          $new = Get-Content -Path $scriptpath\mica.json | ConvertFrom-Json#>  
          
          

          $app=$jsondef.installed_apps
          $app2=$json.installed_apps
        
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
        $hash | Add-Member Noteproperty Apps (appdiff)


    
    
      if($set.servdiff -eq '1')
      {
        Write-Host "spoustim test services diff"
      }
        function servdiff
        {
          <#$def = Get-Content -Path $scriptpath\hash_luka_admin.json | ConvertFrom-Json  
          $new = Get-Content -Path $scriptpath\mica.json | ConvertFrom-Json#>  

          $app=$jsondef.services
          $app2=$json.services
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
              {
                IF ($line1.StartType -ne $line2.StartType)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    DisplayName    = $line1.DisplayName
                    StartType = $line1.StartType
                    
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property DisplayName, StartType
        
        }
  servdiff  
   $hash | Add-Member Noteproperty services (servdiff)
      



      
      
           
     if($set.schedulediff -eq '1')
      {
        Write-Host "spoustim test scheduled tasks diff"
      }
        function schedulediff
        {
          <#$def = Get-Content -Path $scriptpath\hash_luka_admin.json | ConvertFrom-Json  
          $new = Get-Content -Path $scriptpath\mica.json | ConvertFrom-Json#>  

          $app=$jsondef.scheduled_tasks
          $app2=$json.scheduled_tasks
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.FormatEntryinfo -eq $line2.FormatEntryInfo)   # If stejny nazev
              {
                IF ($line1.Outofband -ne $line2.Outofband)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    formatentryinfo    = $line1.formatentryinfo
                    outofband = $line1.outofband
                    #Publisher      = $line1.Publisher
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property formatentryinfo, outofband
        
        }
  schedulediff  
   $hash | Add-Member Noteproperty scheduledtasks (schedulediff)    



    if($set.hotfixdiff -eq '1')
      {
        Write-Host "spoustim test hotfix diff"
      }
        function hotfixdiff
        {
          $def = Get-Content -Path $scriptpath\hash_mica.json | ConvertFrom-Json  
          $new = Get-Content -Path $scriptpath\hash_luka.json | ConvertFrom-Json  

          $app=$def.hotfixes
          $app2=$new.hotfixes
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.HotfixID -eq $line2.HotfixID)   # If stejny nazev
              {
                IF ($line1.Description -ne $line2.Description)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    HotfixID    = $line1.HotfixID
                    Description = $line1.Description
                    #Publisher      = $line1.Publisher
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property HotfixID, Description
        
        }
  hotfixdiff  
   $hash | Add-Member Noteproperty hotfix (hotfixdiff)
   


    <#if($set.processesdiff -eq '1')
      {
        Write-Host "spoustim test services diff"
      }
        function processesdiff
        {
          $def = Get-Content -Path $scriptpath\hash_luka.json | ConvertFrom-Json  
          $new = Get-Content -Path $scriptpath\mica.json | ConvertFrom-Json  

          $app=$def.processes
          $app2=$new.processes
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.Product -eq $line2.Product)   # If stejny nazev
              {
                IF ($line1.Description -ne $line2.Description)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    Product    = $line1.Product
                    Description = $line1.Description
                    #Publisher      = $line1.Publisher
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property Product, Description
        
        }

    processesdiff  
    $hash | Add-Member Noteproperty processes (processesdiff)
#>   
   

   if($set.uwpdiff -eq '1')
      {
        Write-Host "spoustim test uwp apps diff"
      }
        function uwpdiff
        {
          $def = Get-Content -Path  $scriptpath\mica.json | ConvertFrom-Json  
          $new = Get-Content -Path  $scriptpath\hash_mica.json | ConvertFrom-Json  

          $app=$def.uwp_apps
          $app2=$new.uwp_apps
        
          $Diff = ForEach ($line1 in $app)   
          {
            ForEach ($line2 in $app2)   
            {
              IF ($line1.Name-eq $line2.Name)   # If stejny nazev
              {
                IF ($line1.PackageFullName -ne $line2.PackageFullName)   # If jina verze
                {        
                  New-Object -TypeName PSObject -Property @{
                    Name    = $line1.Name
                   PackageFullName = $line1.PackageFullName
                    #Publisher      = $line1.Publisher
                  }  
                }
              }
            }                                                
          }
            
          $Diff | Select-Object -Property Name, PackageFullName
        
        }
  uwpdiff  
   $hash | Add-Member Noteproperty uwp (uwpdiff)
   

