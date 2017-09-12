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


#### Function for comparing hotfixes between 2 hosts
function compareHotfixes ($fobjColl, $fullreport){
     writelog 0 "Comparing hotfixes between the 2 hosts......" "nonew"
     # compare the list of hotfixes from the 2 hosts
     if($fullreport)     {$comparedHotfixes = compare-object $fobjColl[0].hotfixes $fobjColl[1].hotfixes -SyncWindow 500 -IncludeEqual} #we need the equals for the host details output
     else               {$comparedHotfixes = compare-object $fobjColl[0].hotfixes $fobjColl[1].hotfixes -SyncWindow 500}
 
     # going through the output of compare-object's output and feed the data into an object collection
     foreach ($c in $comparedHotfixes) { 
          $fsObj = new-Object -typename System.Object
          $hotfixId = $c.InputObject

          switch ($c.SideIndicator) 
          {
               "=>" {
                    $fsObj | add-Member -memberType noteProperty -name "Item" -Value $hotfixId
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[0].ComputerName) -Value "Missing"
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[1].ComputerName) -Value "OK"
               }

               "<=" {
                    $fsObj | add-Member -memberType noteProperty -name "Item" -Value $hotfixId
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[0].ComputerName) -Value "OK"
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[1].ComputerName) -Value "Missing"
               } 

               "==" {
                    $fsObj | add-Member -memberType noteProperty -name "Item" -Value $hotfixId
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[0].ComputerName) -Value "OK"
                    $fsObj | add-Member -memberType noteProperty -name $($fobjColl[1].ComputerName) -Value "OK"
               } 
          }

          if($fsObj.item){
               $script:ReturnObjColl += $fsObj
          }
     } 
     writelog 1 "[done]" "extend"
}
 
##################################################### porovnani #####################################################
 

$hostlist = @($Input)
$objColl = $script:ReturnObjColl = @()
$hostlistlength = $hostlist.length
 
if($hostlistlength -eq 2){
     foreach ($srv in $hostlist) {
          $sObjHotfixes = new-Object -typename System.Object
          $sObjHotfixes | add-Member -memberType noteProperty -name ComputerName -Value $srv
          $sObjHotfixes | add-Member -memberType noteProperty -name hotfixes -Value ""
          $sObjHotfixes.hotfixes = gethotfixes $srv
          $objColl += $sObjHotfixes
     }
}
 
compareHotfixes $objColl $fullreport
$script:ReturnObjColl


$app= Get-Content C:\SICZ\app_default.json | ConvertFrom-Json  
$app2 = Get-Content C:\SICZ\app.json | ConvertFrom-Json  
	

Compare-Object $app $app2 –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" | 
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
$Diff | Format-List
#$Diff | Out-GridView