 
   
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
  $MyForm.Size = New-Object System.Drawing.Size(1024,800) 
   
 
    $mTextBox1 = New-Object System.Windows.Forms.TextBox 
        $mTextBox1.Text="TextBox1" 
        $mTextBox1.Top="5" 
        $mTextBox1.Left="5" 
        $mTextBox1.Anchor="Left,Top" 
    $mTextBox1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mTextBox1) 
     
 
    $mButton1 = New-Object System.Windows.Forms.Button 
        $mButton1.Text="Button1" 
        $mButton1.Top="13" 
        $mButton1.Left="622" 
        $mButton1.Anchor="Left,Top" 
    $mButton1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mButton1) 
    $MyForm.ShowDialog()
