#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="AVAS_GUI.MainWindow"
xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
xmlns:local="clr-namespace:AVAS_GUI"
mc:Ignorable="d"
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
<Label Content="" HorizontalAlignment="Left" Margin="42,211,0,0" VerticalAlignment="Top" Height="78" Width="678" Background="#FFF97575" Uid="label_chyboveokno" AutomationProperties.Name="label_chybyvypis"/>
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
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="233.091,60.377,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_nazevstanice" AutomationProperties.Name="txtbox_nazevstanice"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="231.881,96.08,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_akitvaceprovedenadne" AutomationProperties.Name="txtbox_datumaktivace"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="230.251,157.01,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_nazevsite" AutomationProperties.Name="txtbox_nazevsite"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="231.251,127.04,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_tester" AutomationProperties.Name="txtbox_tester"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,60.377,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_nazevuzivatele" AutomationProperties.Name="txtbox_uzivatel"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,93.08,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_kancelar" AutomationProperties.Name="txtbox_kancelar"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,124.04,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_cislozasuvky" AutomationProperties.Name="txtbox_cislozasuvky"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="585.251,155,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_seriovecslo" AutomationProperties.Name="txtbox_serioveciso"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,321,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_integritadatovehosouboru" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_integritadatovehosouboru"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,370,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_prostredi" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_protredi"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,405,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_stavantiviru" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_stavantiviru"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,452,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_scripty" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_scripty"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,487,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_ntsyslog" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_ntsyslog"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,523,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_operacnisystem" IsReadOnlyCaretVisible="True" TextChanged="TextBox_TextChanged" AutomationProperties.Name="txtbox_operacniystem"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,572.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_protect" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_protect"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,614.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_logy" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_logy"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,660.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_zaplnenidisku" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_zaplnenidisku"/>
<TextBox HorizontalAlignment="Left" Height="25.96" Margin="270.251,700.05,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="134.909" Uid="txtbox_aplikacegp" IsReadOnlyCaretVisible="True" AutomationProperties.Name="txtbox_aplikacegp"/>
</Grid>

</Window>
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================
 
#Sample entry of how to add data to a field
 
#$vmpicklistView.items.Add([pscustomobject]@{'VMName'=($_).Name;Status=$_.Status;Other="Yes"})
 
#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan
'$Form.ShowDialog() | out-null'