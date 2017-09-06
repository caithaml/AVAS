Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash.json | ConvertFrom-Json

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

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "AVAS"
$Form.TopMost = $true
$Form.Width = 1024
$Form.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.Text=($json.Locale)
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$json.Locale

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.Text=($json.Locale)
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$json.Locale

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)
$btn_scripty.Add_Click({
    
        $scripty.ShowDialog()
    })
    
    $scripty = New-Object system.Windows.Forms.Form
    $scripty.Text = "Scripty"
    $scripty.TopMost = $true
    $scripty.Width = 400
    $scripty.Height = 400
    $startupscriptvypis=$json.Script_StartUp
    $lbl_vypisscriptu = New-Object system.windows.Forms.Label
    $lbl_vypisscriptu.Text = $startupscriptvypis
    $lbl_vypisscriptu.AutoSize = $true
    $lbl_vypisscriptu.Width = 25
    $lbl_vypisscriptu.Height = 10
    $lbl_vypisscriptu.location = new-object system.drawing.point(100,200)
    $lbl_vypisscriptu.Font = "Microsoft Sans Serif,10"
    $scripty.controls.Add($lbl_vypisscriptu)
    
    $lbl_vypisscriptu = New-Object system.windows.Forms.Label
    $lbl_vypisscriptu.Text =$startupscriptvypis
    $lbl_vypisscriptu.AutoSize = $true
    $lbl_vypisscriptu.Width = 25
    $lbl_vypisscriptu.Height = 10
    $lbl_vypisscriptu.location = new-object system.drawing.point(100,200)
    $lbl_vypisscriptu.Font = "Microsoft Sans Serif,10"
    $scripty.controls.Add($lbl_vypisscriptu)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)
$btn_ntsyslog.Add_Click({
    
        $ntsyslog.ShowDialog()
    })
    
    
    $ntsyslog = New-Object system.Windows.Forms.Form
    $ntsyslog.Text = "NT syslog"
    $ntsyslog.TopMost = $true
    $ntsyslog.Width = 400
    $ntsyslog.Height = 400

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)

$btn_napoveda = New-Object system.windows.Forms.Button
$btn_napoveda.Text = "button"
$btn_napoveda.Width = 60
$btn_napoveda.Height = 30
$btn_napoveda.location = new-object system.drawing.point(600,314)
$btn_napoveda.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_napoveda)

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "AVAS"
$Form.TopMost = $true
$Form.Width = 1024
$Form.Height = 800

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Nazev stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 150
$txtbox_nazevstanice.Height = 40
$txtbox_nazevstanice.location = new-object system.drawing.point(170,18)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$lbl_aktivaceprovedenadne = New-Object system.windows.Forms.Label
$lbl_aktivaceprovedenadne.Text = "Aktivace provedena dne"
$lbl_aktivaceprovedenadne.AutoSize = $true
$lbl_aktivaceprovedenadne.Width = 25
$lbl_aktivaceprovedenadne.Height = 10
$lbl_aktivaceprovedenadne.location = new-object system.drawing.point(9,57)
$lbl_aktivaceprovedenadne.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivaceprovedenadne)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$textBox11 = New-Object system.windows.Forms.TextBox
$textBox11.Width = 150
$textBox11.Height = 40
$textBox11.location = new-object system.drawing.point(172,60)
$textBox11.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox11)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(8,90)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$textBox15 = New-Object system.windows.Forms.TextBox
$textBox15.Width = 150
$textBox15.Height = 40
$textBox15.location = new-object system.drawing.point(172,90)
$textBox15.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox15)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Nazev site"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(8,121)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$textBox19 = New-Object system.windows.Forms.TextBox
$textBox19.Width = 150
$textBox19.Height = 40
$textBox19.location = new-object system.drawing.point(173,120)
$textBox19.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox19)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jmeno uzivatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(413,21)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 150
$txtbox_jmenouzivatele.Height = 40
$txtbox_jmenouzivatele.location = new-object system.drawing.point(534,22)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelar"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(413,58)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$textBox27 = New-Object system.windows.Forms.TextBox
$textBox27.Width = 150
$textBox27.Height = 40
$textBox27.location = new-object system.drawing.point(534,56)
$textBox27.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox27)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Cislo zasuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(413,89)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 150
$txtbox_cislozasuvky.Height = 40
$txtbox_cislozasuvky.location = new-object system.drawing.point(533,88)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Seriove cislo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(413,120)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 150
$txtbox_seriovecislo.Height = 40
$txtbox_seriovecislo.location = new-object system.drawing.point(532,122)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$lbl_intdatsoub = New-Object system.windows.Forms.Label
$lbl_intdatsoub.Text = "Integrita datoveho soubory"
$lbl_intdatsoub.AutoSize = $true
$lbl_intdatsoub.Width = 25
$lbl_intdatsoub.Height = 10
$lbl_intdatsoub.location = new-object system.drawing.point(9,169)
$lbl_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$txtbox_intdatsoub = New-Object system.windows.Forms.TextBox
$txtbox_intdatsoub.Width = 150
$txtbox_intdatsoub.Height = 40
$txtbox_intdatsoub.location = new-object system.drawing.point(174,170)
$txtbox_intdatsoub.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsoub)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostredi"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(9,206)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 150
$txtbox_prostredi.Height = 40
$txtbox_prostredi.location = new-object system.drawing.point(174,205)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(11,246)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$txtbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txtbox_stavantiviru.Width = 150
$txtbox_stavantiviru.Height = 40
$txtbox_stavantiviru.location = new-object system.drawing.point(173,247)
$txtbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_stavantiviru)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$lbl_scripty = New-Object system.windows.Forms.Label
$lbl_scripty.Text = "Scripty"
$lbl_scripty.AutoSize = $true
$lbl_scripty.Width = 25
$lbl_scripty.Height = 10
$lbl_scripty.location = new-object system.drawing.point(12,283)
$lbl_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$txtbox_scripty = New-Object system.windows.Forms.TextBox
$txtbox_scripty.Multiline = $true
$txtbox_scripty.Width = 150
$txtbox_scripty.Height = 40
$txtbox_scripty.location = new-object system.drawing.point(173,282)
$txtbox_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_scripty)

