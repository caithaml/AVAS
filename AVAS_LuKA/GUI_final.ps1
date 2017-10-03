$transcriptname = Get-Date -UFormat 'AVAS_%Y_%m_%d'
Start-Transcript -Path "./$transcriptname.log"
#Nacteni JSON souboru s exportovanymi informacemi ze zkusebniho rozhrani
#Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"

Write-Host -Object "$(Get-Date) - Nacitani json konfiguracniho souboru"
Function Get-FileName($initialDirectory)
{
  $null = [System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')
    
  $OpenFileDialog                  = New-Object -TypeName System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.filter           = 'JSON (*.json)| *.json'
  $null = $OpenFileDialog.ShowDialog()
  $OpenFileDialog.filename
}
$inputfile                                   = Get-FileName 'C:\SICZ' #defaultni adresar
$inputdata                                   = Get-Content $inputfile

$json                                        = $inputdata | ConvertFrom-Json
$jsondef                                     = Get-Content -Path D:\SICZ\hash_luka.json | ConvertFrom-Json

### ODSTRANIT !!!! - debug
Write-Host -object "$(get-date) - Obsah souboru: ($json)"
### ODSTRANIT !!!! - debug


Write-Host -Object "$(Get-Date) - Dokonceno nacitani json konfiguracniho souboru"

#$json = Get-Content D:\SICZ\hash_mica.json | ConvertFrom-Json
#$jsondef = Get-Content D:\SICZ\hash_luka.json | ConvertFrom-Json

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
$MyForm.Text = "AVAS" 
$MyForm.Size = New-Object System.Drawing.Size(1024, 850) 
     
 
$mlbl_computername = New-Object System.Windows.Forms.Label 
$mlbl_computername.Text = "Computer name" 
$mlbl_computername.Top = "37" 
$mlbl_computername.Left = "10" 
$mlbl_computername.Anchor = "Left,Top" 
$mlbl_computername.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_computername) 
         
 
$mlbl_date = New-Object System.Windows.Forms.Label 
$mlbl_date.Text = "Date" 
$mlbl_date.Top = "66" 
$mlbl_date.Left = "10" 
$mlbl_date.Anchor = "Left,Top" 
$mlbl_date.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_date) 
         
 
$mlbl_user = New-Object System.Windows.Forms.Label 
$mlbl_user.Text = "User" 
$mlbl_user.Top = "99" 
$mlbl_user.Left = "10" 
$mlbl_user.Anchor = "Left,Top" 
$mlbl_user.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_user) 
         
 
$mlbl_lastuser = New-Object System.Windows.Forms.Label 
$mlbl_lastuser.Text = "Last user" 
$mlbl_lastuser.Top = "133" 
$mlbl_lastuser.Left = "10" 
$mlbl_lastuser.Anchor = "Left,Top" 
$mlbl_lastuser.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_lastuser) 
         
 
$mlbl_domain = New-Object System.Windows.Forms.Label 
$mlbl_domain.Text = "Domain" 
$mlbl_domain.Top = "162" 
$mlbl_domain.Left = "10" 
$mlbl_domain.Anchor = "Left,Top" 
$mlbl_domain.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_domain) 
         
 
$mlbl_domaintcp = New-Object System.Windows.Forms.Label 
$mlbl_domaintcp.Text = "Domain TCP" 
$mlbl_domaintcp.Top = "194" 
$mlbl_domaintcp.Left = "10" 
$mlbl_domaintcp.Anchor = "Left,Top" 
$mlbl_domaintcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_domaintcp) 
         
 
$mlbl_domaindhcp = New-Object System.Windows.Forms.Label 
$mlbl_domaindhcp.Text = "Domain DHCP" 
$mlbl_domaindhcp.Top = "222" 
$mlbl_domaindhcp.Left = "10" 
$mlbl_domaindhcp.Anchor = "Left,Top" 
$mlbl_domaindhcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_domaindhcp) 
         
 
$mlbl_site = New-Object System.Windows.Forms.Label 
$mlbl_site.Text = "Site name" 
$mlbl_site.Top = "254" 
$mlbl_site.Left = "10" 
$mlbl_site.Anchor = "Left,Top" 
$mlbl_site.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_site) 
         
 
$mlbl_activedc = New-Object System.Windows.Forms.Label 
$mlbl_activedc.Text = "Active DC" 
$mlbl_activedc.Top = "284" 
$mlbl_activedc.Left = "11" 
$mlbl_activedc.Anchor = "Left,Top" 
$mlbl_activedc.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_activedc) 
         
 
$mlbl_scriptstartup = New-Object System.Windows.Forms.Label 
$mlbl_scriptstartup.Text = "Script start up" 
$mlbl_scriptstartup.Top = "315" 
$mlbl_scriptstartup.Left = "10" 
$mlbl_scriptstartup.Anchor = "Left,Top" 
$mlbl_scriptstartup.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_scriptstartup) 
         
 
$mlbl_scriptshutdown = New-Object System.Windows.Forms.Label 
$mlbl_scriptshutdown.Text = "Script shutdown" 
$mlbl_scriptshutdown.Top = "344" 
$mlbl_scriptshutdown.Left = "10" 
$mlbl_scriptshutdown.Anchor = "Left,Top" 
$mlbl_scriptshutdown.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_scriptshutdown) 
         
 
$mlbl_os = New-Object System.Windows.Forms.Label 
$mlbl_os.Text = "OS" 
$mlbl_os.Top = "375" 
$mlbl_os.Left = "10" 
$mlbl_os.Anchor = "Left,Top" 
$mlbl_os.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_os) 
         
 
$mlbl_osbuild = New-Object System.Windows.Forms.Label 
$mlbl_osbuild.Text = "OS build" 
$mlbl_osbuild.Top = "403" 
$mlbl_osbuild.Left = "10" 
$mlbl_osbuild.Anchor = "Left,Top" 
$mlbl_osbuild.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_osbuild) 
         
 
$mlbl_servicepack = New-Object System.Windows.Forms.Label 
$mlbl_servicepack.Text = "Service pack" 
$mlbl_servicepack.Top = "433" 
$mlbl_servicepack.Left = "10" 
$mlbl_servicepack.Anchor = "Left,Top" 
$mlbl_servicepack.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_servicepack) 
         
 
$mlbl_installdate = New-Object System.Windows.Forms.Label 
$mlbl_installdate.Text = "OS Install date" 
$mlbl_installdate.Top = "465" 
$mlbl_installdate.Left = "10" 
$mlbl_installdate.Anchor = "Left,Top" 
$mlbl_installdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_installdate) 
         
 
$mlbl_lastboot = New-Object System.Windows.Forms.Label 
$mlbl_lastboot.Text = "OS last boot time" 
$mlbl_lastboot.Top = "496" 
$mlbl_lastboot.Left = "10" 
$mlbl_lastboot.Anchor = "Left,Top" 
$mlbl_lastboot.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_lastboot) 
         
 
$mlbl_ramtotal = New-Object System.Windows.Forms.Label 
$mlbl_ramtotal.Text = "RAM total" 
$mlbl_ramtotal.Top = "530" 
$mlbl_ramtotal.Left = "10" 
$mlbl_ramtotal.Anchor = "Left,Top" 
$mlbl_ramtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_ramtotal) 
         
 
$mlbl_ramfree = New-Object System.Windows.Forms.Label 
$mlbl_ramfree.Text = "RAM free" 
$mlbl_ramfree.Top = "558" 
$mlbl_ramfree.Left = "10" 
$mlbl_ramfree.Anchor = "Left,Top" 
$mlbl_ramfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_ramfree) 
         
 
$mlbl_virtualtotal = New-Object System.Windows.Forms.Label 
$mlbl_virtualtotal.Text = "Virtual total" 
$mlbl_virtualtotal.Top = "588" 
$mlbl_virtualtotal.Left = "10" 
$mlbl_virtualtotal.Anchor = "Left,Top" 
$mlbl_virtualtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_virtualtotal) 
         
 
$mlbl_virtualfree = New-Object System.Windows.Forms.Label 
$mlbl_virtualfree.Text = "Virtual free" 
$mlbl_virtualfree.Top = "615" 
$mlbl_virtualfree.Left = "10" 
$mlbl_virtualfree.Anchor = "Left,Top" 
$mlbl_virtualfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_virtualfree) 
         
 
$mlbl_windir = New-Object System.Windows.Forms.Label 
$mlbl_windir.Text = "WIN dir" 
$mlbl_windir.Top = "644" 
$mlbl_windir.Left = "10" 
$mlbl_windir.Anchor = "Left,Top" 
$mlbl_windir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_windir) 
         
 
$mlbl_sysdir = New-Object System.Windows.Forms.Label 
$mlbl_sysdir.Text = "SYS dir" 
$mlbl_sysdir.Top = "672" 
$mlbl_sysdir.Left = "10" 
$mlbl_sysdir.Anchor = "Left,Top" 
$mlbl_sysdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_sysdir) 
         
 
$mlbl_tempdir = New-Object System.Windows.Forms.Label 
$mlbl_tempdir.Text = "TEMP dir" 
$mlbl_tempdir.Top = "704" 
$mlbl_tempdir.Left = "10" 
$mlbl_tempdir.Anchor = "Left,Top" 
$mlbl_tempdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_tempdir) 
         
 
$mcomputername = New-Object System.Windows.Forms.Label 
$mcomputername.Text = $json.ComputerName
$mcomputername.Top = "38" 
$mcomputername.Left = "115" 
$mcomputername.Anchor = "Left,Top" 
$mcomputername.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mcomputername) 
         
 
$mdate = New-Object System.Windows.Forms.Label 
$mdate.Text = $json.date
$mdate.Top = "71" 
$mdate.Left = "115" 
$mdate.Anchor = "Left,Top" 
$mdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdate) 
         
 
$muser = New-Object System.Windows.Forms.Label 
$muser.Text = $json.user
$muser.Top = "103" 
$muser.Left = "115" 
$muser.Anchor = "Left,Top" 
$muser.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($muser) 
         
 
$mlastuser = New-Object System.Windows.Forms.Label 
$mlastuser.Text = $json.last_user 
$mlastuser.Top = "137" 
$mlastuser.Left = "115" 
$mlastuser.Anchor = "Left,Top" 
$mlastuser.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlastuser) 
         
 
$mdomain = New-Object System.Windows.Forms.Label 
$mdomain.Text = $json.Domain 
$mdomain.Top = "168" 
$mdomain.Left = "115" 
$mdomain.Anchor = "Left,Top" 
$mdomain.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomain) 
         
 
$mdomaintcp = New-Object System.Windows.Forms.Label 
$mdomaintcp.Text = $json.domain_tcp
$mdomaintcp.Top = "199" 
$mdomaintcp.Left = "115" 
$mdomaintcp.Anchor = "Left,Top" 
$mdomaintcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomaintcp) 
         
 
$mdomaindhcp = New-Object System.Windows.Forms.Label 
$mdomaindhcp.Text = $json.domain_dhcp
$mdomaindhcp.Top = "226" 
$mdomaindhcp.Left = "115" 
$mdomaindhcp.Anchor = "Left,Top" 
$mdomaindhcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomaindhcp) 
         
 
$msitename = New-Object System.Windows.Forms.Label 
$msitename.Text = $json.site_name
$msitename.Top = "255" 
$msitename.Left = "115" 
$msitename.Anchor = "Left,Top" 
$msitename.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($msitename) 
         
 
$mactivedc = New-Object System.Windows.Forms.Label 
$mactivedc.Text = $json.active_dc 
$mactivedc.Top = "282" 
$mactivedc.Left = "115" 
$mactivedc.Anchor = "Left,Top" 
$mactivedc.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mactivedc) 
         
 
$mos = New-Object System.Windows.Forms.Label 
$mos.Text = $json.os
$mos.Top = "376" 
$mos.Left = "115" 
$mos.Anchor = "Left,Top" 
$mos.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mos) 
         
 
$mosbuild = New-Object System.Windows.Forms.Label 
$mosbuild.Text = $json.os_build 
$mosbuild.Top = "408" 
$mosbuild.Left = "115" 
$mosbuild.Anchor = "Left,Top" 
$mosbuild.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mosbuild) 
         
 
$mservicepack = New-Object System.Windows.Forms.Label 
$mservicepack.Text = $json.sp 
$mservicepack.Top = "438" 
$mservicepack.Left = "115" 
$mservicepack.Anchor = "Left,Top" 
$mservicepack.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mservicepack) 
         
 
$mosinstalldate = New-Object System.Windows.Forms.Label 
$mosinstalldate.Text = $json.date 
$mosinstalldate.Top = "469" 
$mosinstalldate.Left = "115" 
$mosinstalldate.Anchor = "Left,Top" 
$mosinstalldate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mosinstalldate) 
         
 
$moslastboottime = New-Object System.Windows.Forms.Label 
$moslastboottime.Text = $json.last_boot_time 
$moslastboottime.Top = "497" 
$moslastboottime.Left = "115" 
$moslastboottime.Anchor = "Left,Top" 
$moslastboottime.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($moslastboottime) 
         
 
$mramtotal = New-Object System.Windows.Forms.Label 
$mramtotal.Text = $json.ram_total 
$mramtotal.Top = "531" 
$mramtotal.Left = "115" 
$mramtotal.Anchor = "Left,Top" 
$mramtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mramtotal) 
         
 
$mramfree = New-Object System.Windows.Forms.Label 
$mramfree.Text = $json.ram_free
$mramfree.Top = "560" 
$mramfree.Left = "115" 
$mramfree.Anchor = "Left,Top" 
$mramfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mramfree) 
         
 
$mvirtualtotal = New-Object System.Windows.Forms.Label 
$mvirtualtotal.Text = $json.virtual_total
$mvirtualtotal.Top = "591" 
$mvirtualtotal.Left = "115" 
$mvirtualtotal.Anchor = "Left,Top" 
$mvirtualtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mvirtualtotal) 
         
 
$mvirtualfree = New-Object System.Windows.Forms.Label 
$mvirtualfree.Text = $json.virtual_free 
$mvirtualfree.Top = "619" 
$mvirtualfree.Left = "115" 
$mvirtualfree.Anchor = "Left,Top" 
$mvirtualfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mvirtualfree) 
         
 
$mwindir = New-Object System.Windows.Forms.Label 
$mwindir.Text = $json.win_dir 
$mwindir.Top = "647" 
$mwindir.Left = "115" 
$mwindir.Anchor = "Left,Top" 
$mwindir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mwindir) 
         
 
$msysdir = New-Object System.Windows.Forms.Label 
$msysdir.Text = $json.sys_dir 
$msysdir.Top = "673" 
$msysdir.Left = "115" 
$msysdir.Anchor = "Left,Top" 
$msysdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($msysdir) 
         
 
$mtempdir = New-Object System.Windows.Forms.Label 
$mtempdir.Text = $json.temp_dir
$mtempdir.Top = "703" 
$mtempdir.Left = "115" 
$mtempdir.Anchor = "Left,Top" 
$mtempdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mtempdir) 
         
 
$mbtn_scriptstartup = New-Object System.Windows.Forms.Button 
$mbtn_scriptstartup.Text = "Script startup" 
$mbtn_scriptstartup.Top = "314" 
$mbtn_scriptstartup.Left = "115" 
$mbtn_scriptstartup.Anchor = "Left,Top" 
$mbtn_scriptstartup.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_scriptstartup.Add_Click( {
            
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\startup.ps1'
    })
