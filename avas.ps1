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
Title="MainWindow" Height="350" Width="525">
<Grid>

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