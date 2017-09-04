#Set-ExecutionPolicy -Scope CurrentUser
Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
Write-Host -Object "$(Get-Date) - Nacitam GUI"

Write-Host -Object "$(Get-Date) -Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) Probiha import json"
$data = gc C:\SICZ\hash.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem.Text=($json.OS)
Write-Host $json.OS

Write-Host -Object "$(Get-Date) txtbox_nazevstanice"
$txtbox_nazevstanice.Text=($data.ComputerName)
Write-Host $json.ComputerName

Write-Host -Object "$(Get-Date) txtbox_aktivaceprovedenadne"
$txtbox_aktivaceprovedenadne

Write-Host -Object "$(Get-Date) txtbox_nazevsite"
$txtbox_nazevsite
Write-Host $json.Domain

Write-Host -Object "$(Get-Date) txtbox_tester"
$txtbox_tester

Write-Host -Object "$(Get-Date) txtbox_nazevuzivatele"
$txtbox_nazevuzivatele
Write-Host $json.User

Write-Host -Object "$(Get-Date) txtbox_kancelar"
$txtbox_kancelar

Write-Host -Object "$(Get-Date) txtbox_cislozasuvky"
$txtbox_cislozasuvky

Write-Host -Object "$(Get-Date) txtbox_seriovecislo"
$txtbox_seriovecislo

Write-Host -Object "$(Get-Date) txtbox_integritadatovehosouboru"
$txtbox_integritadatovehosouboru

Write-Host -Object "$(Get-Date) txtbox_prostredi"
$txtbox_prostredi
Write-Host $json.Locale

Write-Host -Object "$(Get-Date) txtbox_stavantiviru"
$txtbox_stavantiviru
Write-Host $json.AV_MS_ResidentOn

Write-Host -Object "$(Get-Date) txtbox_scripty"
$txtbox_scripty

Write-Host $json.Script_StartUp

Write-Host -Object "$(Get-Date) txtbox_ntsyslog"
$txtbox_ntsyslog

Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem
Write-Host $json.OS

Write-Host -Object "$(Get-Date) txtbox_protect"
$txtbox_protect
Write-Host $json.Protect_Ini

Write-Host -Object "$(Get-Date) txtbox_logy"
$txtbox_logy
Write-Host $json.Logs_Application
Write-Host $json.Logs_LanPCS
Write-Host $json.Logs_System

Write-Host -Object "$(Get-Date) txtbox_zaplnenidisku"
$txtbox_zaplnenidisku
Write-Host $json.Local_Disks

Write-Host -Object "$(Get-Date) txtbox_aplikacegp"
$txtbox_aplikacegp
Write-Host $json.Execution_Policy

Write-Host -Object "$(Get-Date) label_chyboveokno"
$label_chyboveokno

Write-Host -Object "$(Get-Date) nacteni aplikaci"
$label_aplikace=(Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)


#==============================================================================================
# XAML - GUI
#==============================================================================================
Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Form"
$Form.TopMost = $true
$Form.Width = 697
$Form.Height = 424

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Název stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$lbl_nazevstanice = New-Object system.windows.Forms.Label
$lbl_nazevstanice.Text = "Název stanice"
$lbl_nazevstanice.AutoSize = $true
$lbl_nazevstanice.Width = 25
$lbl_nazevstanice.Height = 10
$lbl_nazevstanice.location = new-object system.drawing.point(10,20)
$lbl_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevstanice)

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 202
$txtbox_nazevstanice.Height = 20
$txtbox_nazevstanice.location = new-object system.drawing.point(114,21)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)
$txtbox_nazevstanice.Text=$data.ComputerName

$txtbox_nazevstanice = New-Object system.windows.Forms.TextBox
$txtbox_nazevstanice.Width = 202
$txtbox_nazevstanice.Height = 20
$txtbox_nazevstanice.location = new-object system.drawing.point(114,21)
$txtbox_nazevstanice.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevstanice)
$txtbox_nazevstanice.Text=$data.ComputerName

$lbl_aktivace = New-Object system.windows.Forms.Label
$lbl_aktivace.Text = "Aktivace provedena dne:"
$lbl_aktivace.AutoSize = $true
$lbl_aktivace.Width = 25
$lbl_aktivace.Height = 10
$lbl_aktivace.location = new-object system.drawing.point(10,40)
$lbl_aktivace.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivace)

$lbl_aktivace = New-Object system.windows.Forms.Label
$lbl_aktivace.Text = "Aktivace provedena dne:"
$lbl_aktivace.AutoSize = $true
$lbl_aktivace.Width = 25
$lbl_aktivace.Height = 10
$lbl_aktivace.location = new-object system.drawing.point(10,40)
$lbl_aktivace.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_aktivace)