$MyForm.Controls.Add($mbtn_scriptstartup) 
         
 
$mbtn_scriptshutdown = New-Object System.Windows.Forms.Button 
$mbtn_scriptshutdown.Text = "Script shutdown" 
$mbtn_scriptshutdown.Top = "345" 
$mbtn_scriptshutdown.Left = "115" 
$mbtn_scriptshutdown.Anchor = "Left,Top" 
$mbtn_scriptshutdown.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_scriptshutdown.Add_Click( {
            
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\shutdown.ps1'
             
    })
$MyForm.Controls.Add($mbtn_scriptshutdown) 
         
 
$mlbl_executionpolicy = New-Object System.Windows.Forms.Label 
$mlbl_executionpolicy.Text = "Execution policy" 
$mlbl_executionpolicy.Top = "734" 
$mlbl_executionpolicy.Left = "8" 
$mlbl_executionpolicy.Anchor = "Left,Top" 
$mlbl_executionpolicy.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_executionpolicy) 
         
 
$mbtn_executionpolicy = New-Object System.Windows.Forms.Button 
$mbtn_executionpolicy.Text = "Details" 
$mbtn_executionpolicy.Top = "733" 
$mbtn_executionpolicy.Left = "117" 
$mbtn_executionpolicy.Anchor = "Left,Top" 
$mbtn_executionpolicy.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_executionpolicy.Add_Click( {
                
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\execpolicy.ps1'
                
    })
