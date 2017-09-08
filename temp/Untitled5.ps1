$mica= Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json  
$luka = Get-Content C:\SICZ\hash_luka.json | ConvertFrom-Json 

Write-Host= "$mica.Active_DC"
Write-Host= "$mica.Allow_DeviceClasses"
Write-Host ="$mica.Allow_DeviceIDs"
Write-Host ="$mica.Application_Log_Length"
Write-Host ="$mica.AppLocker"
Write-Host ="$mica.BIOS"
Write-Host ="$mica.BIOS_Date"
Write-Host ="$mica.Bitlocker"
Write-Host ="$mica.Computer_Root_Certificates"
Write-Host ="$mica.ComputerName"
Write-Host ="$mica.Country"
Write-Host ="$mica.Date"

$mica.Last_User

$app= Get-Content C:\SICZ\app_default.json | ConvertFrom-Json  
$app2 = Get-Content C:\SICZ\app.json | ConvertFrom-Json  
	

Compare-Object $app $app2 –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" 
Group-Object -Property DisplayName | % { New-Object psobject -Property @{        
    DisplayName=$_.DisplayName
    DisplayVersion=$_.group[0].DisplayVersion
   Publisher=$_.group[0].Publisher    
}} | Select DisplayName, DisplayVersion, Publisher


$Diff = ForEach ($line1 in $app)   
{
    ForEach ($line2 in $app2)   
        {
            IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
                {
                    IF ($line1.DisplayVersion -ne $line2.DisplayVersion)   # If jina verze
                        {        
                            New-Object -TypeName PSObject -Property @{
                                DisplayName = $line1.DisplayName   
                                DisplayVersion = $line1.DisplayVersion   
                                Publisher = $line1.Publisher
                                
                                }  
                        }
                }
        }                                                
}

$Diff | select DisplayName, DisplayVersion, Publisher 
$Diff
#$Diff | Format-List
#$Diff | Out-GridView


$mica= Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json  
$luka = Get-Content C:\SICZ\hash_luka.json | ConvertFrom-Json 

$aplikacemica=$mica.Installed_Apps
$aplikaceluka=$luka.Installed_Apps

$aplikacemica
$aplikaceluka

Compare-Object $aplikacemica $aplikaceluka –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" 
Group-Object -Property DisplayName | % { New-Object psobject -Property @{        
    DisplayName=$_.DisplayName
    DisplayVersion=$_.group[0].DisplayVersion
   Publisher=$_.group[0].Publisher    
}} | Select DisplayName, DisplayVersion, Publisher


$Diff = ForEach ($line1 in $aplikacemica)   
{
    ForEach ($line2 in $aplikaceluka)   
        {
            IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
                {
                    IF ($line1.DisplayVersion -ne $line2.DisplayVersion)   # If jina verze
                        {        
                            New-Object -TypeName PSObject -Property @{
                                DisplayName = $line1.DisplayName   
                                DisplayVersion = $line1.DisplayVersion   
                                Publisher = $line1.Publisher
                                
                                }  
                        }
                }
        }                                                
}

$Diff | select DisplayName, DisplayVersion, Publisher | Format-List
#$Diff | Format-List
#$Diff | Out-GridView

$mica
$luka

$mica.System_Locale

$mica.Hotfixes
$luka.Hotfixes

<#..............................................................
    Script name: icwsc_object.ps1
    Creation Date: 01.11.2013
    Last Modified: sobota 19. srpna 2017 19:07:42
    Version: 0.1
    **************************************************************
    Description: ICWSC skript pro ziskani informaci o pc
    **************************************************************
    Authors: 
    mica S.ICZ 
    LuKa S.ICZ                                            
..............................................................#>

Clear-Host
$ErrorActionPreference = 'SilentlyContinue'
#konfigurace sberu logu
$limitlogs = (Get-Date).AddDays(-35)  
$System = Get-WmiObject -Class win32_OperatingSystem
$win32_bios = Get-WmiObject -Class win32_bios