$textBox8 = New-Object system.windows.Forms.TextBox
$textBox8.Width = 148
$textBox8.Height = 20
$textBox8.location = new-object system.drawing.point(169,41)
$textBox8.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox8)

$textBox8 = New-Object system.windows.Forms.TextBox
$textBox8.Width = 148
$textBox8.Height = 20
$textBox8.location = new-object system.drawing.point(169,41)
$textBox8.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox8)

$txtbox_tester = New-Object system.windows.Forms.TextBox
$txtbox_tester.Width = 100
$txtbox_tester.Height = 20
$txtbox_tester.location = new-object system.drawing.point(113,72)
$txtbox_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(12,72)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_tester = New-Object system.windows.Forms.Label
$lbl_tester.Text = "Tester"
$lbl_tester.AutoSize = $true
$lbl_tester.Width = 25
$lbl_tester.Height = 10
$lbl_tester.location = new-object system.drawing.point(12,72)
$lbl_tester.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_tester)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Název sítě:"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(14,95)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$lbl_nazevsite = New-Object system.windows.Forms.Label
$lbl_nazevsite.Text = "Název sítě:"
$lbl_nazevsite.AutoSize = $true
$lbl_nazevsite.Width = 25
$lbl_nazevsite.Height = 10
$lbl_nazevsite.location = new-object system.drawing.point(14,95)
$lbl_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_nazevsite)

$txtbox_nazevsite = New-Object system.windows.Forms.TextBox
$txtbox_nazevsite.Width = 201
$txtbox_nazevsite.Height = 20
$txtbox_nazevsite.location = new-object system.drawing.point(102,95)
$txtbox_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevsite)
$txtbox_nazevsite.Text=$data.Domain

$txtbox_nazevsite = New-Object system.windows.Forms.TextBox
$txtbox_nazevsite.Width = 201
$txtbox_nazevsite.Height = 20
$txtbox_nazevsite.location = new-object system.drawing.point(102,95)
$txtbox_nazevsite.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_nazevsite)
$txtbox_nazevsite.Text=$data.Domain

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jméno uživatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(373,19)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$lbl_jmenouzivatele = New-Object system.windows.Forms.Label
$lbl_jmenouzivatele.Text = "Jméno uživatele"
$lbl_jmenouzivatele.AutoSize = $true
$lbl_jmenouzivatele.Width = 25
$lbl_jmenouzivatele.Height = 10
$lbl_jmenouzivatele.location = new-object system.drawing.point(373,19)
$lbl_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_jmenouzivatele)

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 100
$txtbox_jmenouzivatele.Height = 20
$txtbox_jmenouzivatele.location = new-object system.drawing.point(490,20)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)
$txtbox_jmenouzivatele.Text=$data.User

$txtbox_jmenouzivatele = New-Object system.windows.Forms.TextBox
$txtbox_jmenouzivatele.Width = 100
$txtbox_jmenouzivatele.Height = 20
$txtbox_jmenouzivatele.location = new-object system.drawing.point(490,20)
$txtbox_jmenouzivatele.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_jmenouzivatele)
$txtbox_jmenouzivatele.Text=$data.User

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelář"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(376,41)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$lbl_kancelar = New-Object system.windows.Forms.Label
$lbl_kancelar.Text = "Kancelář"
$lbl_kancelar.AutoSize = $true
$lbl_kancelar.Width = 25
$lbl_kancelar.Height = 10
$lbl_kancelar.location = new-object system.drawing.point(376,41)
$lbl_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_kancelar)

$txtbox_kancelar = New-Object system.windows.Forms.TextBox
$txtbox_kancelar.Width = 100
$txtbox_kancelar.Height = 20
$txtbox_kancelar.location = new-object system.drawing.point(490,47)
$txtbox_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_kancelar)

$txtbox_kancelar = New-Object system.windows.Forms.TextBox
$txtbox_kancelar.Width = 100
$txtbox_kancelar.Height = 20
$txtbox_kancelar.location = new-object system.drawing.point(490,47)
$txtbox_kancelar.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_kancelar)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Číslo zásuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(373,73)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$lbl_cislozasuvky = New-Object system.windows.Forms.Label
$lbl_cislozasuvky.Text = "Číslo zásuvky"
$lbl_cislozasuvky.AutoSize = $true
$lbl_cislozasuvky.Width = 25
$lbl_cislozasuvky.Height = 10
$lbl_cislozasuvky.location = new-object system.drawing.point(373,73)
$lbl_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 100
$txtbox_cislozasuvky.Height = 20
$txtbox_cislozasuvky.location = new-object system.drawing.point(490,73)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$txtbox_cislozasuvky = New-Object system.windows.Forms.TextBox
$txtbox_cislozasuvky.Width = 100
$txtbox_cislozasuvky.Height = 20
$txtbox_cislozasuvky.location = new-object system.drawing.point(490,73)
$txtbox_cislozasuvky.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_cislozasuvky)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Sériové číslo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(373,100)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$lbl_seriovecislo = New-Object system.windows.Forms.Label
$lbl_seriovecislo.Text = "Sériové číslo"
$lbl_seriovecislo.AutoSize = $true
$lbl_seriovecislo.Width = 25
$lbl_seriovecislo.Height = 10
$lbl_seriovecislo.location = new-object system.drawing.point(373,100)
$lbl_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 100
$txtbox_seriovecislo.Height = 20
$txtbox_seriovecislo.location = new-object system.drawing.point(491,101)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$txtbox_seriovecislo = New-Object system.windows.Forms.TextBox
$txtbox_seriovecislo.Width = 100
$txtbox_seriovecislo.Height = 20
$txtbox_seriovecislo.location = new-object system.drawing.point(491,101)
$txtbox_seriovecislo.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_seriovecislo)