$MyForm.Controls.Add($mbtn_executionpolicy) 
         
 
$mlbl_protectini = New-Object System.Windows.Forms.Label 
$mlbl_protectini.Text = "Protect INI" 
$mlbl_protectini.Top = "768" 
$mlbl_protectini.Left = "9" 
$mlbl_protectini.Anchor = "Left,Top" 
$mlbl_protectini.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_protectini) 
         
 
$mlbl_bios = New-Object System.Windows.Forms.Label 
$mlbl_bios.Text = "BIOS" 
$mlbl_bios.Top = "800" 
$mlbl_bios.Left = "12" 
$mlbl_bios.Anchor = "Left,Top" 
$mlbl_bios.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_bios) 
         
 
$mlbl_biosdate = New-Object System.Windows.Forms.Label 
$mlbl_biosdate.Text = "BIOS date" 
$mlbl_biosdate.Top = "829" 
$mlbl_biosdate.Left = "11" 
$mlbl_biosdate.Anchor = "Left,Top" 
$mlbl_biosdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_biosdate) 
         
 
$mprotect = New-Object System.Windows.Forms.Label 
$mprotect.Text = $json.protect_ini 
$mprotect.Top = "770" 
$mprotect.Left = "120" 
$mprotect.Anchor = "Left,Top" 
$mprotect.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mprotect) 
         
 
$mbios = New-Object System.Windows.Forms.Label 
$mbios.Text = $json.Bios
$mbios.Top = "799" 
$mbios.Left = "121" 
$mbios.Anchor = "Left,Top" 
$mbios.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbios) 
         
 
$mbiosdate = New-Object System.Windows.Forms.Label 
$mbiosdate.Text = $json.bios_date 
$mbiosdate.Top = "823" 
$mbiosdate.Left = "120" 
$mbiosdate.Anchor = "Left,Top" 
$mbiosdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbiosdate) 
         
 
      

