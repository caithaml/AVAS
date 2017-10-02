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
$limitlogs             = (Get-Date).AddDays(-35)  
$System                = Get-WmiObject -Class win32_OperatingSystem
$win32_bios            = Get-WmiObject -Class win32_bios

$hash                  = New-Object -TypeName PSObject 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue ComputerName -InputObject $env:COMPUTERNAME
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Date -InputObject $(Get-Date)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue User -InputObject $env:USERNAME
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Last_User -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon').DefaultUserName
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Domain -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon').DefaultDomainName
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Domain_TCP -InputObject (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters').Domain
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Domain_DHCP -InputObject (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters').DHCPDomain
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Site_Name -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine').'Site-Name'
#$hash | Add-Member NoteProperty GroupPolicy_settings (Get-GPResultantSetofPolicy)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Active_DC -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\History').DCName
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Script_StartUp -InputObject (Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Startup\' | ForEach-Object -Process {
    if ((Get-ItemProperty -Path $_.PSPath).'GPO-ID' -ne 'LocalGPO') 
    {
      (Get-ItemProperty -Path $_.PSPath).FileSysPath
    }
})
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Script_ShutDown -InputObject (Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown\' | ForEach-Object -Process {
    if ((Get-ItemProperty -Path $_.PSPath).'GPO-ID' -ne 'LocalGPO') 
    {
      (Get-ItemProperty -Path $_.PSPath).FileSysPath
    }
})

$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue OS -InputObject ($System).Caption 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue OS_Build -InputObject ($System).Version
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue SP -InputObject ($System).ServicePackMajorVersion
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Install_Date -InputObject ($System).ConvertToDateTime(($System).InstallDate) 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Last_Boot_Time -InputObject (Get-CimInstance -ClassName win32_operatingsystem).lastbootuptime
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue RAM_Total -InputObject $([Math]::round($((Get-WmiObject -Class win32_ComputerSystem).TotalPhysicalMemory /1MB)))
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue RAM_Free -InputObject $([Math]::round(($System).FreePhysicalMemory /1MB))
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Virtual_Total -InputObject $([Math]::round(($System).TotalVirtualMemorySize /1MB))
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Virtual_Free -InputObject $([Math]::round(($System).FreeVirtualMemory /1MB))
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue WIN_Dir -InputObject ($System).WindowsDirectory
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue SYS_Dir -InputObject ($System).SystemDirectory 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue TEMP_Dir -InputObject $($env:WINDIR + '\TEMP')
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Execution_Policy -InputObject (Get-ExecutionPolicy -List)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue TEMP_Encrypted -InputObject $(if (Test-Path -Path D:\@TEMP\) 
  {
    Write-Output -InputObject Y
  }
  else 
  {
    Write-Output -InputObject N
  }
)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Protect_Ini -InputObject $(
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
    if((Get-ChildItem -Path $file -Force).Attributes -band $val -eq $val)
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
              Format-HumanReadable -size $_.Size
            }
          }, 
          @{
            n = 'Used'
            e = {
              Format-HumanReadable `
              -size (($_.Size)-($_.FreeSpace))
            }
          }, 
          @{
            n = 'Avail'
            e = {
              Format-HumanReadable -size $_.FreeSpace
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
            $diskobj   = New-Object -TypeName PSObject `
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
        Write-Warning -Message "$computer - $err"
      } 
    }
  }
    
  END {}
}


