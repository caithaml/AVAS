##########################################
#NACTENI KONFIGURACE
##########################################
#nacteni konfigurace z ini souboru
#popis konfigurace v ini souboru
#
#
#################################################################################################

New-EventLog -LogName Application -Source "AVAS"
Write-EventLog -LogName "Application" -Source "AVAS" -EventId 3001 -EntryType Information -Message "Probehlo spusteni AVAS " -Category 1 


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
$inputfile                                   = Get-FileName -initialDirectory 'D:\SICZ\avas\'
$inputdata                                   = Get-Content $inputfile



$json                                        = $inputdata | ConvertFrom-Json
$jsondef                                     = Get-Content -Path D:\SICZ\avas\hash_luka.json | ConvertFrom-Json

#jsondef je nastaven na pevnou cestu!!! POTREBA ZMENIT!!!



Write-Verbose -Message "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"




$scriptpath = $MyInvocation.MyCommand.Path | Split-Path

$hash                  = New-Object -TypeName PSObject 


if (!(Test-Path -Path "$scriptpath\config.ini")) 
{
  Write-Host -Object "$(Get-Date) - Nelze najit soubor $scriptpath\config.ini `r"
  Stop-Transcript
  exit
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
  Write-Host -message 'debug log neni aktivni, pokracuji dal'
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
  }
}
      
else
{
  Write-Host -message 'pokracuji ve zpracovani'
}
     


