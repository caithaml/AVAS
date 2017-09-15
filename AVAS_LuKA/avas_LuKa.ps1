Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
$json = Get-Content D:\SICZ\hash_mica.json | ConvertFrom-Json
$jsondef = Get-Content D:\SICZ\hash_luka.json | ConvertFrom-Json

Write-Host -Object "$(Get-Date) - Dokonce nacitani json konfiguracniho souboru"


Write-Host -Object "$(Get-Date) - zjisteni zda je uzivatel admin"
#overeni ze je uzivatel administrator
Write-Verbose "Kontroluji admin prava"
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Ujistete se ze spoustite AVAS jako administrator! Provedte spusteni jako administrator nebo nemusi vse fungovat korektne!!"
}

Write-Host -Object "$(Get-Date) - ukonceno zjistovani zda je uzivatel admin"

Write-Host -Object "$(Get-Date) - uzivatel je admin pokracuje dalsi spusteni skriptu"
Write-Host -Object "$(Get-Date) - Nacitam GUI"


#==============================================================================================
# GUI
#==============================================================================================
 

     
Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 
$MyForm = New-Object System.Windows.Forms.Form 
$MyForm.Text="AVAS-porovnani testy "
$MyForm.Size = New-Object System.Drawing.Size(800,800) 
 
$mlbl_nazevstanice = New-Object System.Windows.Forms.Label 
$mlbl_nazevstanice.Text="Název stanice" 
$mlbl_nazevstanice.Top="41" 
$mlbl_nazevstanice.Left="6" 
$mlbl_nazevstanice.Anchor="Left,Top" 
$mlbl_nazevstanice.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_nazevstanice) 
     

    $mtxtbox_nazevstanice = New-Object System.Windows.Forms.RichTextBox 
            $mtxtbox_nazevstanice.Text="" 
            $mtxtbox_nazevstanice.Top="41" 
            $mtxtbox_nazevstanice.Left="111" 
            $mtxtbox_nazevstanice.Anchor="Left,Top" 
    $mtxtbox_nazevstanice.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mtxtbox_nazevstanice) 
     

    $mlbl_aktivaceprovedenadne = New-Object System.Windows.Forms.Label 
            $mlbl_aktivaceprovedenadne.Text="Aktivace provedena dne" 
            $mlbl_aktivaceprovedenadne.Top="74" 
            $mlbl_aktivaceprovedenadne.Left="8" 
            $mlbl_aktivaceprovedenadne.Anchor="Left,Top" 
    $mlbl_aktivaceprovedenadne.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_aktivaceprovedenadne) 
     

    $mtxtbox_aktivaceprovedenadne = New-Object System.Windows.Forms.RichTextBox 
            $mtxtbox_aktivaceprovedenadne.Text="" 
            $mtxtbox_aktivaceprovedenadne.Top="79" 
            $mtxtbox_aktivaceprovedenadne.Left="111" 
            $mtxtbox_aktivaceprovedenadne.Anchor="Left,Top" 
    $mtxtbox_aktivaceprovedenadne.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mtxtbox_aktivaceprovedenadne) 
     

    $mlbl_vypisinfotest = New-Object System.Windows.Forms.Label 
            $mlbl_vypisinfotest.Text="Výpis informací o stanici - test!" 
            $mlbl_vypisinfotest.Top="137" 
            $mlbl_vypisinfotest.Left="6" 
            $mlbl_vypisinfotest.Anchor="Left,Top" 
    $mlbl_vypisinfotest.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_vypisinfotest) 
     

    $mlbl_computername = New-Object System.Windows.Forms.Label 
            $mlbl_computername.Text="ComputerName" 
            $mlbl_computername.Top="195" 
            $mlbl_computername.Left="12" 
            $mlbl_computername.Anchor="Left,Top" 
    $mlbl_computername.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_computername) 
     

    $mlbl_computernametext = New-Object System.Windows.Forms.Label 
            $mlbl_computernametext.Text=$json.ComputerName
            $mlbl_computernametext.Top="196" 
            $mlbl_computernametext.Left="120" 
            $mlbl_computernametext.Anchor="Left,Top" 
    $mlbl_computernametext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_computernametext) 
     

    $mlbl_date = New-Object System.Windows.Forms.Label 
            $mlbl_date.Text="Date" 
            $mlbl_date.Top="227" 
            $mlbl_date.Left="13" 
            $mlbl_date.Anchor="Left,Top" 
    $mlbl_date.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_date) 
     

    $mlbl_datetext = New-Object System.Windows.Forms.Label 
            $mlbl_datetext.Text=$json.date
            $mlbl_datetext.Top="231" 
            $mlbl_datetext.Left="119" 
            $mlbl_datetext.Anchor="Left,Top" 
    $mlbl_datetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_datetext) 
     

    $mlbl_user = New-Object System.Windows.Forms.Label 
            $mlbl_user.Text="User" 
            $mlbl_user.Top="259" 
            $mlbl_user.Left="12" 
            $mlbl_user.Anchor="Left,Top" 
    $mlbl_user.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_user) 
     

    $mlbl_usertext = New-Object System.Windows.Forms.Label 
            $mlbl_usertext.Text=$json.user
            $mlbl_usertext.Top="264" 
            $mlbl_usertext.Left="119" 
            $mlbl_usertext.Anchor="Left,Top" 
    $mlbl_usertext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_usertext) 
     

    $mlbl_lastuser = New-Object System.Windows.Forms.Label 
            $mlbl_lastuser.Text="Last user" 
            $mlbl_lastuser.Top="296" 
            $mlbl_lastuser.Left="13" 
            $mlbl_lastuser.Anchor="Left,Top" 
    $mlbl_lastuser.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_lastuser) 
     

    $mlbl_lastusertext = New-Object System.Windows.Forms.Label 
            $mlbl_lastusertext.Text=$json.last_user 
            $mlbl_lastusertext.Top="298" 
            $mlbl_lastusertext.Left="119" 
            $mlbl_lastusertext.Anchor="Left,Top" 
    $mlbl_lastusertext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_lastusertext) 
     

    $mlbl_domain = New-Object System.Windows.Forms.Label 
            $mlbl_domain.Text="Domain" 
            $mlbl_domain.Top="331" 
            $mlbl_domain.Left="14" 
            $mlbl_domain.Anchor="Left,Top" 
    $mlbl_domain.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domain) 
     

    $mlbl_domaintext = New-Object System.Windows.Forms.Label 
            $mlbl_domaintext.Text=$json.Domain 
            $mlbl_domaintext.Top="331" 
            $mlbl_domaintext.Left="118" 
            $mlbl_domaintext.Anchor="Left,Top" 
    $mlbl_domaintext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaintext) 
     

    $mlbl_domaintcp = New-Object System.Windows.Forms.Label 
            $mlbl_domaintcp.Text="Domain TCP" 
            $mlbl_domaintcp.Top="364" 
            $mlbl_domaintcp.Left="12" 
            $mlbl_domaintcp.Anchor="Left,Top" 
    $mlbl_domaintcp.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaintcp) 
     

    $mlbl_domaintcptext = New-Object System.Windows.Forms.Label 
            $mlbl_domaintcptext.Text=$json.domain_tcp
            $mlbl_domaintcptext.Top="363" 
            $mlbl_domaintcptext.Left="118" 
            $mlbl_domaintcptext.Anchor="Left,Top" 
    $mlbl_domaintcptext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaintcptext) 
     

    $mlbl_domaindhcp = New-Object System.Windows.Forms.Label 
            $mlbl_domaindhcp.Text="Domain DHCP" 
            $mlbl_domaindhcp.Top="397" 
            $mlbl_domaindhcp.Left="13" 
            $mlbl_domaindhcp.Anchor="Left,Top" 
    $mlbl_domaindhcp.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaindhcp) 
     

    $mlbl_domaindhcptext = New-Object System.Windows.Forms.Label 
            $mlbl_domaindhcptext.Text=$json.domain_dhcp
            $mlbl_domaindhcptext.Top="396" 
            $mlbl_domaindhcptext.Left="118" 
            $mlbl_domaindhcptext.Anchor="Left,Top" 
    $mlbl_domaindhcptext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaindhcptext) 
     

    $mlbl_sitename = New-Object System.Windows.Forms.Label 
            $mlbl_sitename.Text="Site name" 
            $mlbl_sitename.Top="428" 
            $mlbl_sitename.Left="13" 
            $mlbl_sitename.Anchor="Left,Top" 
    $mlbl_sitename.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sitename) 
     

    $mlbl_sitenametext = New-Object System.Windows.Forms.Label 
            $mlbl_sitenametext.Text=$json.site_name
            $mlbl_sitenametext.Top="429" 
            $mlbl_sitenametext.Left="119" 
            $mlbl_sitenametext.Anchor="Left,Top" 
    $mlbl_sitenametext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sitenametext) 
     

    $mlbl_activedc = New-Object System.Windows.Forms.Label 
            $mlbl_activedc.Text="Active DC" 
            $mlbl_activedc.Top="461" 
            $mlbl_activedc.Left="13" 
            $mlbl_activedc.Anchor="Left,Top" 
    $mlbl_activedc.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_activedc) 
     

    $mlbl_activedctext = New-Object System.Windows.Forms.Label 
            $mlbl_activedctext.Text=$json.active_dc 
            $mlbl_activedctext.Top="460" 
            $mlbl_activedctext.Left="119" 
            $mlbl_activedctext.Anchor="Left,Top" 
    $mlbl_activedctext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_activedctext) 
     

    $mlbl_scriptstartup = New-Object System.Windows.Forms.Label 
            $mlbl_scriptstartup.Text="Script start up" 
            $mlbl_scriptstartup.Top="493" 
            $mlbl_scriptstartup.Left="14" 
            $mlbl_scriptstartup.Anchor="Left,Top" 
    $mlbl_scriptstartup.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_scriptstartup) 
     

    $mbtn_scriptstartup = New-Object System.Windows.Forms.Button 
            $mbtn_scriptstartup.Text="Details" 
            $mbtn_scriptstartup.Top="487" 
            $mbtn_scriptstartup.Left="117" 
            $mbtn_scriptstartup.Anchor="Left,Top" 
            $mbtn_scriptstartup.Add_Click({
                #$btnsablona_OnClick
                #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
                #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
                start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\startup.ps1'
                })
    $mbtn_scriptstartup.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mbtn_scriptstartup) 
     

    $mlbl_scriptshutdown = New-Object System.Windows.Forms.Label 
            $mlbl_scriptshutdown.Text="Script shutdown" 
            $mlbl_scriptshutdown.Top="523" 
            $mlbl_scriptshutdown.Left="13" 
            $mlbl_scriptshutdown.Anchor="Left,Top" 
    $mlbl_scriptshutdown.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_scriptshutdown) 
     

    $mbtn_scriptshutdown = New-Object System.Windows.Forms.Button 
            $mbtn_scriptshutdown.Text="Details" 
            $mbtn_scriptshutdown.Top="520" 
            $mbtn_scriptshutdown.Left="116" 
            $mbtn_scriptshutdown.Anchor="Left,Top" 
    $mbtn_scriptshutdown.Size = New-Object System.Drawing.Size(100,23) 
    $mbtn_scriptshutdown.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\shutdown.ps1'
        
        })
    $MyForm.Controls.Add($mbtn_scriptshutdown) 
     

    $mlbl_os = New-Object System.Windows.Forms.Label 
            $mlbl_os.Text="OS" 
            $mlbl_os.Top="552" 
            $mlbl_os.Left="15" 
            $mlbl_os.Anchor="Left,Top" 
    $mlbl_os.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_os) 
     

    $mlbl_ostext = New-Object System.Windows.Forms.Label 
            $mlbl_ostext.Text=$json.OS 
            $mlbl_ostext.Top="559" 
            $mlbl_ostext.Left="115" 
            $mlbl_ostext.Anchor="Left,Top" 
    $mlbl_ostext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_ostext) 
     

    $mlbl_osbuild = New-Object System.Windows.Forms.Label 
            $mlbl_osbuild.Text="OS build" 
            $mlbl_osbuild.Top="580" 
            $mlbl_osbuild.Left="14" 
            $mlbl_osbuild.Anchor="Left,Top" 
    $mlbl_osbuild.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_osbuild) 
     

    $mlbl_osbuildtext = New-Object System.Windows.Forms.Label 
            $mlbl_osbuildtext.Text=$json.os_build
            $mlbl_osbuildtext.Top="585" 
            $mlbl_osbuildtext.Left="115" 
            $mlbl_osbuildtext.Anchor="Left,Top" 
    $mlbl_osbuildtext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_osbuildtext) 
     

    $mlbl_sp = New-Object System.Windows.Forms.Label 
            $mlbl_sp.Text="Service Pack" 
            $mlbl_sp.Top="615" 
            $mlbl_sp.Left="15" 
            $mlbl_sp.Anchor="Left,Top" 
    $mlbl_sp.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sp) 
     

    $mlbl_sptext = New-Object System.Windows.Forms.Label 
            $mlbl_sptext.Text=$json.sp
            $mlbl_sptext.Top="615" 
            $mlbl_sptext.Left="116" 
            $mlbl_sptext.Anchor="Left,Top" 
    $mlbl_sptext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sptext) 
     

    $mlbl_installdate = New-Object System.Windows.Forms.Label 
            $mlbl_installdate.Text="Install date" 
            $mlbl_installdate.Top="481" 
            $mlbl_installdate.Left="312" 
            $mlbl_installdate.Anchor="Left,Top" 
    $mlbl_installdate.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_installdate) 
     

    $mlbl_installdatetext = New-Object System.Windows.Forms.Label 
            $mlbl_installdatetext.Text=$json.install_date 
            $mlbl_installdatetext.Top="44" 
            $mlbl_installdatetext.Left="232" 
            $mlbl_installdatetext.Anchor="Left,Top" 
    $mlbl_installdatetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_installdatetext) 
     

    $mlbl_lastboottime = New-Object System.Windows.Forms.Label 
            $mlbl_lastboottime.Text="Last boot time" 
            $mlbl_lastboottime.Top="682" 
            $mlbl_lastboottime.Left="16" 
            $mlbl_lastboottime.Anchor="Left,Top" 
    $mlbl_lastboottime.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_lastboottime) 
     

    $mlbl_lastboottimetext = New-Object System.Windows.Forms.Label 
            $mlbl_lastboottimetext.Text=$json.last_boot_time
            $mlbl_lastboottimetext.Top="680" 
            $mlbl_lastboottimetext.Left="115" 
            $mlbl_lastboottimetext.Anchor="Left,Top" 
    $mlbl_lastboottimetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_lastboottimetext) 
     

    $mlbl_ramtotal = New-Object System.Windows.Forms.Label 
            $mlbl_ramtotal.Text="RAM total" 
            $mlbl_ramtotal.Top="714" 
            $mlbl_ramtotal.Left="18" 
            $mlbl_ramtotal.Anchor="Left,Top" 
    $mlbl_ramtotal.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_ramtotal) 
     

    $mlbl_ramtotaltext = New-Object System.Windows.Forms.Label 
            $mlbl_ramtotaltext.Text=$json.ram_total
            $mlbl_ramtotaltext.Top="717" 
            $mlbl_ramtotaltext.Left="116" 
            $mlbl_ramtotaltext.Anchor="Left,Top" 
    $mlbl_ramtotaltext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_ramtotaltext) 
     

    $mlbl_ramfree = New-Object System.Windows.Forms.Label 
            $mlbl_ramfree.Text="RAM free" 
            $mlbl_ramfree.Top="744" 
            $mlbl_ramfree.Left="19" 
            $mlbl_ramfree.Anchor="Left,Top" 
    $mlbl_ramfree.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_ramfree) 
     

    $mlbl_ramfreetext = New-Object System.Windows.Forms.Label 
            $mlbl_ramfreetext.Text=$json.ram_free 
            $mlbl_ramfreetext.Top="746" 
            $mlbl_ramfreetext.Left="116" 
            $mlbl_ramfreetext.Anchor="Left,Top" 
    $mlbl_ramfreetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_ramfreetext) 
     

    $mlbl_virtualtotal = New-Object System.Windows.Forms.Label 
            $mlbl_virtualtotal.Text="Virtual total" 
            $mlbl_virtualtotal.Top="192" 
            $mlbl_virtualtotal.Left="330" 
            $mlbl_virtualtotal.Anchor="Left,Top" 
    $mlbl_virtualtotal.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_virtualtotal) 
     

    $mlbl_virtualtotaltext = New-Object System.Windows.Forms.Label 
            $mlbl_virtualtotaltext.Text=$json.virtual_total
            $mlbl_virtualtotaltext.Top="193" 
            $mlbl_virtualtotaltext.Left="433" 
            $mlbl_virtualtotaltext.Anchor="Left,Top" 
    $mlbl_virtualtotaltext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_virtualtotaltext) 
     

    $mlbl_virtualfree = New-Object System.Windows.Forms.Label 
            $mlbl_virtualfree.Text="Virtual free" 
            $mlbl_virtualfree.Top="226" 
            $mlbl_virtualfree.Left="332" 
            $mlbl_virtualfree.Anchor="Left,Top" 
    $mlbl_virtualfree.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_virtualfree) 
     

    $mlbl_virtualfreetext = New-Object System.Windows.Forms.Label 
            $mlbl_virtualfreetext.Text=$json.virtual_free 
            $mlbl_virtualfreetext.Top="230" 
            $mlbl_virtualfreetext.Left="434" 
            $mlbl_virtualfreetext.Anchor="Left,Top" 
    $mlbl_virtualfreetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_virtualfreetext) 
     

    $mlbl_windir = New-Object System.Windows.Forms.Label 
            $mlbl_windir.Text="Win dir" 
            $mlbl_windir.Top="260" 
            $mlbl_windir.Left="334" 
            $mlbl_windir.Anchor="Left,Top" 
    $mlbl_windir.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_windir) 
     

    $mlbl_windirtext = New-Object System.Windows.Forms.Label 
            $mlbl_windirtext.Text=$json.win_dir 
            $mlbl_windirtext.Top="261" 
            $mlbl_windirtext.Left="432" 
            $mlbl_windirtext.Anchor="Left,Top" 
    $mlbl_windirtext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_windirtext) 
     

    $mlbl_sysdir = New-Object System.Windows.Forms.Label 
            $mlbl_sysdir.Text="Sys dir" 
            $mlbl_sysdir.Top="285" 
            $mlbl_sysdir.Left="326" 
            $mlbl_sysdir.Anchor="Left,Top" 
    $mlbl_sysdir.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sysdir) 
     

    $mlbl_sysdirtext = New-Object System.Windows.Forms.Label 
            $mlbl_sysdirtext.Text=$json.sys_dir
            $mlbl_sysdirtext.Top="290" 
            $mlbl_sysdirtext.Left="434" 
            $mlbl_sysdirtext.Anchor="Left,Top" 
    $mlbl_sysdirtext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sysdirtext) 
     

    $mlbl_tempdir = New-Object System.Windows.Forms.Label 
            $mlbl_tempdir.Text="TEMP dir" 
            $mlbl_tempdir.Top="313" 
            $mlbl_tempdir.Left="320" 
            $mlbl_tempdir.Anchor="Left,Top" 
    $mlbl_tempdir.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_tempdir) 
     

    $mlbl_tempdirtext = New-Object System.Windows.Forms.Label 
            $mlbl_tempdirtext.Text=$json.temp_dir 
            $mlbl_tempdirtext.Top="319" 
            $mlbl_tempdirtext.Left="435" 
            $mlbl_tempdirtext.Anchor="Left,Top" 
    $mlbl_tempdirtext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_tempdirtext) 
     

    $mlbl_exepolicy = New-Object System.Windows.Forms.Label 
            $mlbl_exepolicy.Text="Execution policy" 
            $mlbl_exepolicy.Top="351" 
            $mlbl_exepolicy.Left="296" 
            $mlbl_exepolicy.Anchor="Left,Top" 
    $mlbl_exepolicy.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_exepolicy) 
     

    $mbtn_exepolicy = New-Object System.Windows.Forms.Button 
            $mbtn_exepolicy.Text="Details" 
            $mbtn_exepolicy.Top="347" 
            $mbtn_exepolicy.Left="430" 
            $mbtn_exepolicy.Anchor="Left,Top" 
            $mbtn_exepolicy.Add_Click({
                #$btnsablona_OnClick
                #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
                #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
                start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\execpolicy.ps1'
                
                })
             
            
            
    $mbtn_exepolicy.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mbtn_exepolicy) 
     

    $mlbl_protect = New-Object System.Windows.Forms.Label 
            $mlbl_protect.Text="Protect ini" 
            $mlbl_protect.Top="385" 
            $mlbl_protect.Left="315" 
            $mlbl_protect.Anchor="Left,Top" 
    $mlbl_protect.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_protect) 
     

    $mlbl_protecttext = New-Object System.Windows.Forms.Label 
            $mlbl_protecttext.Text=$json.protect_ini
            $mlbl_protecttext.Top="390" 
            $mlbl_protecttext.Left="432" 
            $mlbl_protecttext.Anchor="Left,Top" 
    $mlbl_protecttext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_protecttext) 
     

    $mlbl_bios = New-Object System.Windows.Forms.Label 
            $mlbl_bios.Text="Bios" 
            $mlbl_bios.Top="418" 
            $mlbl_bios.Left="317" 
            $mlbl_bios.Anchor="Left,Top" 
    $mlbl_bios.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_bios) 
     

    $mlbl_biostext = New-Object System.Windows.Forms.Label 
            $mlbl_biostext.Text=$json.Bios
            $mlbl_biostext.Top="422" 
            $mlbl_biostext.Left="435" 
            $mlbl_biostext.Anchor="Left,Top" 
    $mlbl_biostext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_biostext) 
     

    $mlbl_biosdate = New-Object System.Windows.Forms.Label 
            $mlbl_biosdate.Text="BIOS date" 
            $mlbl_biosdate.Top="447" 
            $mlbl_biosdate.Left="308" 
            $mlbl_biosdate.Anchor="Left,Top" 
    $mlbl_biosdate.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_biosdate) 
     

    $mlbl_biosdatetext = New-Object System.Windows.Forms.Label 
            $mlbl_biosdatetext.Text=$json.bios_date
            $mlbl_biosdatetext.Top="447" 
            $mlbl_biosdatetext.Left="434" 
            $mlbl_biosdatetext.Anchor="Left,Top" 
    $mlbl_biosdatetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_biosdatetext) 
     

    $mlbl_installdate = New-Object System.Windows.Forms.Label 
            $mlbl_installdate.Text="Install date" 
            $mlbl_installdate.Top="481" 
            $mlbl_installdate.Left="312" 
            $mlbl_installdate.Anchor="Left,Top" 
    $mlbl_installdate.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_installdate) 
     

    $mlbl_installdatetext = New-Object System.Windows.Forms.Label 
            $mlbl_installdatetext.Text=$json.install_date 
            $mlbl_installdatetext.Top="44" 
            $mlbl_installdatetext.Left="232" 
            $mlbl_installdatetext.Anchor="Left,Top" 
    $mlbl_installdatetext.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_installdatetext) 
     

    $mlbl_domaindef = New-Object System.Windows.Forms.Label 
            $mlbl_domaindef.Text=$jsondef.Domain
            $mlbl_domaindef.Top="332" 
            $mlbl_domaindef.Left="218" 
            $mlbl_domaindef.Anchor="Left,Top" 
    $mlbl_domaindef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaindef) 
     

    $mlbl_domaintcpdef = New-Object System.Windows.Forms.Label 
            $mlbl_domaintcpdef.Text=$jsondef.domain_tcp 
            $mlbl_domaintcpdef.Top="368" 
            $mlbl_domaintcpdef.Left="220" 
            $mlbl_domaintcpdef.Anchor="Left,Top" 
    $mlbl_domaintcpdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaintcpdef) 
     

    $mlbl_domaindhcpdef = New-Object System.Windows.Forms.Label 
            $mlbl_domaindhcpdef.Text=$jsondef.domain_dhcp
            $mlbl_domaindhcpdef.Top="397" 
            $mlbl_domaindhcpdef.Left="221" 
            $mlbl_domaindhcpdef.Anchor="Left,Top" 
    $mlbl_domaindhcpdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_domaindhcpdef) 
     

    $mlbl_sitenamedef = New-Object System.Windows.Forms.Label 
            $mlbl_sitenamedef.Text=$jsondef.site_name
            $mlbl_sitenamedef.Top="426" 
            $mlbl_sitenamedef.Left="221" 
            $mlbl_sitenamedef.Anchor="Left,Top" 
    $mlbl_sitenamedef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sitenamedef) 
     

    $mlbl_activedcdef = New-Object System.Windows.Forms.Label 
            $mlbl_activedcdef.Text=$jsondef.active_dc
            $mlbl_activedcdef.Top="459" 
            $mlbl_activedcdef.Left="223" 
            $mlbl_activedcdef.Anchor="Left,Top" 
    $mlbl_activedcdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_activedcdef) 
     

    $mlbl_osdef = New-Object System.Windows.Forms.Label 
            $mlbl_osdef.Text=$jsondef.OS 
            $mlbl_osdef.Top="559" 
            $mlbl_osdef.Left="227" 
            $mlbl_osdef.Anchor="Left,Top" 
    $mlbl_osdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_osdef) 
     

    $mlbl_osbuilddef = New-Object System.Windows.Forms.Label 
            $mlbl_osbuilddef.Text=$jsondef.os_build
            $mlbl_osbuilddef.Top="587" 
            $mlbl_osbuilddef.Left="226" 
            $mlbl_osbuilddef.Anchor="Left,Top" 
    $mlbl_osbuilddef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_osbuilddef) 
     

    $mlbl_osspdef = New-Object System.Windows.Forms.Label 
            $mlbl_osspdef.Text=$jsondef.sp
            $mlbl_osspdef.Top="618" 
            $mlbl_osspdef.Left="229" 
            $mlbl_osspdef.Anchor="Left,Top" 
    $mlbl_osspdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_osspdef) 
     

    $mlbl_windirdef = New-Object System.Windows.Forms.Label 
            $mlbl_windirdef.Text=$jsondef.win_dir 
            $mlbl_windirdef.Top="264" 
            $mlbl_windirdef.Left="538" 
            $mlbl_windirdef.Anchor="Left,Top" 
    $mlbl_windirdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_windirdef) 
     

    $mlbl_sysdirdef = New-Object System.Windows.Forms.Label 
            $mlbl_sysdirdef.Text=$jsondef.sys_dir
            $mlbl_sysdirdef.Top="292" 
            $mlbl_sysdirdef.Left="537" 
            $mlbl_sysdirdef.Anchor="Left,Top" 
    $mlbl_sysdirdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_sysdirdef) 
     

    $mlbl_tempdirdef = New-Object System.Windows.Forms.Label 
            $mlbl_tempdirdef.Text=$jsondef.temp_dir 
            $mlbl_tempdirdef.Top="320" 
            $mlbl_tempdirdef.Left="541" 
            $mlbl_tempdirdef.Anchor="Left,Top" 
    $mlbl_tempdirdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_tempdirdef) 
     

    $mlbl_protectdef = New-Object System.Windows.Forms.Label 
            $mlbl_protectdef.Text=$jsondef.protect_ini 
            $mlbl_protectdef.Top="393" 
            $mlbl_protectdef.Left="541" 
            $mlbl_protectdef.Anchor="Left,Top" 
    $mlbl_protectdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_protectdef) 
     

    $mlbl_biosdef = New-Object System.Windows.Forms.Label 
            $mlbl_biosdef.Text=$jsondef.Bios
            $mlbl_biosdef.Top="424" 
            $mlbl_biosdef.Left="538" 
            $mlbl_biosdef.Anchor="Left,Top" 
    $mlbl_biosdef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_biosdef) 
     

    $mlbl_biosdatedef = New-Object System.Windows.Forms.Label 
            $mlbl_biosdatedef.Text=$jsondef.bios_date
            $mlbl_biosdatedef.Top="452" 
            $mlbl_biosdatedef.Left="537" 
            $mlbl_biosdatedef.Anchor="Left,Top" 
    $mlbl_biosdatedef.Size = New-Object System.Drawing.Size(100,23) 
    $MyForm.Controls.Add($mlbl_biosdatedef) 

    $mlbl_locale = New-Object System.Windows.Forms.Label 
    $mlbl_locale.Text="Locale" 
    $mlbl_locale.Top="515" 
    $mlbl_locale.Left="318" 
    $mlbl_locale.Anchor="Left,Top" 