$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Local_Disks -InputObject (Get-DiskFree)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue BIOS -InputObject $(($win32_bios).Version + ' | ' + ($win32_bios).Name)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue BIOS_Date -InputObject ($win32_bios).ConvertToDateTime(($win32_bios).ReleaseDate)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue System_Locale -InputObject (Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Nls\Locale').'(Default)'
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Default_Locale -InputObject (Get-ItemProperty -Path 'Microsoft.Powershell.Core\Registry::HKEY_USERS\.Default\Control Panel\International').'Locale'
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Country -InputObject (Get-ItemProperty -Path 'HKCU:\Control Panel\International').'iCountry'
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Locale -InputObject (Get-ItemProperty -Path 'HKCU:\Control Panel\International').'Locale'
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue GemPlus_Reader -InputObject $(if (Test-Path -Path $env:windir\system32\drivers\gemser.sys) 
  {
    Write-Output -InputObject 'Installed'
  }
  else 
  {
    Write-Output -InputObject 'Not Installed'
  }
)

$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Dslog_Service -InputObject $(if (Get-Service -Name Dslog -ErrorAction SilentlyContinue) 
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
if($System.ProductType -eq 3) 
{
  $AV_Products = Get-WmiObject -Namespace root\cimv2 -Class Win32_Product -Filter "Name like '%Symantec%' or Name like '%ESET%'"
}
# OS Windows client
else 
{
  $AV_Products = (Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct).displayName
}

foreach($tmp in $AV_Products) 
{
  # ESET
  if($tmp -match 'ESET') 
  {
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_Product -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ProductName
    if((Get-Service -Name ekrn).Status -eq 'running') 
    {
      $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_ResidentOn -InputObject $true
    }
    else 
    {
      $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_ResidentOn -InputObject $false
    }
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_Version -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ProductVersion
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_Scanner_Build -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ScannerBuild
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_ESET_Scanner_Version -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\ESET\ESET Security\CurrentVersion\Info').ScannerVersion
  }

  # Symantec
  if($tmp -match 'Symantec') 
  {
    #ver 12
    #?cteni z registru preklada HEX -> DEC, format - ('{0:x}' -f Get-Item...)
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_Product -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion').ProductName
    if((Get-Service -Name SepMasterService).Status -eq 'running') 
    {
      $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_ResidentOn -InputObject $true
    }
    else 
    {
      $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_ResidentOn -InputObject $false
    }
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_Version -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion').ProductVersion
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_Scanner_Build -InputObject (Get-Item -Path "$((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').'Home Directory')$((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').VirusEngine)" | Select-Object -ExpandProperty VersionInfo).ProductVersion
    $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_SEP_Scanner_Version -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Symantec\Symantec Endpoint Protection\AV').ScanEngineVersion
  }
}

# Windows Defender
#$hash | Add-Member NoteProperty AV_MS Get-MpComputerStatus

$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_Product -InputObject 'Windows Defender'
if((Get-Service -Name WinDefend).Status -ne 'running' -or (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Defender').DisableAntiSpyware -eq 1 -or (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Defender').DisableAntiVirus -eq 1) 
{
  $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_ResidentOn -InputObject $false
}
else 
{
  $hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_ResidentOn -InputObject $true
}
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_Version -InputObject (Get-Item -Path "$env:ProgramFiles\Windows Defender\MSASCui.exe" | Select-Object -ExpandProperty VersionInfo).ProductVersion
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_Scanner_Build -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates').EngineVersion
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue AV_MS_Scanner_Version -InputObject (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Signature Updates').AVSignatureVersion

### LOGS
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue System_Log_Length -InputObject $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path $env:windir\system32\config\SySEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\System.Evtx).Length
  }
) 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Secrutiy_Log_Length -InputObject $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path $env:windir\system32\config\SecEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\Security.Evtx).Length
  }
) 
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Application_Log_Length -InputObject $(if ([IntPtr]::Size -eq 4) 
  {
    (Get-ChildItem -Path $env:windir\system32\config\AppEvent.Evt ).Length
  }
  else 
  {
    (Get-ChildItem -Path $env:SystemRoot\System32\Winevt\Logs\Application.evtx).Length
  }
)
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Setupapi_Length -InputObject (Get-ChildItem -Path $env:windir\setupapi.log).Length
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue NetIPConfiguration -InputObject (Get-NetIPConfiguration)

if (Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{937A3762-F1D545F3-AA20-F7C5CBA7FBAC')
{
  $result = 'Installed'
}
else 
{
  $result = 'Not Installed'
}
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue LAPS -InputObject $result 
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Computer_Root_Certificates -InputObject (Get-ChildItem -Path Cert:\LocalMachine\Root | Format-List)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Local_Users -InputObject (Get-LocalUser)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Local_Groups -InputObject (Get-LocalGroup)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue PCinfo -InputObject (Get-ComputerInfo)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_Application -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Application'
    level     = 2, 3
    StartTime = $limitlogs
})
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_System -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'System'
    level     = 2, 3
    StartTime = $limitlogs
})
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_LanPCS -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Lanpcs'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_AppLocker_EXE -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/EXE and DLL'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_AppLocker_MSI -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/MSI and Script'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_AppLocker_Deploy -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/Packaged app-Deployment'
    level     = 2, 3
    StartTime = $limitlogs
})
  
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Logs_AppLocker_Execution -InputObject $(Get-WinEvent -FilterHashtable @{
    logname   = 'Microsoft-Windows-AppLocker/Packaged app-Execution'
    level     = 2, 3
    StartTime = $limitlogs
})

$hash | Add-Member -NotePropertyName noteproperty -NotePropertyValue Scheduled_Tasks -InputObject (Get-ScheduledTask)


$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Bitlocker -InputObject (Get-BitLockerVolume)

