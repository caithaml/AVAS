    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
  $MyForm.Size = New-Object System.Drawing.Size(300,300) 
   
 
    $mButton1 = New-Object System.Windows.Forms.Button 
        $mButton1.Text="Sablona full" 
        $mButton1.Top="29" 
        $mButton1.Left="11" 
        $mButton1.Anchor="Left,Top" 
    $mButton1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mButton1) 
     
 
    $mButton2 = New-Object System.Windows.Forms.Button 
        $mButton2.Text="Sablona_clean" 
        $mButton2.Top="64" 
        $mButton2.Left="13" 
        $mButton2.Anchor="Left,Top" 
    $mButton2.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mButton2) 
     
 
    $mButton3 = New-Object System.Windows.Forms.Button 
        $mButton3.Text="Sablona test" 
        $mButton3.Top="100" 
        $mButton3.Left="14" 
        $mButton3.Anchor="Left,Top" 
    $mButton3.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mButton3) 
    $MyForm.ShowDialog()
