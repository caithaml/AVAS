Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
Write-Host -Object "$(Get-Date) - Nacitam GUI"

#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json=gc C:\SICZ\hash.json | ConvertFrom-Json
Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"
#==============================================================================================
# GUI
#==============================================================================================
Write-Host -Object "$(Get-Date) Probiha nacitani GUI"

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Form"
$Form.TopMost = $true
$Form.Width = 400
$Form.Height = 400

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Form"
$Form.TopMost = $true
$Form.Width = 200
$Form.Height = 200

$btn_zobrazitvypiscriptu = New-Object system.windows.Forms.Button
$btn_zobrazitvypiscriptu.Text = "Zobrazit Startup script"
$btn_zobrazitvypiscriptu.Width = 60
$btn_zobrazitvypiscriptu.Height = 30
$btn_zobrazitvypiscriptu.Add_Click({
    $txtbox_startup.Text=$json.Script_StartUp
})
$btn_zobrazitvypiscriptu.location = new-object system.drawing.point(10,20)
$btn_zobrazitvypiscriptu.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_zobrazitvypiscriptu)

$btn_zobrazitvypiscriptu = New-Object system.windows.Forms.Button
$btn_zobrazitvypiscriptu.Text = "Zobrazit Startup script"
$btn_zobrazitvypiscriptu.Width = 60
$btn_zobrazitvypiscriptu.Height = 30
$btn_zobrazitvypiscriptu.Add_Click({
    $txtbox_startup.Text=$json.Script_StartUp
})
$btn_zobrazitvypiscriptu.location = new-object system.drawing.point(10,20)
$btn_zobrazitvypiscriptu.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_zobrazitvypiscriptu)

$btn_zobaritshutdownsckript = New-Object system.windows.Forms.Button
$btn_zobaritshutdownsckript.Text = "Zobrazit Shutdown script"
$btn_zobaritshutdownsckript.Width = 60
$btn_zobaritshutdownsckript.Height = 30
$btn_zobaritshutdownsckript.Add_Click({
    $txtbox_startup.Text=$json.Script_StartUp
})
$btn_zobaritshutdownsckript.location = new-object system.drawing.point(86,19)
$btn_zobaritshutdownsckript.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_zobaritshutdownsckript)

$btn_zobaritshutdownsckript = New-Object system.windows.Forms.Button
$btn_zobaritshutdownsckript.Text = "Zobrazit Shutdown script"
$btn_zobaritshutdownsckript.Width = 60
$btn_zobaritshutdownsckript.Height = 30
$btn_zobaritshutdownsckript.Add_Click({
$txtbox_startup.Text=$json.Script_StartUp
})
$btn_zobaritshutdownsckript.location = new-object system.drawing.point(86,19)
$btn_zobaritshutdownsckript.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($btn_zobaritshutdownsckript)



$txtbox_startup = New-Object system.windows.Forms.TextBox
$txtbox_startup.Multiline = $true
$txtbox_startup.Width = 100
$txtbox_startup.Height = 20
$txtbox_startup.location = new-object system.drawing.point(11,88)
$txtbox_startup.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_vpisstartup)

$txtbox_startup = New-Object system.windows.Forms.TextBox
$txtbox_startup.Multiline = $true
$txtbox_startup.Width = 100
$txtbox_startup.Height = 20
$txtbox_startup.location = new-object system.drawing.point(11,88)
$txtbox_startup.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_vpisstartup)

$txtbox_shutdownscript = New-Object system.windows.Forms.TextBox
$txtbox_shutdownscript.Multiline = $true
$txtbox_shutdownscript.Width = 100
$txtbox_shutdownscript.Height = 20
$txtbox_shutdownscript.location = new-object system.drawing.point(10,126)
$txtbox_shutdownscript.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_shutdownscript)

$txtbox_shutdownscript = New-Object system.windows.Forms.TextBox
$txtbox_shutdownscript.Multiline = $true
$txtbox_shutdownscript.Width = 100
$txtbox_shutdownscript.Height = 20
$txtbox_shutdownscript.location = new-object system.drawing.point(10,126)
$txtbox_shutdownscript.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($txtbox_shutdownscript)

[void]$Form.ShowDialog()
$Form.Dispose()
[void]$Form.ShowDialog()
$Form.Dispose()

[void]$Form.ShowDialog()
$Form.Dispose()