 
   
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
  $MyForm.Size = New-Object System.Drawing.Size(1024,800) 
   
 
    $mbtn_spustiticwsc = New-Object System.Windows.Forms.Button 
        $mbtn_spustiticwsc.Text="Spustit ICWSC" 
        $mbtn_spustiticwsc.Top="19" 
        $mbtn_spustiticwsc.Left="5" 
        $mbtn_spustiticwsc.Anchor="Left,Top" 
    $mbtn_spustiticwsc.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mbtn_spustiticwsc) 
     
 
    $mlbl_aktivacestanicetext = New-Object System.Windows.Forms.Label 
        $mlbl_aktivacestanicetext.Text="Aktivace pracovní stanice" 
        $mlbl_aktivacestanicetext.Top="82" 
        $mlbl_aktivacestanicetext.Left="8" 
        $mlbl_aktivacestanicetext.Anchor="Left,Top" 
    $mlbl_aktivacestanicetext.Size = New-Object System.Drawing.Size(120,23) 
    $MyForm.Controls.Add($mlbl_aktivacestanicetext) 
    $MyForm.ShowDialog()
