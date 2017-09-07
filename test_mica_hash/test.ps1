Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

$json=Get-Content hash_mica.json | ConvertFrom-Json

$aplikace=$json.installed_apps | select DisplayName, Version, Publisher
$aplikace

$defaultjson=Get-Content C:\SICZ\app_default.json | ConvertFrom-Json
$aplikacedefault=$defaultjson | select DisplayName, Version, Publisher


 



$Diff = ForEach ($line1 in $aplikace)   
{
    ForEach ($line2 in $aplikacedefault)   
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
$Diff | Format-List
$Diff