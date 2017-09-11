 param (     [string] $log = "",
            [switch] $fullreport = $false)
  
 if (!$log){
      $date = get-date -uformat "%Y-%m-%d-%H-%M-%S"
      $log = "c:\temp\$scriptname-$date.log"
      write-host -foregroundcolor 'yellow' "No logfile is specified, $log will be used." 
 }     
 $logfile = New-Item -type file $log -force
  
 ##################################################### Functions ##################################################### 
 # ================== Logging and reporting functions ==================
 #### Function for creating log entries in a logfile and on standard output
 function writeLog ([int]$type, [string]$message, [string]$modifier) { #usage: writeLog 0 "info or error message"
      # $modifier: <nonew | extend>
      # Value nonew: writes the output the the console and the logfile without carriage return
      # Value extend: writes the message to the output without date and 
      # both values can be used e.g. for writting to the console and logfile and put a status message at the end of the line as a second step
  
      $date = get-date -uformat "%Y/%m/%d %H:%M:%S"
      if($modifier -eq "extend"){
           switch ($type) {
                "0"     {$color = "Green"}
                "1"     {$color = "Yellow"}
                "2"     {$color = "Red"}
           }
      }
      else{
           switch ($type) {
                "0"     {$message = $date + ", INF, " + $message; $color = "Green"}
                "1"     {$message = $date + ", WAR, " + $message; $color = "Yellow"}
                "2"     {$message = $date + ", ERR, " + $message; $color = "Red"}
           }
      }
      if($modifier -eq "nonew"){
           write-host $message -ForegroundColor $color -NoNewLine
           $bytes = [text.encoding]::ascii.GetBytes($message)
           $bytes | add-content $logfile -enc byte
      }
      else{
           write-host $message -ForegroundColor $color
           Add-Content $logfile $message
      }
 }
  
 #### Function for enumerating hotfixes
 function gethotfixes ([string]$fsrv){
      writelog 0 "$fsrv, reading hotfixes data from Win32_quickfixengineering......" "nonew"
      $hotfixes = gwmi -query "select HotFixID from Win32_quickfixengineering where hotfixid like 'KB%'" -computer $fsrv | select hotfixid
      $strHotfixes = $hotfixes | %{$_.hotfixid.tostring()}
      writelog 1 "[done]" "extend"
      return $strHotfixes
 }
  
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
  
##################################################### Body #####################################################
  
 writelog 0 "Syntax: $($MyInvocation.MyCommand.Path)$($myinvocation.line.substring(($myInvocation.InvocationName).length ))"
 writelog 0 "Invoked by: $([Security.Principal.WindowsIdentity]::GetCurrent().Name)"
  
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