$mlbl_locale.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_locale) 


$mlbl_localetext = New-Object System.Windows.Forms.Label 
    $mlbl_localetext.Text=$json.Locale
    $mlbl_localetext.Top="518" 
    $mlbl_localetext.Left="426" 
    $mlbl_localetext.Anchor="Left,Top" 
$mlbl_localetext.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_localetext) 


$mlbl_localedef = New-Object System.Windows.Forms.Label 
    $mlbl_localedef.Text=$jsondef.locale
    $mlbl_localedef.Top="520" 
    $mlbl_localedef.Left="529" 
    $mlbl_localedef.Anchor="Left,Top" 
$mlbl_localedef.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_localedef) 


$mlbl_installdatetext = New-Object System.Windows.Forms.Label 
    $mlbl_installdatetext.Text=$json.install_date
    $mlbl_installdatetext.Top="480" 
    $mlbl_installdatetext.Left="431" 
    $mlbl_installdatetext.Anchor="Left,Top" 
$mlbl_installdatetext.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_installdatetext) 


$mlbl_laps = New-Object System.Windows.Forms.Label 
    $mlbl_laps.Text="LAPS" 
    $mlbl_laps.Top="550" 
    $mlbl_laps.Left="325" 
    $mlbl_laps.Anchor="Left,Top" 