$hash = New-Object -TypeName PSObject 
$hash | Add-Member Noteproperty ComputerName $env:COMPUTERNAME
$hash | Add-Member Noteproperty Date $(Get-Date)
$hash | Add-Member Noteproperty User $env:USERNAME
$hash | Add-Member Noteproperty Last_User (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon').DefaultUserName
$hash | Add-Member Noteproperty Domain (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon').DefaultDomainName
$hash | Add-Member Noteproperty Domain_TCP (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters').Domain
$hash | Add-Member Noteproperty Domain_DHCP (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters').DHCPDomain
$hash | Add-Member Noteproperty Site_Name (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine').'Site-Name'
#$hash | Add-Member NoteProperty GroupPolicy_settings (Get-GPResultantSetofPolicy)
$hash | Add-Member Noteproperty Active_DC (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\History').DCName
$hash | Add-Member Noteproperty Script_StartUp (Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Startup\' | ForEach-Object -Process {
    if ((Get-ItemProperty -Path $_.PSPath).'GPO-ID' -ne 'LocalGPO') 
    {
      (Get-ItemProperty -Path $_.PSPath).FileSysPath
    }
})
$hash | Add-Member Noteproperty Script_ShutDown (Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown\' | ForEach-Object -Process {
    if ((Get-ItemProperty -Path $_.PSPath).'GPO-ID' -ne 'LocalGPO') 
    {
      (Get-ItemProperty -Path $_.PSPath).FileSysPath
    }
})

$hash | Add-Member Noteproperty OS ($System).Caption 
$hash | Add-Member Noteproperty OS_Build ($System).Version
$hash | Add-Member Noteproperty SP ($System).ServicePackMajorVersion
$hash | Add-Member Noteproperty Install_Date ($System).ConvertToDateTime(($System).InstallDate) 
$hash | Add-Member Noteproperty Last_Boot_Time (Get-CimInstance -ClassName win32_operatingsystem).lastbootuptime
$hash | Add-Member Noteproperty RAM_Total $([Math]::round($((Get-WmiObject -Class win32_ComputerSystem).TotalPhysicalMemory /1MB)))
$hash | Add-Member Noteproperty RAM_Free $([Math]::round(($System).FreePhysicalMemory /1MB))
$hash | Add-Member Noteproperty Virtual_Total $([Math]::round(($System).TotalVirtualMemorySize /1MB))
$hash | Add-Member Noteproperty Virtual_Free $([Math]::round(($System).FreeVirtualMemory /1MB))
$hash | Add-Member Noteproperty WIN_Dir ($System).WindowsDirectory
$hash | Add-Member Noteproperty SYS_Dir ($System).SystemDirectory 
$hash | Add-Member Noteproperty TEMP_Dir $($env:WINDIR + '\TEMP')
$hash | Add-Member Noteproperty Execution_Policy (Get-ExecutionPolicy -List)
$hash | Add-Member Noteproperty TEMP_Encrypted $(if (Test-Path -Path D:\@TEMP\) 
  {
    Write-Output -InputObject Y
  }
  else 
  {
    Write-Output -InputObject N
  }
)
$hash | Add-Member Noteproperty Protect_Ini $(
  $a = Get-Content -Path D:\@TEMP\protect.ini
  if ($a -contains '[Protect]' -and $a -contains 'ALGORITHM=WinCros II' -and $a -match 'STRENGTH=' -and $a -match 'KEYLEN=') 
  {
    $result = 'Y'
  }
  else 
  {
    $result = 'N'
  }
  function Get-FileAttribute
  {
    param($file,$attribute)
    $val = [System.IO.FileAttributes]$attribute
    if((Get-ChildItem $file -Force).Attributes -band $val -eq $val)
    {
      $true
    }
    else 
    {
      $false
    }
  } 
  if (Get-FileAttribute -file D:\@TEMP\protect.ini -attribute 'ReadOnly') 
  {
    $result = "$result" + 'Y'
  }
  else 
  {
    $result = "$result" + 'N'
  }
$result)

function Get-DiskFree
{
  [CmdletBinding()]
  param 
  (
    [Parameter(Position = 0,
        ValueFromPipeline = $true,
    ValueFromPipelineByPropertyName = $true)]
    [Alias('hostname')]
    [Alias('cn')]
    [string[]]$ComputerName = $env:COMPUTERNAME,
        
    [Parameter(Position = 1,
    Mandatory = $false)]
    [Alias('runas')]
    [System.Management.Automation.Credential()]$Credential = 
    [System.Management.Automation.PSCredential]::Empty,
        
    [Parameter(Position = 2)]
    [switch]$Format
  )
    
  BEGIN
  {
    function Format-HumanReadable 
    {
      param ($size)
      switch ($size) 
      {
        {
          $_ -ge 1PB
        }
        {
          "{0:#.#'P'}" -f ($size / 1PB)
          break
        }
        {
          $_ -ge 1TB
        }
        {
          "{0:#.#'T'}" -f ($size / 1TB)
          break
        }
        {
          $_ -ge 1GB
        }
        {
          "{0:#.#'G'}" -f ($size / 1GB)
          break
        }
        {
          $_ -ge 1MB
        }
        {
          "{0:#.#'M'}" -f ($size / 1MB)
          break
        }
        {
          $_ -ge 1KB
        }
        {
          "{0:#'K'}" -f ($size / 1KB)
          break
        }
        default 
        {
          '{0}' -f ($size) + 'B'
        }
      }
    }
        
    $wmiq = 'SELECT * FROM Win32_LogicalDisk WHERE Size != Null AND DriveType >= 2'
  }
    
  PROCESS
  {
    foreach ($computer in $ComputerName)
    {
      try
      {
        if ($computer -eq $env:COMPUTERNAME)
        {
          $disks = Get-WmiObject -Query $wmiq `
          -ComputerName $computer -ErrorAction Stop
        }
        else
        {
          $disks = Get-WmiObject -Query $wmiq `
          -ComputerName $computer -Credential $Credential `
          -ErrorAction Stop
        }
                
        if ($Format)
        {
          # Create array for $disk objects and then populate
          $diskarray = @()
          $disks | ForEach-Object -Process {
            $diskarray += $_
          }
                    
          $diskarray | Select-Object -Property @{
            n = 'Name'
            e = {
              $_.SystemName
            }
          }, 
          @{
            n = 'Vol'
            e = {
              $_.DeviceID
            }
          }, 
          @{
            n = 'Size'
            e = {
              Format-HumanReadable $_.Size
            }
          }, 
          @{
            n = 'Used'
            e = {
              Format-HumanReadable `
              (($_.Size)-($_.FreeSpace))
            }
          }, 
          @{
            n = 'Avail'
            e = {
              Format-HumanReadable $_.FreeSpace
            }
          }, 
          @{
            n = 'Use%'
            e = {
              [int](((($_.Size)-($_.FreeSpace))`
              /($_.Size) * 100))
            }
          }, 
          @{
            n = 'FS'
            e = {
              $_.FileSystem
            }
          }, 
          @{
            n = 'Type'
            e = {
              $_.Description
            }
          }
        }
        else 
        {
          foreach ($disk in $disks)
          {
            $diskprops = @{
              'Volume'   = $disk.DeviceID
              'Size'     = $disk.Size
              'Used'     = ($disk.Size - $disk.FreeSpace)
              'Available' = $disk.FreeSpace
              'FileSystem' = $disk.FileSystem
              'Type'     = $disk.Description
              'Computer' = $disk.SystemName
            }
                    
            # Create custom PS object and apply type
            $diskobj = New-Object -TypeName PSObject `
            -Property $diskprops
            $diskobj.PSObject.TypeNames.Insert(0,'BinaryNature.DiskFree')
                    
            Write-Output -InputObject $diskobj
          }
        }
      }
      catch 
      {
        # Check for common DCOM errors and display "friendly" output
        switch ($_)
        {
          {
            $_.Exception.ErrorCode -eq 0x800706ba
          } `
          
          {
            $err = 'Unavailable (Host Offline or Firewall)' 
            break
          }
          {
            $_.CategoryInfo.Reason -eq 'UnauthorizedAccessException'
          } `
          
          {
            $err = 'Access denied (Check User Permissions)' 
            break
          }
          default 
          {
            $err = $_.Exception.Message
          }
        }
        Write-Warning "$computer - $err"
      } 
    }
  }
    
  END {}
}


$hash | Add-Member NoteProperty Local_Disks (Get-DiskFree)
$hash | Add-Member Noteproperty BIOS $(($win32_bios).Version + ' | ' + ($win32_bios).Name)
$hash | Add-Member Noteproperty BIOS_Date ($win32_bios).ConvertToDateTime(($win32_bios).ReleaseDate)
$hash | Add-Member Noteproperty System_Locale (Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Nls\Locale').'(Default)'
$hash | Add-Member Noteproperty Default_Locale (Get-ItemProperty -Path 'Microsoft.Powershell.Core\Registry::HKEY_USERS\.Default\Control Panel\International').'Locale'
$hash | Add-Member Noteproperty Country (Get-ItemProperty -Path 'HKCU:\Control Panel\International').'iCountry'
$hash | Add-Member Noteproperty Locale (Get-ItemProperty -Path 'HKCU:\Control Panel\International').'Locale'
$hash | Add-Member Noteproperty GemPlus_Reader $(if (Test-Path -Path C:\windows\system32\drivers\gemser.sys) 
  {
    Write-Output -InputObject 'Installed'
  }
  else 
  {
    Write-Output -InputObject 'Not Installed'
  }
)

$hash | Add-Member Noteproperty Dslog_Service $(if (Get-Service -Name Dslog -ErrorAction SilentlyContinue) 
  {
    (Get-Service -Name Dslog -ErrorAction Ignore).status
  }
  else 
  {
    Write-Output -InputObject 'Not Installed'
  }
)
### TEST AV
# OS Windows server
if($System.ProductType -eq 3) {$AV_Products = Get-WmiObject -Namespace root\cimv2 -Class Win32_Product -Filter "Name like '%Symantec%' or Name like '%ESET%'"}
# OS Windows client
else {$AV_Products = (Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct).displayName}

foreach($tmp in $AV_Products) {
    # ESET
    if($tmp -match 'ESET') {
        $hash | Add-Member NoteProperty AV_ESET_Product (Get-ItemProperty 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ProductName
        if((Get-Service -Name ekrn).Status -eq 'running') {$hash | Add-Member NoteProperty AV_ESET_ResidentOn $true}
        else {$hash | Add-Member NoteProperty AV_ESET_ResidentOn $false}
        $hash | Add-Member NoteProperty AV_ESET_Version (Get-ItemProperty 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ProductVersion
        $hash | Add-Member NoteProperty AV_ESET_Scanner_Build (Get-ItemProperty 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ScannerBuild
        $hash | Add-Member NoteProperty AV_ESET_Scanner_Version (Get-ItemProperty 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ScannerVersion
    }

    # Symantec
    if($tmp -match 'Symantec') {
        #ver 12
        #?cteni z registru preklada HEX -> DEC, format - ('{0:x}' -f Get-Item...)
        $hash | Add-Member NoteProperty AV_SEP_Product (Get-ItemProperty 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion').ProductName
        if((Get-Service -Name SepMasterService).Status -eq 'running') {$hash | Add-Member NoteProperty AV_SEP_ResidentOn $true}
        else {$hash | Add-Member NoteProperty AV_SEP_ResidentOn $false}
        $hash | Add-Member NoteProperty AV_SEP_Version (Get-ItemProperty 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion').ProductVersion
        $hash | Add-Member NoteProperty AV_SEP_Scanner_Build (Get-Item -Path "$((Get-ItemProperty 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').'Home Directory')$((Get-ItemProperty 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').VirusEngine)" | Select-Object -ExpandProperty VersionInfo).ProductVersion
        $hash | Add-Member NoteProperty AV_SEP_Scanner_Version (Get-ItemProperty 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').ScanEngineVersion
    }
}

# Windows Defender
#$hash | Add-Member NoteProperty AV_MS Get-MpComputerStatus

$hash | Add-Member NoteProperty AV_MS_Product 'Windows Defender'
if((Get-Service -Name WinDefend).Status -ne 'running' -or (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows Defender').DisableAntiSpyware -eq 1 -or (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows Defender').DisableAntiVirus -eq 1) {$hash | Add-Member NoteProperty AV_MS_ResidentOn $false}
else {$hash | Add-Member NoteProperty AV_MS_ResidentOn $true}
$hash | Add-Member NoteProperty AV_MS_Version (Get-Item "$env:ProgramFiles\Windows Defender\MSASCui.exe" | Select-Object -ExpandProperty VersionInfo).ProductVersion
$hash | Add-Member NoteProperty AV_MS_Scanner_Build (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates').EngineVersion
$hash | Add-Member NoteProperty AV_MS_Scanner_Version (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates').AVSignatureVersion

### LOGS
$hash | Add-Member Noteproperty System_Log_Length $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path C:\windows\system32\config\SySEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\System.Evtx).Length
  }
) 
$hash | Add-Member Noteproperty Secrutiy_Log_Length $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path C:\windows\system32\config\SecEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\Security.Evtx).Length
  }
) 
$hash | Add-Member Noteproperty Application_Log_Length $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path C:\windows\system32\config\AppEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\Application.evtx).Length
  }
)
$hash | Add-Member Noteproperty Setupapi_Length (Get-ChildItem -Path C:\windows\setupapi.log).Length
$hash | Add-Member NoteProperty NetIPConfiguration (Get-NetIPConfiguration)

if (Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{937A3762-F1D545F3-AA20-F7C5CBA7FBAC')
{
  $result = 'Installed'
}
else 
{
  $result = 'Not Installed'
}
$hash | Add-Member Noteproperty LAPS $result 

$hash | Add-Member NoteProperty Computer_Root_Certificates (Get-ChildItem -Path Cert:\LocalMachine\Root | Format-List)
$hash | Add-Member NoteProperty Local_Users (Get-LocalUser)
$hash | Add-Member NoteProperty Local_Groups (Get-LocalGroup)
$hash | Add-Member NoteProperty PCinfo (Get-ComputerInfo)
$hash | Add-Member NoteProperty Logs_Application $(Get-WinEvent -FilterHashtable @{

    logname   = 'Application'
    level     = 2, 3
    StartTime = $limitlogs
})
$hash | Add-Member NoteProperty Logs_System $(Get-WinEvent -FilterHashtable @{
    logname   = 'System'
    level     = 2, 3
    StartTime = $limitlogs
})
$hash | Add-Member NoteProperty Logs_LanPCS $(Get-WinEvent -FilterHashtable @{
    logname   = 'Lanpcs'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member NoteProperty Logs_AppLocker_EXE $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/EXE and DLL'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member NoteProperty Logs_AppLocker_MSI $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/MSI and Script'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member NoteProperty Logs_AppLocker_Deploy $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/Packaged app-Deployment'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member NoteProperty Logs_AppLocker_Execution $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/Packaged app-Execution'
    level     = 2, 3
    StartTime = $limitlogs
})

$hash | Add-Member noteproperty Scheduled_Tasks (Get-ScheduledTask)
$hash | Add-Member NoteProperty AppLocker (Get-AppLockerPolicy -Effective).rulecollections
$hash | Add-Member NoteProperty Bitlocker (Get-BitLockerVolume)

$hash | Add-Member NoteProperty UEFIxBIOS (if (Test-Path -Path $env:WINDIR\Panther\setupact.log) {
    (Select-String -Pattern 'Detected boot environment' -Path "$env:WINDIR\Panther\setupact.log"  -AllMatches).line -replace '.*:\s+'
  } else {
    if (Test-Path -Path HKLM:\System\CurrentControlSet\control\SecureBoot\State) 
    {
      'UEFI'
    }
    else 
    {
      'BIOS'
    }
})
$hash | Add-Member NoteProperty UEFI_partition (Get-WmiObject  -Query 'Select * from Win32_DiskPartition Where Type = "GPT: System"' | Select-Object -Property Name, Index, Bootable, BootPartition, PrimaryPartition, @{
    n = 'SizeInMB'
    e = {
      $_.Size/1MB
    }
})
$hash | Add-Member noteproperty SecureBoot (Confirm-SecureBootUEFI)
$hash | Add-Member noteproperty Hotfixes (Get-HotFix)
if ($System.Caption -like '*Server*') 
{
  $hash | Add-Member noteproperty Features (Get-Windowsfeature)
} else 
{
  $hash | Add-Member noteproperty Features (Get-WindowsOptionalFeature -Online)
}
$hash | Add-Member NoteProperty Services (Get-Service)

$hash | Add-Member NoteProperty UWP_Apps (Get-AppxPackage -AllUsers | Select-Object -Property Name, PackageFullName)
$hash | Add-Member NoteProperty Installed_Apps (Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)
$hash | Add-Member NoteProperty Processes (Get-Process)
$hash | Add-Member NoteProperty UWF ((Get-WmiObject -Namespace 'root\standardcimv2\embedded' -Class uwf_filter).CurrentEnabled)
#GP Prevent installation of devices not described by other policy settings
$hash | Add-Member Noteproperty Deny_UnspecifiedDevices (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions').DenyUnspecified
#GP Allow installation of device using drivers that match these device setup classes
$hash | Add-Member Noteproperty Allow_DeviceClasses (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\AllowDeviceClasses')
#GP Allow installation of device using drivers that match any of these device IDs
$hash | Add-Member Noteproperty Allow_DeviceIDs (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\AllowDeviceIDs')
#GP Prevent installation of device using drivers that match these device setup classes
$hash | Add-Member Noteproperty Deny_DeviceClasses (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses')
#GP Prevent installation of device using drivers that match any of these device IDs
$hash | Add-Member Noteproperty Deny_DeviceIDs (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceIDs')

$hash

$hash | ConvertTo-Json | Out-File "C:\avas\hash_luka.json"
$hash | Export-Clixml | Out-File "C:\avas\clixml.xml"


$hash
$luka
$mica
$app
$app2
$hash
$hash | Format-List
$hash | Format-Table
$hash


$app= Get-Content C:\SICZ\app_default.json | ConvertFrom-Json  
$app2 = Get-Content C:\SICZ\app.json | ConvertFrom-Json  
	

Compare-Object $app $app2 –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" 
Group-Object -Property DisplayName | % { New-Object psobject -Property @{        
    DisplayName=$_.DisplayName
    DisplayVersion=$_.group[0].DisplayVersion
   Publisher=$_.group[0].Publisher    
}} | Select DisplayName, DisplayVersion, Publisher


$Diff = ForEach ($line1 in $app)   
{
    ForEach ($line2 in $app2)   
        {
            IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
                {
                    IF ($line1.DisplayVersion -ne $line2.DisplayVersion)   # If jina verze
                        {        
                            New-Object -TypeName PSObject -Property @{
                                DisplayName = $line1.DisplayName   
                                DisplayVersion = $line1.DisplayVersion   
                                Publisher = $line1.Publisher
                                
                                }  
                        }
                }
        }                                                
}

$Diff | select DisplayName, DisplayVersion, Publisher 
$Diff
#$Diff | Format-List
#$Diff | Out-GridView


#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"


Write-Host -Object "$(Get-Date) - zjisteni zda je uzivatel admin"
#overeni ze je uzivatel administrator
Write-Verbose "Kontroluji admin prava"
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ujistete se ze spoustite AVAS jako administrator! Provedte spusteni jako administrator nebo nemusi vse funogvat korektne!!"
    #Start-Process -Verb "Runas" -File PowerShell.exe -Argument "-STA -noprofile -file $($myinvocation.mycommand.definition)"
    #Break
}

Write-Host -Object "$(Get-Date) - ukonceno zjistovani zda je uzivatel admin"


Write-Host -Object "$(Get-Date) - uzivatel je admin pokracuje dalsi spusteni skriptu"
Write-Host -Object "$(Get-Date) - Nacitam GUI"


#==============================================================================================
# GUI
#==============================================================================================
Write-Host -Object "$(Get-Date) Probiha nacitani GUI"
Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "AVAS"
$Form.TopMost = $true
$Form.Width = 1024
$Form.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice $json.ComputerName"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice $json.ComputerName"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$txtbox_jmenouzivatele.Text=$json.Last_User
$Form.controls.Add($txtbox_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.Text=($json.Locale)
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$json.Locale

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.Text=($json.Locale)
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$json.Locale

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)
$btn_scripty.Add_Click({
    
        $scripty.ShowDialog()
    })
    
    $scripty = New-Object system.Windows.Forms.Form
    $scripty.Text = "Scripty"
    $scripty.TopMost = $true
    $scripty.Width = 400
    $scripty.Height = 400
    $startupscriptvypis=$json.Script_StartUp
    $lbl_vypisscriptu = New-Object system.windows.Forms.Label
    $lbl_vypisscriptu.Text = $startupscriptvypis
    $lbl_vypisscriptu.AutoSize = $true
    $lbl_vypisscriptu.Width = 25
    $lbl_vypisscriptu.Height = 10
    $lbl_vypisscriptu.location = new-object system.drawing.point(100,200)
    $lbl_vypisscriptu.Font = "Microsoft Sans Serif,10"
    $scripty.controls.Add($lbl_vypisscriptu)
    
    $lbl_vypisscriptu = New-Object system.windows.Forms.Label
    $lbl_vypisscriptu.Text =$startupscriptvypis
    $lbl_vypisscriptu.AutoSize = $true
    $lbl_vypisscriptu.Width = 25
    $lbl_vypisscriptu.Height = 10
    $lbl_vypisscriptu.location = new-object system.drawing.point(100,200)
    $lbl_vypisscriptu.Font = "Microsoft Sans Serif,10"
    $scripty.controls.Add($lbl_vypisscriptu)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)
$btn_ntsyslog.Add_Click({
    
        $ntsyslog.ShowDialog()
    })
    
    
    $ntsyslog = New-Object system.Windows.Forms.Form
    $ntsyslog.Text = "NT syslog"
    $ntsyslog.TopMost = $true
    $ntsyslog.Width = 400
    $ntsyslog.Height = 400

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)

$btn_napoveda = New-Object system.windows.Forms.Button
$btn_napoveda.Text = "button"
$btn_napoveda.Width = 60
$btn_napoveda.Height = 30
$btn_napoveda.location = new-object system.drawing.point(600,314)
$btn_napoveda.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_napoveda)

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "AVAS"
$Form.TopMost = $true
$Form.Width = 1024
$Form.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = $json.ComputerName
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = $json.ComputerName
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)
$btn_scripty.Add_Click({
        $scripty.ShowDialog()
    })
    
    $scripty = New-Object system.Windows.Forms.Form
    $scripty.Text = "Script vypis"
    $scripty.TopMost = $true
    $scripty.Width = 400
    $scripty.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text =$json.OS
    $scripty.Controls.Add($Label)
    
$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)
$btn_ntsyslog.Add_Click({
        $syslog.ShowDialog()
    })
    
    $syslog = New-Object system.Windows.Forms.Form
    $syslog.Text = "NT syslog"
    $syslog.TopMost = $true
    $syslog.Width = 400
    $syslog.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text = "Syslog"
    $syslog.Controls.Add($Label)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)

$btn_napoveda = New-Object system.windows.Forms.Button
$btn_napoveda.Text = "Napoveda"
$btn_napoveda.Width = 80
$btn_napoveda.Height = 40
$btn_napoveda.location = new-object system.drawing.point(920,14)
$btn_napoveda.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_napoveda)
$btn_napoveda.Add_Click({
    
        $napoveda.ShowDialog()
    })
    
    $napoveda = New-Object system.Windows.Forms.Form
    $napoveda.Text = "Napoveda"
    $napoveda.TopMost = $true
    $napoveda.Width = 400
    $napoveda.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text = "Tady ma byt nejaka strasne chytra napoveda"
    $napoveda.Controls.Add($Label)
[void]$Form.ShowDialog()
$Form.Dispose()


Write-Host -Object "$(Get-Date) GUI bylo nacteno"

Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne nacteno"


Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne zavreno";