$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue UEFIxBIOS -InputObject (if (Test-Path -Path $env:WINDIR\Panther\setupact.log) {
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
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue UEFI_partition -InputObject (Get-WmiObject  -Query 'Select * from Win32_DiskPartition Where Type = "GPT: System"' | Select-Object -Property Name, Index, Bootable, BootPartition, PrimaryPartition, @{
    n = 'SizeInMB'
    e = {
      $_.Size/1MB
    }
})
$hash | Add-Member -NotePropertyName noteproperty -NotePropertyValue SecureBoot -InputObject (Confirm-SecureBootUEFI)
$hash | Add-Member -NotePropertyName noteproperty -NotePropertyValue Hotfixes -InputObject (Get-HotFix)
if ($System.Caption -like '*Server*') 
{
  $hash | Add-Member -NotePropertyName noteproperty -NotePropertyValue Features -InputObject (Get-Windowsfeature)
}
else 
{
  $hash | Add-Member -NotePropertyName noteproperty -NotePropertyValue Features -InputObject (Get-WindowsOptionalFeature -Online)
}
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Services -InputObject (Get-Service)

$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue UWP_Apps -InputObject (Get-AppxPackage -AllUsers | Select-Object -Property Name, PackageFullName)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Installed_Apps -InputObject (Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue Processes -InputObject (Get-Process)
$hash | Add-Member -NotePropertyName NoteProperty -NotePropertyValue UWF -InputObject ((Get-WmiObject -Namespace 'root\standardcimv2\embedded' -Class uwf_filter).CurrentEnabled)
#GP Prevent installation of devices not described by other policy settings
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Deny_UnspecifiedDevices -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions').DenyUnspecified
#GP Allow installation of device using drivers that match these device setup classes
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Allow_DeviceClasses -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\AllowDeviceClasses')
#GP Allow installation of device using drivers that match any of these device IDs
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Allow_DeviceIDs -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\AllowDeviceIDs')
#GP Prevent installation of device using drivers that match these device setup classes
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Deny_DeviceClasses -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceClasses')
#GP Prevent installation of device using drivers that match any of these device IDs
$hash | Add-Member -NotePropertyName Noteproperty -NotePropertyValue Deny_DeviceIDs -InputObject (Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceIDs')

$hash

$hash |
ConvertTo-Json |
Out-File -FilePath 'hash_sablona.json'
$hash |
ConvertTo-Json |
Out-File -FilePath "hash_sablona$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).json"
#$hash | Export-Clixml | Out-File "clixml.xml"
$hash | Out-File -Path "./hash$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).txt"
$hash | Out-File -Path "./templatehash$(env:COMPUTERNAME)-$(Get-Date -Format yyy-MM-dd-hh-mm-ss).json"
Read-Host -Prompt 'Press any key to exit...'
exit
# SIG # Begin signature block
# MIID7QYJKoZIhvcNAQcCoIID3jCCA9oCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU46Y8WUgNOWcvcQHG9HbLb+8Q
# dx2gggIHMIICAzCCAWygAwIBAgIQZDdTxzu4+YFMYeyTtmLtgDANBgkqhkiG9w0B
# AQUFADAcMRowGAYDVQQDDBFMdUthcyBLYXJhYmVjIElDWjAeFw0xNzEwMDIwNzMw
# MzRaFw0yMTEwMDIwMDAwMDBaMBwxGjAYBgNVBAMMEUx1S2FzIEthcmFiZWMgSUNa
# MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCapIWqwo94eQlMVMdxEPR947uo
# w2XCvRla7bI5idyFp4/4voJ15FsYZqldLYIh2O78M+fmH1mb+Rh61E+Bn/NlV88T
# H/H4fygqjDC6YjuTJRVsFp/uosTkDWKkKyp596dtNFoc86ZJ4aRD9pasJ14zXMW0
# UhCNAhR9gaRDT/3UZQIDAQABo0YwRDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNV
# HQ4EFgQUtEk3bGdVsA6tSNyvrPu3dejsd7UwDgYDVR0PAQH/BAQDAgeAMA0GCSqG
# SIb3DQEBBQUAA4GBAFs5K1cObLWgA37VO5OWsF4mCUasA9lOLlxeKIXI1flYjJAr
# Fn9xrSc9jF5u0MmivVzo3W3gWJVMCGmmuvN2X/NVh19XwpNdFrzuFx1MkLEELL6h
# DHeAofdRyRo3ZNer43N0DPKwnhazoL5LrEgOL+SaZAD3pMpRCRBp6Il8uMwkMYIB
# UDCCAUwCAQEwMDAcMRowGAYDVQQDDBFMdUthcyBLYXJhYmVjIElDWgIQZDdTxzu4
# +YFMYeyTtmLtgDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKA
# ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUqbpOBjT8X3y/G5XW3LlJlRm0Qb4w
# DQYJKoZIhvcNAQEBBQAEgYBbIH96j+5OW8nwfpNrM4jwkxGLUBdwdT3JtLZiWAAj
# 8V0mPv/u+3ldttZxuyKuvFoWrkCVb5QPmYCrsJx8imjkn1LcGchtJMQmz1vwbo5b
# hFA/wxQWZv6/dPZv1+0Xj8opahZKeRKAzuRs7vPyAIg1sdcHs2GEW47oXVijcJ4B
# WQ==
# SIG # End signature block