$mlbl_laps.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_laps) 


$mlbl_laps_text = New-Object System.Windows.Forms.Label 
    $mlbl_laps_text.Text=$json.LAPS
    $mlbl_laps_text.Top="552" 
    $mlbl_laps_text.Left="426" 
    $mlbl_laps_text.Anchor="Left,Top" 
$mlbl_laps_text.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_laps_text) 


$mlbl_lapsdef = New-Object System.Windows.Forms.Label 
    $mlbl_lapsdef.Text=$jsondef.LAPS 
    $mlbl_lapsdef.Top="554" 
    $mlbl_lapsdef.Left="531" 
    $mlbl_lapsdef.Anchor="Left,Top" 
$mlbl_lapsdef.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_lapsdef) 


$mlbl_rootcert = New-Object System.Windows.Forms.Label 
    $mlbl_rootcert.Text="Root certificates" 
    $mlbl_rootcert.Top="581" 
    $mlbl_rootcert.Left="328" 
    $mlbl_rootcert.Anchor="Left,Top" 
$mlbl_rootcert.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_rootcert) 


$mbtn_rootcert = New-Object System.Windows.Forms.Button 
    $mbtn_rootcert.Text="Details" 
    $mbtn_rootcert.Top="580" 
    $mbtn_rootcert.Left="431" 
    $mbtn_rootcert.Anchor="Left,Top" 
