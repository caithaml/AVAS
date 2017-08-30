#==============================================================================================
# XAML - GUI
#==============================================================================================
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @'
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
<Label Content="Jméno stanice:" HorizontalAlignment="Left" Margin="32.704,60.377,0,0" VerticalAlignment="Top"/>
<Label Content="Aktivace provedena dne:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,93.08,0,0"/>
<Label Content="Tester:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,117.05,0,0"/>
<Label Content="Jméno sítě:;" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="32.704,142,0,0"/>
<Label Content="Jméno uživatele:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="354,60.377,0,0"/>
<Label Content="Kancelář:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="354,93.08,0,0"/>
<Label Content="Číslo zásuvky:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="354,117.05,0,0"/>
<Label Content="Sériové číslo:" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="354,150.01,0,0"/>
<Label Content="Prostor pro chybové hlášky" HorizontalAlignment="Left" Margin="42,227,0,0" VerticalAlignment="Top" Height="61.96" Width="592.317" Background="#FFF97575"/>

</Grid>

</Window>
'@
#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

#===========================================================================
# Form objekty PowerShell
#===========================================================================
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

#===========================================================================
# Akce pro tlačítka
#===========================================================================
$btnExit.Add_Click({$form.Close()}) #tlacitko konec

#####################################################################################
# Skripty a funkcionality - začátek
#####################################################################################
$data = Import-Clixml soubor.xml
Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "XML (*.xml)| *.xml"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

#####################################################################################
# Skripty a funkcionality - konec
#####################################################################################


#===========================================================================
# Zobrazeni formu
#===========================================================================
$Form.ShowDialog() | out-null