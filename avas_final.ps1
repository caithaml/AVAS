Start-Transcript -Path "./transcript-avas-$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"



Write-Host -Object "$(Get-Date) - uzivatel je admin pokracuje dalsi spusteni skriptu"
Write-Host -Object "$(Get-Date) - Nacitam GUI"


#==============================================================================================
# GUI
#==============================================================================================

function appdiff  {
    $app= Get-Content C:\SICZ\app_default.json | ConvertFrom-Json  
    $app2 = Get-Content C:\SICZ\app.json | ConvertFrom-Json  
        
    
    Compare-Object $app $app2 –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" 
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
}

appdiff

function servicesdiff  {
    $def= Get-Content C:\SICZ\hash_mica.json | ConvertFrom-Json
    $default=$def.Services
    $inst=Get-Content C:\SICZ\hash_luka.json | ConvertFrom-Json
    $installed=$inst.Services
    Compare-Object -ReferenceObject $default -DifferenceObject $installed  -Property DisplayName #| where $_.SideIndicator -EQ "=>"
    $vysledek=Compare-Object -ReferenceObject $default -DifferenceObject $installed  -Property DisplayName | where $_.SideIndicator -EQ "=>"
    #$vysledek
    $vysledek | Out-File C:\avas\sluzby$(get-date -f yyyy-MM-dd-hh-mm-ss).txt
    $vysledek | Export-Csv C:\avas\sluzby$(get-date -f yyyy-MM-dd-hh-mm-ss).csv
    $vysledek
}

servicesdiff

$testapp=appdiff
$testapp
$testserv=servicesdiff
$testserv