$mbtn_rootcert.Size = New-Object System.Drawing.Size(100,23) 
$mbtn_rootcert.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe  -ArgumentList 'D:\SICZ\avas\avas_luka\rootcert.ps1' 
        
        })
$MyForm.Controls.Add($mbtn_rootcert) 


$mlbl_uefixbios = New-Object System.Windows.Forms.Label 
    $mlbl_uefixbios.Text="UEFIxBIOS" 
    $mlbl_uefixbios.Top="644" 
    $mlbl_uefixbios.Left="232" 
    $mlbl_uefixbios.Anchor="Left,Top" 
$mlbl_uefixbios.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_uefixbios) 


$mlbl_uefixbiostext = New-Object System.Windows.Forms.Label 
    $mlbl_uefixbiostext.Text=$json.UEFIx
    $mlbl_uefixbiostext.Top="643" 
    $mlbl_uefixbiostext.Left="331" 
    $mlbl_uefixbiostext.Anchor="Left,Top" 
$mlbl_uefixbiostext.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_uefixbiostext) 


$mlbl_uefixbiosdef = New-Object System.Windows.Forms.Label 
    $mlbl_uefixbiosdef.Text=$jsondef.UEFIx
    $mlbl_uefixbiosdef.Top="643" 
    $mlbl_uefixbiosdef.Left="434" 
    $mlbl_uefixbiosdef.Anchor="Left,Top" 