##############################x
# porovnaný sloupec
################################


$mcomputername = New-Object System.Windows.Forms.Label 
$mcomputername.Text = $jsondef.ComputerName
$mcomputername.Top = "38" 
$mcomputername.Left = "330" 
$mcomputername.Anchor = "Left,Top" 
$mcomputername.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mcomputername) 


$mdate = New-Object System.Windows.Forms.Label 
$mdate.Text = $jsondef.date
$mdate.Top = "71" 
$mdate.Left = "330" 
$mdate.Anchor = "Left,Top" 
$mdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdate) 


$muser = New-Object System.Windows.Forms.Label 
$muser.Text = $jsondef.user
$muser.Top = "103" 
$muser.Left = "330" 
$muser.Anchor = "Left,Top" 
$muser.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($muser) 


$mlastuser = New-Object System.Windows.Forms.Label 
$mlastuser.Text = $jsondef.last_user
$mlastuser.Top = "137" 
$mlastuser.Left = "330" 
$mlastuser.Anchor = "Left,Top" 
$mlastuser.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlastuser) 


$mdomain = New-Object System.Windows.Forms.Label 
$mdomain.Text = $jsondef.Domain 
$mdomain.Top = "168" 
$mdomain.Left = "330" 
$mdomain.Anchor = "Left,Top" 
$mdomain.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomain) 


