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

Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 
$MyForm = New-Object System.Windows.Forms.Form 
$MyForm.Text="MyForm" 
$MyForm.Size = New-Object System.Drawing.Size(300,300) 
 

    $mlbl_OS = New-Object System.Windows.Forms.Label 
            $mlbl_OS.Text=$json.OS
            $mlbl_OS.Top="64" 
            $mlbl_OS.Left="14" 
            $mlbl_OS.Anchor="Left,Top" 
    $mlbl_OS.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_OS) 
     

    $mRichTextBox1 = New-Object System.Windows.Forms.RichTextBox 
            $mRichTextBox1.Text= $json.Computer_Root_Certificates
            $mRichTextBox1.Top="120" 
            $mRichTextBox1.Left="49" 
            $mRichTextBox1.Anchor="Left,Top" 
    $mRichTextBox1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mRichTextBox1) 
    $MyForm.ShowDialog()