 
     
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
    $MyForm.Size = New-Object System.Drawing.Size(1024,800) 
     
 
        $mlbl_computername = New-Object System.Windows.Forms.Label 
                $mlbl_computername.Text="Computer name" 
                $mlbl_computername.Top="37" 
                $mlbl_computername.Left="10" 
                $mlbl_computername.Anchor="Left,Top" 
        $mlbl_computername.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mlbl_computername) 
         
 
        $mlbl_date = New-Object System.Windows.Forms.Label 
                $mlbl_date.Text="Date" 
                $mlbl_date.Top="66" 
                $mlbl_date.Left="10" 
                $mlbl_date.Anchor="Left,Top" 
        $mlbl_date.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mlbl_date) 
         
 
        $mlbl_user = New-Object System.Windows.Forms.Label 
                $mlbl_user.Text="User" 
                $mlbl_user.Top="99" 
                $mlbl_user.Left="11" 
                $mlbl_user.Anchor="Left,Top" 
        $mlbl_user.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mlbl_user) 
         
 
        $mlbl_lastuser = New-Object System.Windows.Forms.Label 
                $mlbl_lastuser.Text="Last user" 
                $mlbl_lastuser.Top="133" 
                $mlbl_lastuser.Left="12" 
                $mlbl_lastuser.Anchor="Left,Top" 
        $mlbl_lastuser.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mlbl_lastuser) 
        $MyForm.ShowDialog()
