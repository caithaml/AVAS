Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

$json=Get-Content hash_mica.json | ConvertFrom-Json

$aplikace=$json.Processes | select processname
#$aplikace | select processname

$defaultjson=Get-Content C:\SICZ\procesy_default.json | ConvertFrom-Json
$aplikacedefault=$defaultjson | select processname


 
	
Compare-Object $aplikace $aplikacedefault –property processname| Where $_.SideIndicator –eq "=>" | 
Group-Object -Property processname | % { New-Object psobject -Property @{        
    processname=$_.processname
       
}} | Select processname



$Diff = ForEach ($line1 in $aplikace)   
{
    ForEach ($line2 in $aplikacedefault)   
        {
            IF ($line1.processname -eq $line2.processname)   # If stejny nazev
                {
                    IF ($line1.processname -ne $line2.processname)   # If jina verze
                        {        
                            New-Object -Typeprocessname PSObject -Property @{
                                processname = $line1.processname   
                             
                                
                                }  
                        }
                }
        }                                                
}

$Diff | select processname
$Diff | Format-List
$Diff