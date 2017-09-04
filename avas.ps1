Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
Write-Host -Object "$(Get-Date) - Nacitam GUI"

Write-Host -Object "$(Get-Date) -Nacitani .ini konfiguracniho souboru"
$scriptpath = $MyInvocation.MyCommand.Path | Split-Path
####################################################################################
##Nacteni konfigurace ze souboru .ini
####################################################################################
if (!(Test-Path -Path "$scriptpath\soubor.ini"))
{
Write-Host -Object "$(Get-Date) - Nelze najit soubor $scriptpath\soubor.ini `r"
#Stop-Transcript
exit
#Write-Host "Chyba : nebyl nalezen ini soubor"
}

Get-Content -Path "$scriptpath\soubor.ini" | ForEach-Object -Begin {
$set = @{}
} -Process {
$k = [regex]::split($_,'=')
if(($k[0].CompareTo('') -ne 0) -and ($k[0].StartsWith('#') -ne $true))
{
$set.Add($k[0], $k[1])
}
}
if($set.debug -eq '1')
{
$DebugPreference = 'Continue'
}
else
{
$DebugPreference = 'SilentlyContinue'
}
Write-Host -Object "$(Get-Date) Pokracuje zpracovani dalsich prikazu, soubor ini byl nacten"

#==============================================================================================
# XAML - GUI
#==============================================================================================
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @'
<Window 
xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns:local="clr-namespace:AVAS_GUI"
 WindowStartupLocation="CenterScreen"
Title="AVAS" Height="800" Width="800">
<Grid>
<Label Content="Nazev stanice:" HorizontalAlignment="Left" Margin="32.704,60.377,0,0" VerticalAlignment="Top"/>
<Label Content="Aktivace provedena dne:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,93.08,0,0"/>
<Label Content="Tester:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,124.05,0,0"/>
<Label Content="Nazev site:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,153,0,0"/>
<Label Content="Jmeno uzivatele:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="467,60.377,0,0"/>
<Label Content="Kancelar:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="467,93.08,0,0"/>
<Label Content="Cislo zasuvky:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="467,117.05,0,0"/>
<Label Content="Seriove cislo:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="467,150.01,0,0"/>
<Label Content="" HorizontalAlignment="Left" Margin="42,211,0,0" VerticalAlignment="Top" Height="78" Width="678" Background="#FFF97575" Name="label_chyboveokno"/>
<Label Content="Integrita datoveho souboru" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,321,0,0"/>
<Label Content="Prostredi" HorizontalAlignment="Left" Height="30" Margin="32.704,370,0,0" VerticalAlignment="Top" Width="155.293"/>
<Label Content="Stav antiviru" HorizontalAlignment="Left" Height="31" Margin="33,405,0,0" VerticalAlignment="Top" Width="145.997"/>
<Label Content="Scripty" HorizontalAlignment="Left" Height="35" Margin="33,451,0,0" Width="137.881" VerticalAlignment="Top"/>
<Label Content="NT syslog" HorizontalAlignment="Left" Height="31" Margin="31,492,0,0" Width="69.251" VerticalAlignment="Top"/>
<Label Content="Operacni system" HorizontalAlignment="Left" Height="36" Margin="30,523,0,0" Width="109.091" VerticalAlignment="Top"/>
<Label Content="Protect" HorizontalAlignment="Left" Height="41" Margin="32,568,0,0" Width="109.091" VerticalAlignment="Top"/>
<Label Content="Logy" HorizontalAlignment="Left" Height="29" Margin="33,608,0,0" Width="102.091" VerticalAlignment="Top"/>
<Label Content="Zaplneni disku" HorizontalAlignment="Left" Height="28" Margin="33,662,0,0" Width="102.091" VerticalAlignment="Top"/>
<Label Content="Aplikace GP" HorizontalAlignment="Left" Height="31" Margin="35,699,0,0" Width="109.091" VerticalAlignment="Top"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="233.091,60.377,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_nazevstanice"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="231.881,96.08,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_aktivaceprovedenadne"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="230.251,157.01,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_nazevsite"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="231.251,127.04,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_tester"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,60.377,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_nazevuzivatele"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,93.08,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_kancelar"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,124.04,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_cislozasuvky"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,155,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_seriovecislo"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,321,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_integritadatovehosouboru"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,370,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_prostredi"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,405,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_stavantiviru"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,452,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_scripty"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,487,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_ntsyslog"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,523,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_operacnisystem" Name="txtbox_operacnisystem"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,572.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_protect"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,614.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_logy"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,660.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_zaplnenidisku"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,700.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Name="txtbox_aplikacegp"/>
</Grid>
</Window>
'@
#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host -Object "$(Get-Date) Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

#===========================================================================
# Form objekty PowerShell
#===========================================================================
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}
Write-Host -Object "$(Get-Date) GUI bylo nacteno"


#####################################################################################
# Skripty a funkcionality - začátek
#####################################################################################
Write-Host -Object "$(Get-Date) Probiha import cli-xml"
$data = gc C:\SICZ\hash.json

$oWMIOS = Get-WmiObject win32_OperatingSystem
#$txtHostName.Text = $oWMIOS.PSComputerName
Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem.Text=$data.OS

Write-Host -Object "$(Get-Date) txtbox_nazevstanice"
$txtbox_nazevstanice

Write-Host -Object "$(Get-Date) txtbox_aktivaceprovedenadne"
$txtbox_aktivaceprovedenadne

Write-Host -Object "$(Get-Date) txtbox_nazevsite"
$txtbox_nazevsite

Write-Host -Object "$(Get-Date) txtbox_tester"
$txtbox_tester

Write-Host -Object "$(Get-Date) txtbox_nazevuzivatele"
$txtbox_nazevuzivatele

Write-Host -Object "$(Get-Date) txtbox_kancelar"
$txtbox_kancelar

Write-Host -Object "$(Get-Date) txtbox_cislozasuvky"
$txtbox_cislozasuvky

Write-Host -Object "$(Get-Date) txtbox_seriovecislo"
$txtbox_seriovecislo

Write-Host -Object "$(Get-Date) txtbox_integritadatovehosouboru"
$txtbox_integritadatovehosouboru

Write-Host -Object "$(Get-Date) txtbox_prostredi"
$txtbox_prostredi

Write-Host -Object "$(Get-Date) txtbox_stavantiviru"
$txtbox_stavantiviru

Write-Host -Object "$(Get-Date) txtbox_scripty"
$txtbox_scripty

Write-Host -Object "$(Get-Date) txtbox_ntsyslog"
$txtbox_ntsyslog

Write-Host -Object "$(Get-Date) txtbox_operacnisystem"
$txtbox_operacnisystem

Write-Host -Object "$(Get-Date) txtbox_protect"
$txtbox_protect

Write-Host -Object "$(Get-Date) txtbox_logy"
$txtbox_logy

Write-Host -Object "$(Get-Date) txtbox_zaplnenidisku"
$txtbox_zaplnenidisku

Write-Host -Object "$(Get-Date) txtbox_aplikacegp"
$txtbox_aplikacegp

Write-Host -Object "$(Get-Date) label_chyboveokno"
$label_chyboveokno

Write-Host -Object "$(Get-Date) nacteni aplikaci"
$label_aplikace=(Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)

#####################################################################################
# Skripty a funkcionality - konec
#####################################################################################


#===========================================================================
# Zobrazeni formu
#===========================================================================
Write-Host -Object "$(Get-Date) Okno aplikace bylo nacteno"
$Form.ShowDialog() | out-null
Write-Host -Object "$(Get-Date) Okno aplikace bylo zavreno";