$mdomaintcp = New-Object System.Windows.Forms.Label 
$mdomaintcp.Text = $jsondef.domain_tcp
$mdomaintcp.Top = "199" 
$mdomaintcp.Left = "330" 
$mdomaintcp.Anchor = "Left,Top" 
$mdomaintcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomaintcp) 


$mdomaindhcp = New-Object System.Windows.Forms.Label 
$mdomaindhcp.Text = $jsondef.domain_dhcp
$mdomaindhcp.Top = "226" 
$mdomaindhcp.Left = "330" 
$mdomaindhcp.Anchor = "Left,Top" 
$mdomaindhcp.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mdomaindhcp) 


$msitename = New-Object System.Windows.Forms.Label 
$msitename.Text = $jsondef.site_name
$msitename.Top = "255" 
$msitename.Left = "330" 
$msitename.Anchor = "Left,Top" 
$msitename.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($msitename) 


$mactivedc = New-Object System.Windows.Forms.Label 
$mactivedc.Text = $jsondef.active_dc
$mactivedc.Top = "282" 
$mactivedc.Left = "330" 
$mactivedc.Anchor = "Left,Top" 
$mactivedc.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mactivedc) 


$mos = New-Object System.Windows.Forms.Label 
$mos.Text = $jsondef.os 
$mos.Top = "376" 
$mos.Left = "330" 
$mos.Anchor = "Left,Top" 
$mos.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mos) 


$mosbuild = New-Object System.Windows.Forms.Label 
$mosbuild.Text = $jsondef.os_build
$mosbuild.Top = "408" 
$mosbuild.Left = "330" 
$mosbuild.Anchor = "Left,Top" 
$mosbuild.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mosbuild) 


$mservicepack = New-Object System.Windows.Forms.Label 
$mservicepack.Text = $jsondef.sp
$mservicepack.Top = "438" 
$mservicepack.Left = "330" 
$mservicepack.Anchor = "Left,Top" 
$mservicepack.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mservicepack) 


$mosinstalldate = New-Object System.Windows.Forms.Label 
$mosinstalldate.Text = $jsondef.Install
$mosinstalldate.Top = "469" 
$mosinstalldate.Left = "330" 
$mosinstalldate.Anchor = "Left,Top" 
$mosinstalldate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mosinstalldate) 


