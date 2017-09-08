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
#$Diff | Format-List
#$Diff | Out-GridView