$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)
$btn_scripty.Add_Click({
        $scripty.ShowDialog()
    })
    
    $scripty = New-Object system.Windows.Forms.Form
    $scripty.Text = "Script vypis"
    $scripty.TopMost = $true
    $scripty.Width = 400
    $scripty.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text =$json.OS
    $scripty.Controls.Add($Label)
    
$btn_scripty = New-Object system.windows.Forms.Button
$btn_scripty.Text = "Podrobnosti"
$btn_scripty.Width = 90
$btn_scripty.Height = 40
$btn_scripty.location = new-object system.drawing.point(355,288)
$btn_scripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_scripty)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$lbl_ntsyslog = New-Object system.windows.Forms.Label
$lbl_ntsyslog.Text = "NT syslog"
$lbl_ntsyslog.AutoSize = $true
$lbl_ntsyslog.Width = 25
$lbl_ntsyslog.Height = 10
$lbl_ntsyslog.location = new-object system.drawing.point(9,347)
$lbl_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$txtbox_ntsyslog = New-Object system.windows.Forms.TextBox
$txtbox_ntsyslog.Multiline = $true
$txtbox_ntsyslog.Width = 150
$txtbox_ntsyslog.Height = 40
$txtbox_ntsyslog.location = new-object system.drawing.point(175,346)
$txtbox_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_ntsyslog)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)
$btn_ntsyslog.Add_Click({
        $syslog.ShowDialog()
    })
    
    $syslog = New-Object system.Windows.Forms.Form
    $syslog.Text = "NT syslog"
    $syslog.TopMost = $true
    $syslog.Width = 400
    $syslog.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text = "Syslog"
    $syslog.Controls.Add($Label)

$btn_ntsyslog = New-Object system.windows.Forms.Button
$btn_ntsyslog.Text = "Podrobnosti"
$btn_ntsyslog.Width = 90
$btn_ntsyslog.Height = 40
$btn_ntsyslog.location = new-object system.drawing.point(356,347)
$btn_ntsyslog.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_ntsyslog)

$btn_napoveda = New-Object system.windows.Forms.Button
$btn_napoveda.Text = "Napoveda"
$btn_napoveda.Width = 80
$btn_napoveda.Height = 40
$btn_napoveda.location = new-object system.drawing.point(920,14)
$btn_napoveda.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_napoveda)
$btn_napoveda.Add_Click({
    
        $napoveda.ShowDialog()
    })
    
    $napoveda = New-Object system.Windows.Forms.Form
    $napoveda.Text = "Napoveda"
    $napoveda.TopMost = $true
    $napoveda.Width = 400
    $napoveda.Height = 400
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,90)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",15,[System.Drawing.FontStyle]::Italic)
    $Label.Text = "Tady ma byt nejaka strasne chytra napoveda"
    $napoveda.Controls.Add($Label)
[void]$Form.ShowDialog()
$Form.Dispose()


Write-Host -Object "$(Get-Date) GUI bylo nacteno"

Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne nacteno"


Write-Host -Object "$(Get-Date) Okno aplikace bylo uspesne zavreno";