$moslastboottime = New-Object System.Windows.Forms.Label 
$moslastboottime.Text = $jsondef.last_boot_time 
$moslastboottime.Top = "497" 
$moslastboottime.Left = "330" 
$moslastboottime.Anchor = "Left,Top" 
$moslastboottime.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($moslastboottime) 


$mramtotal = New-Object System.Windows.Forms.Label 
$mramtotal.Text = $jsondef.ram_total
$mramtotal.Top = "531" 
$mramtotal.Left = "330" 
$mramtotal.Anchor = "Left,Top" 
$mramtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mramtotal) 


$mramfree = New-Object System.Windows.Forms.Label 
$mramfree.Text = $jsondef.ram_free
$mramfree.Top = "560" 
$mramfree.Left = "330" 
$mramfree.Anchor = "Left,Top" 
$mramfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mramfree) 


$mvirtualtotal = New-Object System.Windows.Forms.Label 
$mvirtualtotal.Text = $jsondef.virtual_total
$mvirtualtotal.Top = "591" 
$mvirtualtotal.Left = "330" 
$mvirtualtotal.Anchor = "Left,Top" 
$mvirtualtotal.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mvirtualtotal) 


$mvirtualfree = New-Object System.Windows.Forms.Label 
$mvirtualfree.Text = $jsondef.virtual_free
$mvirtualfree.Top = "619" 
$mvirtualfree.Left = "330" 
$mvirtualfree.Anchor = "Left,Top" 
$mvirtualfree.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mvirtualfree) 


$mwindir = New-Object System.Windows.Forms.Label 
$mwindir.Text = $jsondef.win_dir
$mwindir.Top = "647" 
$mwindir.Left = "330" 
$mwindir.Anchor = "Left,Top" 
$mwindir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mwindir) 


$msysdir = New-Object System.Windows.Forms.Label 
$msysdir.Text = $jsondef.sys_dir
$msysdir.Top = "673" 
$msysdir.Left = "330" 
$msysdir.Anchor = "Left,Top" 
$msysdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($msysdir) 


$mtempdir = New-Object System.Windows.Forms.Label 
$mtempdir.Text = $jsondef.temp_dir
$mtempdir.Top = "703" 
$mtempdir.Left = "330" 
$mtempdir.Anchor = "Left,Top" 
$mtempdir.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mtempdir) 


$mbtn_scriptstartup = New-Object System.Windows.Forms.Button 
$mbtn_scriptstartup.Text = "Script startup" 
$mbtn_scriptstartup.Top = "314" 
$mbtn_scriptstartup.Left = "330" 
$mbtn_scriptstartup.Anchor = "Left,Top" 
$mbtn_scriptstartup.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbtn_scriptstartup) 


$mbtn_scriptshutdown = New-Object System.Windows.Forms.Button 
$mbtn_scriptshutdown.Text = "Script shutdown" 
$mbtn_scriptshutdown.Top = "345" 
$mbtn_scriptshutdown.Left = "330" 
$mbtn_scriptshutdown.Anchor = "Left,Top" 
$mbtn_scriptshutdown.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbtn_scriptshutdown) 




$mbtn_executionpolicy = New-Object System.Windows.Forms.Button 
$mbtn_executionpolicy.Text = "Details" 
$mbtn_executionpolicy.Top = "733" 
$mbtn_executionpolicy.Left = "330" 
$mbtn_executionpolicy.Anchor = "Left,Top" 
$mbtn_executionpolicy.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_executionpolicy.Add_Click( {
        
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\execpolicy.ps1'
        
    })
     
$MyForm.Controls.Add($mbtn_executionpolicy) 


$mlbl_protectini = New-Object System.Windows.Forms.Label 
$mlbl_protectini.Text = $jsondef.protect_ini
$mlbl_protectini.Top = "768" 
$mlbl_protectini.Left = "330" 
$mlbl_protectini.Anchor = "Left,Top" 
$mlbl_protectini.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_protectini) 


$mlbl_bios = New-Object System.Windows.Forms.Label 
$mlbl_bios.Text = $jsondef.Bios
$mlbl_bios.Top = "800" 
$mlbl_bios.Left = "330" 
$mlbl_bios.Anchor = "Left,Top" 
$mlbl_bios.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_bios) 


$mlbl_biosdate = New-Object System.Windows.Forms.Label 
$mlbl_biosdate.Text = $jsondef.bios_date
$mlbl_biosdate.Top = "829" 
$mlbl_biosdate.Left = "11" 
$mlbl_biosdate.Anchor = "Left,Top" 
$mlbl_biosdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_biosdate) 


