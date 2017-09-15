#$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
function appdiff$ {
    $app= Get-Content D:\SICZ\app_default.json | ConvertFrom-Json  
    $app2 = Get-Content D:\SICZ\app.json | ConvertFrom-Json  

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
}
appdiff

$line2




Read-Host "Press any key to exit..."
exit