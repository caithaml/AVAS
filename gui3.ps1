 
   
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="oknoformulare" 
  $MyForm.Size = New-Object System.Drawing.Size(800,600) 
   
 
    $mLabel1 = New-Object System.Windows.Forms.Label 
        $mLabel1.Text="Jméno stanice" 
        $mLabel1.Top="24" 
        $mLabel1.Left="10" 
        $mLabel1.Anchor="Left,Top" 
    $mLabel1.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel1) 
     
 
    $mjmenostanice = New-Object System.Windows.Forms.Label 
        $mjmenostanice.Text="Label2" 
        $mjmenostanice.Top="24" 
        $mjmenostanice.Left="108" 
        $mjmenostanice.Anchor="Left,Top" 
    $mjmenostanice.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenostanice) 
     
 
    $mLabel3 = New-Object System.Windows.Forms.Label 
        $mLabel3.Text="Aktivace provedena dne" 
        $mLabel3.Top="49" 
        $mLabel3.Left="11" 
        $mLabel3.Anchor="Left,Top" 
    $mLabel3.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel3) 
     
 
    $maktivaceprovedenadne = New-Object System.Windows.Forms.Label 
        $maktivaceprovedenadne.Text="Label4" 
        $maktivaceprovedenadne.Top="63" 
        $maktivaceprovedenadne.Left="108" 
        $maktivaceprovedenadne.Anchor="Left,Top" 
    $maktivaceprovedenadne.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($maktivaceprovedenadne) 
     
 
    $mLabel5 = New-Object System.Windows.Forms.Label 
        $mLabel5.Text="Tester" 
        $mLabel5.Top="89" 
        $mLabel5.Left="12" 
        $mLabel5.Anchor="Left,Top" 
    $mLabel5.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel5) 
     
 
    $mtester = New-Object System.Windows.Forms.Label 
        $mtester.Text="Label6" 
        $mtester.Top="92" 
        $mtester.Left="110" 
        $mtester.Anchor="Left,Top" 
    $mtester.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mtester) 
     
 
    $mLabel7 = New-Object System.Windows.Forms.Label 
        $mLabel7.Text="Jméno sítě" 
        $mLabel7.Top="117" 
        $mLabel7.Left="13" 
        $mLabel7.Anchor="Left,Top" 
    $mLabel7.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel7) 
     
 
    $mjmenosite = New-Object System.Windows.Forms.Label 
        $mjmenosite.Text="Label8" 
        $mjmenosite.Top="120" 
        $mjmenosite.Left="112" 
        $mjmenosite.Anchor="Left,Top" 
    $mjmenosite.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenosite) 
     
 
    $mLabel9 = New-Object System.Windows.Forms.Label 
        $mLabel9.Text="Jméno uživatele" 
        $mLabel9.Top="24" 
        $mLabel9.Left="210" 
        $mLabel9.Anchor="Left,Top" 
    $mLabel9.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel9) 
     
 
    $mjmenouzivatele = New-Object System.Windows.Forms.Label 
        $mjmenouzivatele.Text="Label10" 
        $mjmenouzivatele.Top="26" 
        $mjmenouzivatele.Left="323" 
        $mjmenouzivatele.Anchor="Left,Top" 
    $mjmenouzivatele.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mjmenouzivatele) 
     
 
    $mLabel11 = New-Object System.Windows.Forms.Label 
        $mLabel11.Text="Kancelář" 
        $mLabel11.Top="57" 
        $mLabel11.Left="210" 
        $mLabel11.Anchor="Left,Top" 
    $mLabel11.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel11) 
     
 
    $mkancelar = New-Object System.Windows.Forms.TextBox 
        $mkancelar.Text="TextBox1" 
        $mkancelar.Top="53" 
        $mkancelar.Left="321" 
        $mkancelar.Anchor="Left,Top" 
    $mkancelar.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mkancelar) 
     
 
    $mLabel12 = New-Object System.Windows.Forms.Label 
        $mLabel12.Text="Číslo zásuvbky" 
        $mLabel12.Top="92" 
        $mLabel12.Left="210" 
        $mLabel12.Anchor="Left,Top" 
    $mLabel12.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel12) 
     
 
    $mcislozasuvky = New-Object System.Windows.Forms.TextBox 
        $mcislozasuvky.Text="TextBox2" 
        $mcislozasuvky.Top="87" 
        $mcislozasuvky.Left="321" 
        $mcislozasuvky.Anchor="Left,Top" 
    $mcislozasuvky.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mcislozasuvky) 
     
 
    $mLabel13 = New-Object System.Windows.Forms.Label 
        $mLabel13.Text="Sériové číslo" 
        $mLabel13.Top="118" 
        $mLabel13.Left="212" 
        $mLabel13.Anchor="Left,Top" 
    $mLabel13.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mLabel13) 
     
 
    $mseriovecislo = New-Object System.Windows.Forms.TextBox 
        $mseriovecislo.Text="TextBox3" 
        $mseriovecislo.Top="115" 
        $mseriovecislo.Left="321" 
        $mseriovecislo.Anchor="Left,Top" 
    $mseriovecislo.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mseriovecislo) 
     
 
    $mTest vysledek = New-Object System.Windows.Forms.TextBox 
        $mTest vysledek.Text="TextBox4" 
        $mTest vysledek.Top="180" 
        $mTest vysledek.Left="19" 
        $mTest vysledek.Anchor="Left,Top" 
    $mTest vysledek.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mTest vysledek) 
     
 
    $mAktivuj = New-Object System.Windows.Forms.Button 
        $mAktivuj.Text="Aktivuj" 
        $mAktivuj.Top="570" 
        $mAktivuj.Left="4" 
        $mAktivuj.Anchor="Left,Top" 
    $mAktivuj.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mAktivuj) 
     
 
    $marchivuj = New-Object System.Windows.Forms.Button 
        $marchivuj.Text="Archivuj" 
        $marchivuj.Top="570" 
        $marchivuj.Left="119" 
        $marchivuj.Anchor="Left,Top" 
    $marchivuj.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($marchivuj) 
     
 
    $mUkazconfig = New-Object System.Windows.Forms.Button 
        $mUkazconfig.Text="Ukaž config" 
        $mUkazconfig.Top="569" 
        $mUkazconfig.Left="237" 
        $mUkazconfig.Anchor="Left,Top" 
    $mUkazconfig.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mUkazconfig) 
     
 
    $mneshodygp = New-Object System.Windows.Forms.Button 
        $mneshodygp.Text="Neshody GP" 
        $mneshodygp.Top="568" 
        $mneshodygp.Left="351" 
        $mneshodygp.Anchor="Left,Top" 
    $mneshodygp.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mneshodygp) 
    $MyForm.ShowDialog()