$lbl_intdatsouboru = New-Object system.windows.Forms.Label
$lbl_intdatsouboru.Text = "Integrita datového souboru"
$lbl_intdatsouboru.AutoSize = $true
$lbl_intdatsouboru.Width = 25
$lbl_intdatsouboru.Height = 10
$lbl_intdatsouboru.location = new-object system.drawing.point(12,135)
$lbl_intdatsouboru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsouboru)

$lbl_intdatsouboru = New-Object system.windows.Forms.Label
$lbl_intdatsouboru.Text = "Integrita datového souboru"
$lbl_intdatsouboru.AutoSize = $true
$lbl_intdatsouboru.Width = 25
$lbl_intdatsouboru.Height = 10
$lbl_intdatsouboru.location = new-object system.drawing.point(12,135)
$lbl_intdatsouboru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_intdatsouboru)

$txtbox_intdatsouboru = New-Object system.windows.Forms.TextBox
$txtbox_intdatsouboru.Width = 100
$txtbox_intdatsouboru.Height = 20
$txtbox_intdatsouboru.location = new-object system.drawing.point(182,133)
$txtbox_intdatsouboru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsouboru)

$txtbox_intdatsouboru = New-Object system.windows.Forms.TextBox
$txtbox_intdatsouboru.Width = 100
$txtbox_intdatsouboru.Height = 20
$txtbox_intdatsouboru.location = new-object system.drawing.point(182,133)
$txtbox_intdatsouboru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_intdatsouboru)

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 100
$txtbox_prostredi.Height = 20
$txtbox_prostredi.location = new-object system.drawing.point(119,176)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$data.Locale

$txtbox_prostredi = New-Object system.windows.Forms.TextBox
$txtbox_prostredi.Width = 100
$txtbox_prostredi.Height = 20
$txtbox_prostredi.location = new-object system.drawing.point(119,176)
$txtbox_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_prostredi)
$txtbox_prostredi.Text=$data.Locale

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostředí"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(11,174)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_prostredi = New-Object system.windows.Forms.Label
$lbl_prostredi.Text = "Prostředí"
$lbl_prostredi.AutoSize = $true
$lbl_prostredi.Width = 25
$lbl_prostredi.Height = 10
$lbl_prostredi.location = new-object system.drawing.point(11,174)
$lbl_prostredi.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_prostredi)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(9,205)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$lbl_stavantiviru = New-Object system.windows.Forms.Label
$lbl_stavantiviru.Text = "Stav antiviru"
$lbl_stavantiviru.AutoSize = $true
$lbl_stavantiviru.Width = 25
$lbl_stavantiviru.Height = 10
$lbl_stavantiviru.location = new-object system.drawing.point(9,205)
$lbl_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_stavantiviru)

$txbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txbox_stavantiviru.Multiline = $true
$txbox_stavantiviru.Width = 100
$txbox_stavantiviru.Height = 20
$txbox_stavantiviru.location = new-object system.drawing.point(105,205)
$txbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txbox_stavantiviru)


$txbox_stavantiviru = New-Object system.windows.Forms.TextBox
$txbox_stavantiviru.Multiline = $true
$txbox_stavantiviru.Width = 100
$txbox_stavantiviru.Height = 20
$txbox_stavantiviru.location = new-object system.drawing.point(105,205)
$txbox_stavantiviru.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txbox_stavantiviru)

$lbl_skripty = New-Object system.windows.Forms.Label
$lbl_skripty.Text = "Skripty"
$lbl_skripty.AutoSize = $true
$lbl_skripty.Width = 25
$lbl_skripty.Height = 10
$lbl_skripty.location = new-object system.drawing.point(10,246)
$lbl_skripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_skripty)

