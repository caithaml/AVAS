Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"


Write-Host -Object "$(Get-Date) - zjisteni zda je uzivatel admin"
#overeni ze je uzivatel administrator
Write-Verbose "Kontroluji admin prava"
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ujistete se ze spoustite AVAS jako administrator! Provedte spusteni jako administrator nebo nemusi vse funogvat korektne!!"
    #Start-Process -Verb "Runas" -File PowerShell.exe -Argument "-STA -noprofile -file $($myinvocation.mycommand.definition)"
    #Break
}

Write-Host -Object "$(Get-Date) - ukonceno zjistovani zda je uzivatel admin"


Write-Host -Object "$(Get-Date) - uzivatel je admin pokracuje dalsi spusteni skriptu"
Write-Host -Object "$(Get-Date) - Nacitam GUI"


#==============================================================================================
# GUI
#==============================================================================================
$aplikace=$json.installed_apps | select DisplayName, Version, Publisher
$aplikace

$defaultjson=Get-Content C:\SICZ\app_default.json | ConvertFrom-Json
$aplikacedefault=$defaultjson | select DisplayName, Version, Publisher


 
	
Compare-Object $aplikace $aplikacedefault –property DisplayName, DisplayVersion, Publisher | Where $_.SideIndicator –eq "=>" | 
Group-Object -Property DisplayName | % { New-Object psobject -Property @{        
    DisplayName=$_.DisplayName
    DisplayVersion=$_.group[0].DisplayVersion
   Publisher=$_.group[0].Publisher    
}} | Select DisplayName, DisplayVersion, Publisher



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
Write-Host -Object "$(Get-Date) Probiha nacitani GUI"
Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "AVAS-applikace"
$Form.TopMost = $true
$Form.Width = 1024
$Form.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Rozdilne app"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Rozdilne app"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice2 = New-Object system.windows.Forms.Label
$lbl_nazevstanice2.Text = $Diff
$lbl_nazevstanice2.AutoSize = $true
$lbl_nazevstanice2.Width = 25
$lbl_nazevstanice2.Height = 10
$lbl_nazevstanice2.location = new-object system.drawing.point(170,18)
$lbl_nazevstanice2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice2)

$lbl_nazevstanice2 = New-Object system.windows.Forms.Label
$lbl_nazevstanice2.Text = $Diff
$lbl_nazevstanice2.AutoSize = $true
$lbl_nazevstanice2.Width = 25
$lbl_nazevstanice2.Height = 10
$lbl_nazevstanice2.location = new-object system.drawing.point(170,18)
$lbl_nazevstanice2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice2)

[void]$Form.ShowDialog()
$Form.Dispose()


Write-Host -Object "$(Get-Date) GUI bylo nacteno"

Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne nacteno"


Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne zavreno";