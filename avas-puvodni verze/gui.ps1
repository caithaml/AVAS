 
     
Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 
$MyForm = New-Object -TypeName System.Windows.Forms.Form 
$MyForm.Text = 'oknoformulare' 
$MyForm.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (1024, 800) 
     
 
$mLabel1 = New-Object -TypeName System.Windows.Forms.Label 
$mLabel1.Text = 'Label1' 
$mLabel1.Top = '64' 
$mLabel1.Left = '555' 
$mLabel1.Anchor = 'Left,Top' 
$mLabel1.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (100, 23) 
$MyForm.Controls.Add($mLabel1) 
         
 
$mButton1 = New-Object -TypeName System.Windows.Forms.Button 
$mButton1.Text = 'Button1' 
$mButton1.Top = '63' 
$mButton1.Left = '657' 
$mButton1.Anchor = 'Left,Top' 
$mButton1.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (100, 23) 
$MyForm.Controls.Add($mButton1) 
$MyForm.ShowDialog()
