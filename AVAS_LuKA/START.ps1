   
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
  $MyForm.Size = New-Object System.Drawing.Size(300,300) 
   
 
    $mbtn_final = New-Object System.Windows.Forms.Button 
        $mbtn_final.Text="Final" 
        $mbtn_final.Top="104" 
        $mbtn_final.Left="15" 
        $mbtn_final.Anchor="Left,Top" 
    $mbtn_final.Size = New-Object System.Drawing.Size(100,23) 
    $mbtn_final.Add_Click( {
    Start-Process -FilePath powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\final.ps1'
})
    $MyForm.Controls.Add($mbtn_final) 
     
 
    $mbtn_test = New-Object System.Windows.Forms.Button 
        $mbtn_test.Text="Testovaci" 
        $mbtn_test.Top="104" 
        $mbtn_test.Left="136" 
        $mbtn_test.Anchor="Left,Top" 
    $mbtn_test.Size = New-Object System.Drawing.Size(100,23) 
    $mbtn_test.Add_Click( {
    Start-Process -FilePath powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\avas.ps1'
})
    $MyForm.Controls.Add($mbtn_test) 
     
 
    $mbtn_sablony = New-Object System.Windows.Forms.Button 
        $mbtn_sablony.Text="Sprava sablon" 
        $mbtn_sablony.Top="172" 
        $mbtn_sablony.Left="15" 
        $mbtn_sablony.Anchor="Left,Top" 
    $mbtn_sablony.Size = New-Object System.Drawing.Size(100,23) 
    $mbtn_sablony.Add_Click( {
    Start-Process -FilePath powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\sablony.ps1'
})
    $MyForm.Controls.Add($mbtn_sablony) 
    $MyForm.ShowDialog()
