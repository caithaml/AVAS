#Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
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