$mlbl_uefixbiosdef.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mlbl_uefixbiosdef) 

$mbtn_vytvoritsablonu = New-Object System.Windows.Forms.Button 
$mbtn_vytvoritsablonu.Text="Create system template" 
$mbtn_vytvoritsablonu.Top="18" 
$mbtn_vytvoritsablonu.Left="621" 
$mbtn_vytvoritsablonu.Anchor="Left,Top" 
$mbtn_vytvoritsablonu.Size = New-Object System.Drawing.Size(150,23) 
function createtemplate {
        
         "D:\SICZ\avas\avas_luka\icwsc_template.ps1"
        }
        $btnsablona_OnClick = ${function:createtemplate}
$mbtn_vytvoritsablonu.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\icwsc_template.ps1'
        
        })

#$mbtn_vytvoritsablonu.Click
#{
 #       start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
  #      $btnsablona_OnClick
#}

$MyForm.Controls.Add($mbtn_vytvoritsablonu)

$mbtn_syslog = New-Object System.Windows.Forms.Button 
$mbtn_syslog.Text="Syslog" 
$mbtn_syslog.Top="677" 
$mbtn_syslog.Left="229" 
$mbtn_syslog.Anchor="Left,Top" 
$mbtn_syslog.Size = New-Object System.Drawing.Size(100,23) 
$mbtn_syslog.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\syslog.ps1'
        
        })