$mprotect = New-Object System.Windows.Forms.Label 
$mprotect.Text = $jsondef.protect_ini
$mprotect.Top = "770" 
$mprotect.Left = "330" 
$mprotect.Anchor = "Left,Top" 
$mprotect.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mprotect) 


$mbios = New-Object System.Windows.Forms.Label 
$mbios.Text = $jsondef.Bios
$mbios.Top = "799" 
$mbios.Left = "330" 
$mbios.Anchor = "Left,Top" 
$mbios.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbios) 


$mbiosdate = New-Object System.Windows.Forms.Label 
$mbiosdate.Text = $jsondef.bios_date
$mbiosdate.Top = "823" 
$mbiosdate.Left = "330" 
$mbiosdate.Anchor = "Left,Top" 
$mbiosdate.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mbiosdate) 





$mbtn_tisk = New-Object System.Windows.Forms.Button 
$mbtn_tisk.Text = "Tisk formulare - ulozi protokol" 
$mbtn_tisk.Top = "17" 
$mbtn_tisk.Left = "903" 
$mbtn_tisk.Anchor = "Left,Top" 
$mbtn_tisk.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_tisk.Add_Click( {
        $a = "<style>"
        $a = $a + "BODY{background-color:peachpuff;}"
        $a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
        $a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}"
        $a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
        $a = $a + "</style>"
        $tisk = $json.ComputerName
        $tisk = $tisk + $json.OS
        $tisk = $tisk + $json.os_build
        
        $json.Services | ConvertTo-HTML -head $a -body "<H2>Test tisku formulare-pouze procesy!! Formular pripraven $(Get-Date)</H2>" | 
            Out-File C:\SICZ\Testtisk.html
        start chrome C:\SICZ\Testtisk.html
    })


$MyForm.Controls.Add($mbtn_tisk) 


$mbtn_vytvoritsablonu = New-Object System.Windows.Forms.Button 
$mbtn_vytvoritsablonu.Text = "Vytvorit sablonu" 
$mbtn_vytvoritsablonu.Top = "51" 
$mbtn_vytvoritsablonu.Left = "903" 
$mbtn_vytvoritsablonu.Anchor = "Left,Top" 
$mbtn_vytvoritsablonu.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_vytvoritsablonu.Add_Click( {
        
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\icwsc_template.ps1'
           
    })
$MyForm.Controls.Add($mbtn_vytvoritsablonu) 

$mbtn_icwsc = New-Object System.Windows.Forms.Button 
$mbtn_icwsc.Text = "ICWSC script" 
$mbtn_icwsc.Top = "88" 
$mbtn_icwsc.Left = "903" 
$mbtn_icwsc.Anchor = "Left,Top" 
$mbtn_icwsc.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_icwsc.Add_Click( {
        
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\icwsc.ps1'
           
    })
$MyForm.Controls.Add($mbtn_icwsc) 


$mbtn_patchlevel = New-Object System.Windows.Forms.Button 
$mbtn_patchlevel.Text = "Patch level" 
$mbtn_patchlevel.Top = "126" 
$mbtn_patchlevel.Left = "903" 
$mbtn_patchlevel.Anchor = "Left,Top" 
$mbtn_patchlevel.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_patchlevel.Add_Click( {
        $patche = Get-Content "D:\SICZ\avas\AVAS_LuKA\hotfixy.csv" | ConvertFrom-Csv
        #$patche
        $patche | Out-GridView
        #   start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\patche.ps1'
           
    })
$MyForm.Controls.Add($mbtn_patchlevel) 

$mbtn_gui = New-Object System.Windows.Forms.Button 
$mbtn_gui.Text = "Upravit GUI" 
$mbtn_gui.Top = "163" 
$mbtn_gui.Left = "904" 
$mbtn_gui.Anchor = "Left,Top" 
$mbtn_gui.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_gui.Add_Click( {
        
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\editovatgui.ps1'
           
    })

$MyForm.Controls.Add($mbtn_gui) 

$mbtn_sablonaverze = New-Object System.Windows.Forms.Button 
$mbtn_sablonaverze.Text = "Verzovani sablon" 
$mbtn_sablonaverze.Top = "200" 
$mbtn_sablonaverze.Left = "903" 
$mbtn_sablonaverze.Anchor = "Left,Top" 
$mbtn_sablonaverze.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_sablonaverze.Add_Click( {
        
        start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\verzovanisablon.ps1'
           
    })
$MyForm.Controls.Add($mbtn_sablonaverze) 

