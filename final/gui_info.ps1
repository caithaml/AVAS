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
Write-Host -Object "$(Get-Date) Probiha nacitani GUI"
Add-Type -AssemblyName System.Windows.Forms

$avasokno = New-Object system.Windows.Forms.Form
$avasokno.Text = "Avas"
$avasokno.TopMost = $true
$avasokno.Width = 1024
$avasokno.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_nazevstanice)

$nazevstanice = New-Object system.windows.Forms.Label
$nazevstanice.Text = $json.ComputerName
$nazevstanice.AutoSize = $true
$nazevstanice.Width = 25
$nazevstanice.Height = 10
$nazevstanice.location = new-object system.drawing.point(109,19)
$nazevstanice.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($nazevstanice)

$nazevstanice = New-Object system.windows.Forms.Label
$nazevstanice.Text = $json.ComputerName
$nazevstanice.AutoSize = $true
$nazevstanice.Width = 25
$nazevstanice.Height = 10
$nazevstanice.location = new-object system.drawing.point(109,19)
$nazevstanice.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($nazevstanice)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(10,45)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(10,45)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_nazevsite)

$nazevsite = New-Object system.windows.Forms.Label
$nazevsite.Text = $json.Domain
$nazevsite.AutoSize = $true
$nazevsite.Width = 25
$nazevsite.Height = 10
$nazevsite.location = new-object system.drawing.point(110,50)
$nazevsite.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($nazevsite)

$nazevsite = New-Object system.windows.Forms.Label
$nazevsite.Text = $json.Domain
$nazevsite.AutoSize = $true
$nazevsite.Width = 25
$nazevsite.Height = 10
$nazevsite.location = new-object system.drawing.point(110,50)
$nazevsite.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($nazevsite)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(12,83)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(12,83)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_jmenouzivatele)

$jmenouzivatele = New-Object system.windows.Forms.Label
$jmenouzivatele.Text = $json.User
$jmenouzivatele.AutoSize = $true
$jmenouzivatele.Width = 25
$jmenouzivatele.Height = 10
$jmenouzivatele.location = new-object system.drawing.point(127,83)
$jmenouzivatele.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($jmenouzivatele)

$jmenouzivatele = New-Object system.windows.Forms.Label
$jmenouzivatele.Text = $json.User
$jmenouzivatele.AutoSize = $true
$jmenouzivatele.Width = 25
$jmenouzivatele.Height = 10
$jmenouzivatele.location = new-object system.drawing.point(127,83)
$jmenouzivatele.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($jmenouzivatele)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(12,117)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(12,117)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_stavantiviru)

$stavantiviru = New-Object system.windows.Forms.Label
$stavantiviru.Text = $json.SEP_ClientType
$stavantiviru.AutoSize = $true
$stavantiviru.Width = 25
$stavantiviru.Height = 10
$stavantiviru.location = new-object system.drawing.point(115,117)
$stavantiviru.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($stavantiviru)

$stavantiviru = New-Object system.windows.Forms.Label
$stavantiviru.Text = $json.SEP_ClientType
$stavantiviru.AutoSize = $true
$stavantiviru.Width = 25
$stavantiviru.Height = 10
$stavantiviru.location = new-object system.drawing.point(115,117)
$stavantiviru.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($stavantiviru)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,149)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_scripty)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,149)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($lbl_scripty)

$label20 = New-Object system.windows.Forms.Label
$label20.Text = "label"
$label20.AutoSize = $true
$label20.Width = 25
$label20.Height = 10
$label20.location = new-object system.drawing.point(10,20)
$label20.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($label20)

$label20 = New-Object system.windows.Forms.Label
$label20.Text = "label"
$label20.AutoSize = $true
$label20.Width = 25
$label20.Height = 10
$label20.location = new-object system.drawing.point(10,20)
$label20.Font = "Microsoft Sans Serif,10"
$avasokno.controls.Add($label20)

[void]$avasokno.ShowDialog()
$avasokno.Dispose()