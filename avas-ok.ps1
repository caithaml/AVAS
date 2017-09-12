Start-Transcript -Path "./transcript-avas-$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonceno nacitani json konfiguracniho souboru"

$json.Active_DC
$json.Allow_DeviceClasses
$json.Allow_DeviceIDs
$json.Application_Log_Length
$json.AppLocker
$json.BIOS
$json.BIOS_Date
$json.Bitlocker
$json.Computer_Root_Certificates
$json.ComputerName
$json.Country
$json.Date
$json.Default_Locale
$json.Deny_DeviceClasses
$json.Deny_DeviceIDs
$json.Deny_UnspecifiedDevices
$json.Domain
$json.Domain_DHCP
$json.Domain_TCP
$json.Dslog_Service
$json.Execution_Policy
$json.GemPlus_Reader
$json.Hotfixes
$json.Install_Date
$json.Installed_Apps
$json.LAPS
$json.Last_Boot_Time
$json.Last_User
$json.Local_Disks
$json.Local_Groups
$json.Local_Users
$json.Locale
$json.Logs_Application
$json.Logs_AppLocker_Deploy
$json.Logs_AppLocker_EXE
$json.Logs_AppLocker_Execution
$json.Logs_AppLocker_MSI
$json.Logs_LanPCS
$json.Logs_System
$json.NetIPConfiguration
$json.OS
$json.OS_Build
$json.PCinfo
$json.Processes
$json.Setupapi_Length
$json.Scheduled_Tasks
$json.Site_Name
$json.SP
$json.Protect_Ini
$json.SYS_Dir
$json.System_Locale
$json.System_Log_Length
$json.TEMP_Dir
$json.TEMP_Encrypted
$json.UEFI_partition
$json.User
$json.UWF
$json.UWP_Apps
$json.Virtual_Free
$json.Virtual_Total
$json.WIN_Dir
$json.RAM_Free
$json.RAM_Total