if($set.appdifftest -eq '1')
{
  Write-Host -Object 'spoustim test app diff'
  function appdiff
  {
    $app = $jsondef.installed_apps
    $app2 = $json.installed_apps
        
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
 
}  
     
else
{
  Write-Host -message 'pokracuji ve zpracovani bez testu applikaci'
}
$hash | Add-Member Noteproperty Apps (appdiff)


    
    
if($set.servdiff -eq '1')
{
  Write-Host -Object 'spoustim test services diff'
}
function servdiff
{
  $app = $jsondef.services
  $app2 = $json.services
        
  $Diff = ForEach ($line1 in $app)   
  {
    ForEach ($line2 in $app2)   
    {
      IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
      {
        IF ($line1.StartType -ne $line2.StartType)   # If jina verze
        {        
          New-Object -TypeName PSObject -Property @{
            DisplayName = $line1.DisplayName
            StartType   = $line1.StartType
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
  Write-Host -Object 'spoustim test scheduled tasks diff'
}
function schedulediff
{
  $app = $jsondef.scheduled_tasks
  $app2 = $json.scheduled_tasks
        
  $Diff = ForEach ($line1 in $app)   
  {
    ForEach ($line2 in $app2)   
    {
      IF ($line1.FormatEntryinfo -eq $line2.FormatEntryInfo)   # If stejny nazev
      {
        IF ($line1.Outofband -ne $line2.Outofband)   # If jina verze
        {        
          New-Object -TypeName PSObject -Property @{
            formatentryinfo = $line1.formatentryinfo
            outofband       = $line1.outofband
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
  Write-Host -Object 'spoustim test hotfix diff'
}
function hotfixdiff
{
  $app = $jsondef.hotfixes
  $app2 = $json.hotfixes
        
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
          }  
        }
      }
    }                                                
  }
            
  $Diff | Select-Object -Property HotfixID, Description
}
hotfixdiff  
$hash | Add-Member Noteproperty hotfix (hotfixdiff)
   


if($set.processesdiff -eq '1')
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
 
   

if($set.uwpdiff -eq '1')
{
  Write-Host -Object 'spoustim test uwp apps diff'
}
function uwpdiff
{
  <#$def = Get-Content -Path  $scriptpath\mica.json | ConvertFrom-Json  
      $new = Get-Content -Path  $scriptpath\hash_mica.json | ConvertFrom-Json  
  #>
  $app = $jsondef.uwp_apps
  $app2 = $json.uwp_apps
        
  $Diff = ForEach ($line1 in $app)   
  {
    ForEach ($line2 in $app2)   
    {
      IF ($line1.Name -eq $line2.Name)   # If stejny nazev
      {
        IF ($line1.PackageFullName -ne $line2.PackageFullName)   # If jina verze
        {        
          New-Object -TypeName PSObject -Property @{
            Name            = $line1.Name
            PackageFullName = $line1.PackageFullName
          }  
        }
      }
    }                                                
  }
            
  $Diff | Select-Object -Property Name, PackageFullName
}
uwpdiff  
$hash | Add-Member Noteproperty uwp (uwpdiff)
   
   
   if($set.hash -eq '1')
{
  Write-Host -Object 'pridavam hash noteproperty'


$hash | Add-Member Noteproperty Active_DC ($json.Active_DC)
$hash | Add-Member Noteproperty Allow_deviceclasses ($json.Allow_DeviceClasses)
$hash | Add-Member Noteproperty Allow_deviceids ($json.Allow_DeviceIDs)
$hash | Add-Member Noteproperty Application_log_length ($json.Application_Log_Length)
$hash | Add-Member Noteproperty Applocker ($json.AppLocker)
$hash | Add-Member Noteproperty BIOS ($json.BIOS)
$hash | Add-Member Noteproperty Bios_date ($json.BIOS_Date)
$hash | Add-Member Noteproperty Bitlocker ($json.Bitlocker)
$hash | Add-Member Noteproperty Computerturen_root_certifikates ($json.Computer_Root_Certificates) 
$hash | Add-Member Noteproperty ComputerName ($json.ComputerName)
$hash | Add-Member Noteproperty Country ($json.Country)
$hash | Add-Member Noteproperty Date ($json.Date)
$hash | Add-Member Noteproperty Default_locale ($json.Default_Locale)
$hash | Add-Member Noteproperty Deny_deviceclasses ($json.Deny_DeviceClasses)
$hash | Add-Member Noteproperty Deny_deviceids ($json.Deny_DeviceIDs)
$hash | Add-Member Noteproperty deny_UnspecifiedDevices ($json.Deny_UnspecifiedDevices)
$hash | Add-Member Noteproperty Domain ($json.Domain)
$hash | Add-Member Noteproperty Domain_dhcp ($json.Domain_DHCP)
$hash | Add-Member Noteproperty Domain_tcp ($json.Domain_TCP)
$hash | Add-Member Noteproperty AV_MS_product ($json.AV_MS_Product)
$hash | Add-Member Noteproperty AV_MS_residenton ($json.AV_MS_ResidentOn)
$hash | Add-Member Noteproperty AV_MS_scanner_build ($json.AV_MS_Scanner_Build)
$hash | Add-Member Noteproperty AV_MS_scanner_version ($json.AV_MS_Scanner_Version)
$hash | Add-Member Noteproperty AV_MS_version ($json.AV_MS_Version)
$hash | Add-Member Noteproperty OS ($json.OS)

}

#$hash | Add-Member Noteproperty rozdily (Compare-Object -ReferenceObject $json.ComputerName -DifferenceObject $jsondef.ComputerName)
#$hash.rozdily | Out-String

#$hash | Add-Member Noteproperty hdd ($json.local_disks)
#$hash.hdd_rozdil| Out-String 

#$hash | Add-Member Noteproperty pcinfo ($json.pcinfo)
#$hash.PCinfo

$hash | Add-Member NoteProperty Local_groups ($json.Local_Groups)

$hash



   
   if($set.formular -eq '1')
{

$vysledek=$hash.Apps | out-string
$vysledek2=$hash.services 


$vysledkytestu=$hash.Apps,$hash.processes,$hash.hotfix,$hash.services,$hash.scheduledtasks,$hash.uwp


#####################################################################
# FORMULAR 
#####################################################################

$Header = @"
<meta charset="utf-8">
<title>Avas formulář</title>
<style type="text/css">

.header {
	font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
	font-size: 24px;
	font-style: oblique;
}
	
.footer {
	font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
	font-size: 12px;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">

"@

#############
#telo
#############
$tisk = $tisk+'<p>'
$tisk = $tisk+' <header class="header">'
$tisk = $tisk+'  AVAS výsledek testu'+$json.ComputerName
$tisk = $tisk+'	</header>'
$tisk = $tisk+'</p>'
$tisk = $tisk+'<table width="100%" border="1">'
$tisk = $tisk+' <tbody>'
$tisk = $tisk+'  <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Název počítače'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+  $hash.computername
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Uživatel'
$tisk = $tisk+'</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.User
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'      <th align="left" scope="row">'
$tisk = $tisk+'  Poslední uživatel'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Last_User
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Doména'
$tisk = $tisk+'	</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.Domain
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Doména TCP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Domain_TCP
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Doména DHCP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Domain_DHCP
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Název sítě'
$tisk = $tisk+'	</th>'
$tisk = $tisk+'   <td>'
$tisk = $tisk+$json.Site_Name
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Aktivní DC'
$tisk = $tisk+'</th>'
$tisk = $tisk+'   <td>'
$tisk = $tisk+$json.Active_DC
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Operační systém'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.OS
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Operační systém - build'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.OS_Build
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Datum instalace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Install_Date
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  RAM celkem'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.RAM_Total+'MB'
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  Virtualni paměť'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Virtual_Total+'GB'
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'WIN adresář'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.WIN_Dir
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  SYS dir'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.SYS_Dir
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  TEMP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.TEMP_Dir
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'Execution policy'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Execution_Policy
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'<th align="left" scope="row">'
$tisk = $tisk+'Šifrování TEMP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.TEMP_Encrypted
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Protect .ini'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Protect_Ini
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  BIOS'
$tisk = $tisk+'</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.BIOS
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+' Lokalizace systému'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.Locale
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Výchozí lokalizace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Default_Locale
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  GemPlus reader'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.GemPlus_Reader
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+' SEP ochrana'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.SEP_ClientType
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'<th align="left" scope="row">'
$tisk = $tisk+'  NetIP konfigurace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.NetIPConfiguration
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'	  LAPS'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.LAPS
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Místní uživatelé'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Local_Users
$tisk = $tisk+'</td>'
$tisk = $tisk+'  </tr>'
$tisk = $tisk+'  <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Místní skupiny'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Local_Groups
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  Bitlocker'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Bitlocker
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  UEFI x BIOS'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+'UEFI'
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  UEFI oddíl'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.UEFI_partition
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  SecureBoot'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.secureboot
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  Antivirus'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$hash.AV_MS_product+$hash.AV_MS_residenton+$hash.AV_MS_scanner_build+$hash.AV_MS_scanner_version+$hash.AV_MS_version
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  UWF'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.uwp
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' </tbody>'
$tisk = $tisk+'</table>'
$tisk = $tisk+'<h3>'
$tisk = $tisk+'Seznam instalovaného softwaru'
$tisk = $tisk+'</h3>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.Installed_Apps
$tisk = $tisk+'</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'&nbsp;'
	
$tisk = $tisk+'</p>'
$tisk = $tisk+'<h3>'
$tisk = $tisk+'	Seznam naplánovaných úloh'
$tisk = $tisk+'</h3>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.Scheduled_Tasks
$tisk = $tisk+'</p>'

<#
$tisk = $tisk+'<p>'
    $tisk = $tisk+$json.Scheduled_Tasks
    $tisk = $tisk+'	</p>'
#>

$tisk = $tisk+'<p>'
$tisk = $tisk+'	Applocker'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.AppLocker
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	UWP apps'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.UWP_Apps
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'	<footer class="footer">'
$tisk = $tisk+'		Dokument vygenerován dne '
$tisk = $tisk+	$(Get-Date)
$tisk = $tisk+'		uživatelem '
$tisk = $tisk+$env:UserName
$tisk = $tisk+'		na stanici '
$tisk = $tisk+$env:COMPUTERNAME+'/'+$env:UserDomain

$final|
ConvertTo-Html -Head "$Header" -Body "<H2>Výsledek AVAS $(Get-Date)</H2> $tisk " | 
Out-File -FilePath D:\SICZ\AVAS\Testtisk.html
Start-Process -FilePath chrome -ArgumentList D:\SICZ\AVAS\Testtisk.html



############################################################################################################
# FORMULAR - KONEC
############################################################################################################
    Start-Process -FilePath chrome -ArgumentList D:\SICZ\AVAS\Testtisk.html

 }
   




   if($set.gui -eq '1')
{
#==============================================================================================
# GUI
#==============================================================================================
 
   
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="AVAS vysledek testu" 
  $MyForm.Size = New-Object System.Drawing.Size(900,900) 
   
 
    $mLabel1 = New-Object System.Windows.Forms.Label 
        $mLabel1.Text="Jméno stanice" 
        $mLabel1.Top="24" 
        $mLabel1.Left="10" 
        $mLabel1.Anchor="Left,Top" 
    $mLabel1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel1) 
     
 
    $mjmenostanice = New-Object System.Windows.Forms.Label 
        $mjmenostanice.Text=$json.computername
        $mjmenostanice.Top="24" 
        $mjmenostanice.Left="108" 
        $mjmenostanice.Anchor="Left,Top" 
    $mjmenostanice.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenostanice) 
     
 
    $mLabel3 = New-Object System.Windows.Forms.Label 
        $mLabel3.Text="Aktivace provedena dne" 
        $mLabel3.Top="49" 
        $mLabel3.Left="11" 
        $mLabel3.Anchor="Left,Top" 
    $mLabel3.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel3) 
     
 
    $maktivaceprovedenadne = New-Object System.Windows.Forms.Label 
        $maktivaceprovedenadne.Text="Label4" 
        $maktivaceprovedenadne.Top="63" 
        $maktivaceprovedenadne.Left="108" 
        $maktivaceprovedenadne.Anchor="Left,Top" 
    $maktivaceprovedenadne.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($maktivaceprovedenadne) 
     
 
    $mLabel5 = New-Object System.Windows.Forms.Label 
        $mLabel5.Text="Tester" 
        $mLabel5.Top="89" 
        $mLabel5.Left="12" 
        $mLabel5.Anchor="Left,Top" 
    $mLabel5.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel5) 
     
 
    $mtester = New-Object System.Windows.Forms.Label 
        $mtester.Text=$json.User
        $mtester.Top="92" 
        $mtester.Left="110" 
        $mtester.Anchor="Left,Top" 
    $mtester.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mtester) 
     
 
    $mLabel7 = New-Object System.Windows.Forms.Label 
        $mLabel7.Text="Jméno sítě" 
        $mLabel7.Top="117" 
        $mLabel7.Left="13" 
        $mLabel7.Anchor="Left,Top" 
    $mLabel7.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel7) 
     
 
    $mjmenosite = New-Object System.Windows.Forms.Label 
        $mjmenosite.Text=$json.Domain_DHCP
        $mjmenosite.Top="120" 
        $mjmenosite.Left="112" 
        $mjmenosite.Anchor="Left,Top" 
    $mjmenosite.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenosite) 
     
 
    $mLabel9 = New-Object System.Windows.Forms.Label 
        $mLabel9.Text="Jméno uživatele" 
        $mLabel9.Top="24" 
        $mLabel9.Left="210" 
        $mLabel9.Anchor="Left,Top" 
    $mLabel9.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel9) 
     
 
    $mjmenouzivatele = New-Object System.Windows.Forms.Label 
        $mjmenouzivatele.Text=$json.User
        $mjmenouzivatele.Top="26" 
        $mjmenouzivatele.Left="323" 
        $mjmenouzivatele.Anchor="Left,Top" 
    $mjmenouzivatele.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenouzivatele) 
     
 
    $mLabel11 = New-Object System.Windows.Forms.Label 
        $mLabel11.Text="Kancelář" 
        $mLabel11.Top="57" 
        $mLabel11.Left="210" 
        $mLabel11.Anchor="Left,Top" 
    $mLabel11.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel11) 
     
 
    $mkancelar = New-Object System.Windows.Forms.TextBox 
        $mkancelar.Text="TextBox1" 
        $mkancelar.Top="53" 
        $mkancelar.Left="321" 
        $mkancelar.Anchor="Left,Top" 
    $mkancelar.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mkancelar) 
     
 
    $mLabel12 = New-Object System.Windows.Forms.Label 
        $mLabel12.Text="Číslo zásuvbky" 
        $mLabel12.Top="92" 
        $mLabel12.Left="210" 
        $mLabel12.Anchor="Left,Top" 
    $mLabel12.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel12) 
     
 
    $mcislozasuvky = New-Object System.Windows.Forms.TextBox 
        $mcislozasuvky.Text="TextBox2" 
        $mcislozasuvky.Top="87" 
        $mcislozasuvky.Left="321" 
        $mcislozasuvky.Anchor="Left,Top" 
    $mcislozasuvky.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mcislozasuvky) 
     
 
    $mLabel13 = New-Object System.Windows.Forms.Label 
        $mLabel13.Text="Sériové číslo" 
        $mLabel13.Top="118" 
        $mLabel13.Left="212" 
        $mLabel13.Anchor="Left,Top" 
    $mLabel13.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel13) 
     
 
    $mseriovecislo = New-Object System.Windows.Forms.TextBox 
        $mseriovecislo.Text="TextBox3" 
        $mseriovecislo.Top="115" 
        $mseriovecislo.Left="321" 
        $mseriovecislo.Anchor="Left,Top" 
    $mseriovecislo.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mseriovecislo) 


      $mTestvysledek = New-Object System.Windows.Forms.TextBox 
        $mTestvysledek.Text=$vysledek+$hash.apps+$hash.servicess+$vysledek2
        $mTestvysledek.Top="180" 
        $mTestvysledek.Left="19" 
        $mTestvysledek.Anchor="Left,Top" 
        $mtestvysledek.MultiLine = $True
        $mtestvysledek.ScrollBars="vertical"
        $mtestvysledek.BackColor="red"
    $mTestvysledek.Size = New-Object System.Drawing.Size(400,330) 
    $MyForm.Controls.Add($mTestvysledek) 

     $mAktivuj = New-Object System.Windows.Forms.Button 
        $mAktivuj.Text="Aktivuj" 
        $mAktivuj.Top="570" 
        $mAktivuj.Left="4" 
        $mAktivuj.Anchor="Left,Top" 
    $mAktivuj.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mAktivuj) 
     
 
    $marchivuj = New-Object System.Windows.Forms.Button 
        $marchivuj.Text="Archivuj" 
        $marchivuj.Top="570" 
        $marchivuj.Left="119" 
        $marchivuj.Anchor="Left,Top" 
    $marchivuj.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($marchivuj) 
     
 
    $mUkazconfig = New-Object System.Windows.Forms.Button 
        $mUkazconfig.Text="Ukaž config" 
        $mUkazconfig.Top="569" 
        $mUkazconfig.Left="237" 
        $mUkazconfig.Anchor="Left,Top" 
    $mUkazconfig.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mUkazconfig) 
     
 
    $mneshodygp = New-Object System.Windows.Forms.Button 
        $mneshodygp.Text="Neshody GP" 
        $mneshodygp.Top="568" 
        $mneshodygp.Left="351" 
        $mneshodygp.Anchor="Left,Top" 
    $mneshodygp.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mneshodygp) 

    $mtisk = New-Object System.Windows.Forms.Button 
        $mtisk.Text="Tisk protokolu" 
        $mtisk.Top="569" 
        $mtisk.Left="465" 
        $mtisk.Anchor="Left,Top" 
        $mtisk.add_click{
        $Header = @"
<meta charset="utf-8">
<title>Avas formulář</title>
<style type="text/css">

.header {
	font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
	font-size: 24px;
	font-style: oblique;
}
	
.footer {
	font-family: Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
	font-size: 12px;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">

"@

#############
#telo
#############
$tisk = $tisk+'<p>'
$tisk = $tisk+' <header class="header">'
$tisk = $tisk+'  AVAS výsledek testu'+$json.ComputerName
$tisk = $tisk+'	</header>'
$tisk = $tisk+'</p>'
$tisk = $tisk+'<table width="100%" border="1">'
$tisk = $tisk+' <tbody>'
$tisk = $tisk+'  <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Název počítače'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+  $hash.computername
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Uživatel'
$tisk = $tisk+'</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.User
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'      <th align="left" scope="row">'
$tisk = $tisk+'  Poslední uživatel'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Last_User
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Doména'
$tisk = $tisk+'	</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.Domain
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Doména TCP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Domain_TCP
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Doména DHCP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Domain_DHCP
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'   <th align="left" scope="row">'
$tisk = $tisk+'	  Název sítě'
$tisk = $tisk+'	</th>'
$tisk = $tisk+'   <td>'
$tisk = $tisk+$json.Site_Name
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Aktivní DC'
$tisk = $tisk+'</th>'
$tisk = $tisk+'   <td>'
$tisk = $tisk+$json.Active_DC
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Operační systém'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.OS
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Operační systém - build'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.OS_Build
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Datum instalace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Install_Date
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  RAM celkem'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.RAM_Total+'MB'
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  Virtualni paměť'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Virtual_Total+'GB'
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'WIN adresář'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.WIN_Dir
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  SYS dir'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.SYS_Dir
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  TEMP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.TEMP_Dir
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'Execution policy'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Execution_Policy
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'<th align="left" scope="row">'
$tisk = $tisk+'Šifrování TEMP'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.TEMP_Encrypted
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  Protect .ini'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Protect_Ini
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  BIOS'
$tisk = $tisk+'</th>'
$tisk = $tisk+'  <td>'
$tisk = $tisk+$json.BIOS
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+' Lokalizace systému'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.Locale
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Výchozí lokalizace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Default_Locale
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  GemPlus reader'
$tisk = $tisk+'</th>'
$tisk = $tisk+'<td>'
$tisk = $tisk+$json.GemPlus_Reader
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+' SEP ochrana'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.SEP_ClientType
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'<th align="left" scope="row">'
$tisk = $tisk+'  NetIP konfigurace'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.NetIPConfiguration
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'	  LAPS'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.LAPS
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Místní uživatelé'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Local_Users
$tisk = $tisk+'</td>'
$tisk = $tisk+'  </tr>'
$tisk = $tisk+'  <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'  Místní skupiny'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Local_Groups
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  Bitlocker'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.Bitlocker
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  UEFI x BIOS'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+'UEFI'
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  UEFI oddíl'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.UEFI_partition
$tisk = $tisk+'</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+'<tr>'
$tisk = $tisk+' <th align="left" scope="row">'
$tisk = $tisk+'  SecureBoot'
$tisk = $tisk+'</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.secureboot
$tisk = $tisk+'	</td>'
$tisk = $tisk+' </tr>'
$tisk = $tisk+' <tr>'
$tisk = $tisk+'  <th align="left" scope="row">'
$tisk = $tisk+'	  UWF'
$tisk = $tisk+'	</th>'
$tisk = $tisk+' <td>'
$tisk = $tisk+$json.uwp
$tisk = $tisk+'</td>'
$tisk = $tisk+'</tr>'
$tisk = $tisk+' </tbody>'
$tisk = $tisk+'</table>'
$tisk = $tisk+'<h3>'
$tisk = $tisk+'Seznam instalovaného softwaru'
$tisk = $tisk+'</h3>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.Installed_Apps
$tisk = $tisk+'</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'&nbsp;'
	
$tisk = $tisk+'</p>'
$tisk = $tisk+'<h3>'
$tisk = $tisk+'	Seznam naplánovaných úloh'
$tisk = $tisk+'</h3>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.Scheduled_Tasks
$tisk = $tisk+'</p>'

<#
$tisk = $tisk+'<p>'
    $tisk = $tisk+$json.Scheduled_Tasks
    $tisk = $tisk+'	</p>'
#>

$tisk = $tisk+'<p>'
$tisk = $tisk+'	Applocker'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.AppLocker
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	UWP apps'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+$json.UWP_Apps
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'<p>'
$tisk = $tisk+'	&nbsp;'
$tisk = $tisk+'	</p>'
$tisk = $tisk+'	<footer class="footer">'
$tisk = $tisk+'		Dokument vygenerován dne '
$tisk = $tisk+	$(Get-Date)
$tisk = $tisk+'		uživatelem '
$tisk = $tisk+$env:UserName
$tisk = $tisk+'		na stanici '
$tisk = $tisk+$env:COMPUTERNAME+'/'+$env:UserDomain

$final|
ConvertTo-Html -Head "$Header" -Body "<H2>Výsledek AVAS $(Get-Date)</H2> $tisk " | 
Out-File -FilePath D:\SICZ\AVAS\Testtisk.html
Start-Process -FilePath chrome -ArgumentList D:\SICZ\AVAS\Testtisk.html



############################################################################################################
# FORMULAR - KONEC
############################################################################################################
    Start-Process -FilePath chrome -ArgumentList D:\SICZ\AVAS\Testtisk.html

 
        }
    $mtisk.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mtisk) 


    $MyForm.ShowDialog()
    }