$mlbl_verzesablony = New-Object System.Windows.Forms.Label 
$mlbl_verzesablony.Text = $json.verzesablony
$mlbl_verzesablony.Top = "17" 
$mlbl_verzesablony.Left = "751" 
$mlbl_verzesablony.Anchor = "Left,Top" 
$mlbl_verzesablony.Size = New-Object System.Drawing.Size(150, 40) 
$MyForm.Controls.Add($mlbl_verzesablony) 
        
$mbtn_nacistjson = New-Object System.Windows.Forms.Button 
$mbtn_nacistjson.Text = "Nacist JSON" 
$mbtn_nacistjson.Top = "230" 
$mbtn_nacistjson.Left = "902" 
$mbtn_nacistjson.Anchor = "Left,Top" 
$mbtn_nacistjson.Size = New-Object System.Drawing.Size(100, 23) 
$mbtn_nacistjson.Add_Click( {
        
        #start powershell.exe -ArgumentList 'D:\SICZ\avas\avas_luka\openfiledialog.ps1'
        $openFileDialog = New-Object windows.forms.openfiledialog   
        $openFileDialog.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()   
        $openFileDialog.title = "Select Settings Configuration File to Import"   
        $openFileDialog.filter = "All files (*.*)| *.*"   
        #$openFileDialog.filter = "PublishSettings Files|*.publishsettings|All Files|*.*" 
        $openFileDialog.ShowHelp = $True   
        Write-Host "Select  Settings File... (see FileOpen Dialog)" -ForegroundColor Green  
        $result = $openFileDialog.ShowDialog()   # Display the Dialog / Wait for user response 
        # in ISE you may have to alt-tab or minimize ISE to see dialog box 
        $result 
        if ($result -eq "OK") {    
            Write-Host "Selected  Settings File:"  -ForegroundColor Green  
            $OpenFileDialog.filename   
            $OpenFileDialog.CheckFileExists 
                    
            # Import-AzurePublishSettingsFile -PublishSettingsFile $openFileDialog.filename  
            # Unremark the above line if you actually want to perform an import of a publish settings file  
            Write-Host "Import Settings File Imported!" -ForegroundColor Green 
                  
        } 
        else { Write-Host "Import Settings File Cancelled!" -ForegroundColor Yellow} 
    })
$MyForm.Controls.Add($mbtn_nacistjson) 
$mlbl_nactenyjson = New-Object System.Windows.Forms.Label 
$mlbl_nactenyjson.Text = "D:\SICZ\hash_luka.json" 
$mlbl_nactenyjson.Top = "235" 
$mlbl_nactenyjson.Left = "723" 
$mlbl_nactenyjson.Anchor = "Left,Top" 
$mlbl_nactenyjson.Size = New-Object System.Drawing.Size(100, 23) 
$MyForm.Controls.Add($mlbl_nactenyjson) 

$mlbl_rootcertifikaty = New-Object System.Windows.Forms.Button 
$mlbl_rootcertifikaty.Text = "Root certifikaty" 
$mlbl_rootcertifikaty.Top = "265" 
$mlbl_rootcertifikaty.Left = "903" 
$mlbl_rootcertifikaty.Anchor = "Left,Top" 
$mlbl_rootcertifikaty.Size = New-Object System.Drawing.Size(100, 23) 
$mlbl_rootcertifikaty.Add_Click( {
        #$json.rootcert | Out-GridView
        $json.Computer_Root_Certificates | Out-GridView
        #start powershell.exe  -ArgumentList 'D:\SICZ\avas\avas_luka\rootcert.ps1' 
         
    })
$MyForm.Controls.Add($mlbl_rootcertifikaty) 

$mLabel1 = New-Object System.Windows.Forms.Label 
$mLabel1.Text="Rozdilne app" 
$mLabel1.Top="64" 
$mLabel1.Left="555" 
$mLabel1.Anchor="Left,Top" 
$mLabel1.Size = New-Object System.Drawing.Size(100,23) 
$MyForm.Controls.Add($mLabel1) 


$mButton1 = New-Object System.Windows.Forms.Button 
$mButton1.Text="Detail - apps" 
$mButton1.Top="63" 
$mButton1.Left="657" 
$mButton1.Anchor="Left,Top" 
$mButton1.Size = New-Object System.Drawing.Size(100,23) 
$mButton1.Add_Click( {
    #$json.rootcert | Out-GridView
    
    start powershell.exe  -ArgumentList 'D:\SICZ\avas\avas_luka\apps.ps1'
    #$appsps= start powershell.exe -ArgumentList "D:\SICZ\avas\avas_luka\apps.ps1"
    $json.installed_apps | Out-GridView
})

$MyForm.ShowDialog()