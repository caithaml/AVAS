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
$hash | Add-Member NoteProperty AppLocker 

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

$hash | ConvertTo-Json | Out-File "hash_sablona.json"
$hash | ConvertTo-Json | Out-File "hash_sablona$(get-date -f yyyy-MM-dd-hh-mm-ss).json"
#$hash | Export-Clixml | Out-File "clixml.xml"
$hash | Out-File -Path "./hash$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"