$lbl_skripty = New-Object system.windows.Forms.Label
$lbl_skripty.Text = "Skripty"
$lbl_skripty.AutoSize = $true
$lbl_skripty.Width = 25
$lbl_skripty.Height = 10
$lbl_skripty.location = new-object system.drawing.point(10,246)
$lbl_skripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_skripty)

$txtbox_skripty = New-Object system.windows.Forms.TextBox
$txtbox_skripty.Multiline = $true
$txtbox_skripty.Width = 100
$txtbox_skripty.Height = 20
$txtbox_skripty.location = new-object system.drawing.point(99,238)
$txtbox_skripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_skripty)

$txtbox_skripty = New-Object system.windows.Forms.TextBox
$txtbox_skripty.Multiline = $true
$txtbox_skripty.Width = 100
$txtbox_skripty.Height = 20
$txtbox_skripty.location = new-object system.drawing.point(99,238)
$txtbox_skripty.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_skripty)

$txtbox_os = New-Object system.windows.Forms.TextBox
$txtbox_os.Width = 100
$txtbox_os.Height = 20
$txtbox_os.location = new-object system.drawing.point(121,279)
$txtbox_os.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_os)
$txtbox_os.Text=$data.OS

$txtbox_os = New-Object system.windows.Forms.TextBox
$txtbox_os.Width = 100
$txtbox_os.Height = 20
$txtbox_os.location = new-object system.drawing.point(121,279)
$txtbox_os.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_os)
$txtbox_os.Text=$data.OS

$lbl_os = New-Object system.windows.Forms.Label
$lbl_os.Text = "Operační systém"
$lbl_os.AutoSize = $true
$lbl_os.Width = 25
$lbl_os.Height = 10
$lbl_os.location = new-object system.drawing.point(8,280)
$lbl_os.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_os)

$lbl_os = New-Object system.windows.Forms.Label
$lbl_os.Text = "Operační systém"
$lbl_os.AutoSize = $true
$lbl_os.Width = 25
$lbl_os.Height = 10
$lbl_os.location = new-object system.drawing.point(8,280)
$lbl_os.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($lbl_os)

[void]$Form.ShowDialog()
$Form.Dispose()

Write-Host -Object "$(Get-Date) GUI bylo nacteno"


#####################################################################################
# Skripty a funkcionality - začátek
#####################################################################################
Write-Host -Object "$(Get-Date) Probiha import json"
$data = gc C:\SICZ\hash.json


Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem.Text=($data.OS)

Write-Host -Object "$(Get-Date) txtbox_nazevstanice"
$txtbox_nazevstanice.Text=($data.ComputerName)

Write-Host -Object "$(Get-Date) txtbox_aktivaceprovedenadne"
$txtbox_aktivaceprovedenadne

Write-Host -Object "$(Get-Date) txtbox_nazevsite"
$txtbox_nazevsite

Write-Host -Object "$(Get-Date) txtbox_tester"
$txtbox_tester

Write-Host -Object "$(Get-Date) txtbox_nazevuzivatele"
$txtbox_nazevuzivatele

Write-Host -Object "$(Get-Date) txtbox_kancelar"
$txtbox_kancelar

Write-Host -Object "$(Get-Date) txtbox_cislozasuvky"
$txtbox_cislozasuvky

Write-Host -Object "$(Get-Date) txtbox_seriovecislo"
$txtbox_seriovecislo

Write-Host -Object "$(Get-Date) txtbox_integritadatovehosouboru"
$txtbox_integritadatovehosouboru

Write-Host -Object "$(Get-Date) txtbox_prostredi"
$txtbox_prostredi

Write-Host -Object "$(Get-Date) txtbox_stavantiviru"
$txtbox_stavantiviru.text=

Write-Host -Object "$(Get-Date) txtbox_scripty"
$txtbox_scripty

Write-Host -Object "$(Get-Date) txtbox_ntsyslog"
$txtbox_ntsyslog

Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem

Write-Host -Object "$(Get-Date) txtbox_protect"
$txtbox_protect

Write-Host -Object "$(Get-Date) txtbox_logy"
$txtbox_logy

Write-Host -Object "$(Get-Date) txtbox_zaplnenidisku"
$txtbox_zaplnenidisku

Write-Host -Object "$(Get-Date) txtbox_aplikacegp"
$txtbox_aplikacegp

Write-Host -Object "$(Get-Date) label_chyboveokno"
$label_chyboveokno

Write-Host -Object "$(Get-Date) nacteni aplikaci"
$label_aplikace=(Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)

#####################################################################################
# Skripty a funkcionality - konec
#####################################################################################


#===========================================================================
# Zobrazeni formu
#===========================================================================
Write-Host -Object "$(Get-Date) Okno aplikace bylo nacteno"
$Form.ShowDialog() | out-null
Write-Host -Object "$(Get-Date) Okno aplikace bylo zavreno";