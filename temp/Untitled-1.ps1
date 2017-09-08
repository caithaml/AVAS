$json=Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json

$a=$json.Services | select ProcessName
$a

$defaultjson=Get-Content C:\SICZ\procesy_default.json | ConvertFrom-Json
$b=$defaultjson | select ProcessName
Compare-Object -ReferenceObject $a -DifferenceObject $b -Property ProcessName


$Diff = ForEach ($line1 in $a)   
{
    ForEach ($line2 in $b)   
        {
            IF ($line1.ProcessName -eq $line2.ProcessName)   # If stejny nazev
                {
                    IF ($line1.ProcessName -ne $line2.ProcessName)   # If jina verze
                        {        
                            New-Object -TypeName PSObject -Property @{
                                DisplayName = $line1.ProcessName  
                                #DisplayVersion = $line1.DisplayVersion   
                                #Publisher = $line1.Publisher
                                
                                }  
                        }
                }
        }                                                
}

$Diff | select ProcessName 
$Diff | Format-List
$Diff