$MyForm.Controls.Add($mbtn_syslog) 


$mbtn_applog = New-Object System.Windows.Forms.Button 
$mbtn_applog.Text="Applog" 
$mbtn_applog.Top="678" 
$mbtn_applog.Left="347" 
$mbtn_applog.Anchor="Left,Top" 
$mbtn_applog.Size = New-Object System.Drawing.Size(100,23) 
$mbtn_applog.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\applog.ps1'
        
        })
$MyForm.Controls.Add($mbtn_applog) 

$mbtn_app = New-Object System.Windows.Forms.Button 
$mbtn_app.Text="Apps" 
$mbtn_app.Top="721" 
$mbtn_app.Left="230" 
$mbtn_app.Anchor="Left,Top" 
$mbtn_app.Size = New-Object System.Drawing.Size(100,23) 
$mtbn_app.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\apps.ps1'
        })
$MyForm.Controls.Add($mbtn_app) 


$mbtn_services = New-Object System.Windows.Forms.Button 
$mbtn_services.Text="Services" 
$mbtn_services.Top="725" 
$mbtn_services.Left="348" 
$mbtn_services.Anchor="Left,Top" 
$mbtn_services.Size = New-Object System.Drawing.Size(100,23) 
$mbtn_services.Add_Click({
        #$btnsablona_OnClick
        #start -FilePath powershell.exe -ArgumentList "-command {D:\SICZ\avas\avas_luka\icwsc_template.ps1}" 
        #start PowerShell.exe -FilePath D:\SICZ\avas\avas_luka\icwsc_template.ps1
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\services.ps1'
        
        })
$MyForm.Controls.Add($mbtn_services) 


$MyForm.ShowDialog()


