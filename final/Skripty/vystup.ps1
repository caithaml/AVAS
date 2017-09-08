$json=gc C:\SICZ\hash_mica.json | ConvertFrom-Json

[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="OS Details" Height="306" Width="525" WindowStartupLocation="CenterScreen" WindowStyle='None' ResizeMode='NoResize'>
    <Grid Margin="0,0,-0.2,0.2">
        <TextBox HorizontalAlignment="Center" Height="23" TextWrapping="Wrap" Text="Operating System Details" VerticalAlignment="Top" Width="525" Margin="0,-1,-0.2,0" TextAlignment="Center" Foreground="White" Background="#FF98D6EB"/>
        <Label Content="Hostname" HorizontalAlignment="Left" Margin="0,27,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="Operating System Name" HorizontalAlignment="Left" Margin="0,62,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="RAM Memory" HorizontalAlignment="Left" Margin="0,97,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="USer" HorizontalAlignment="Left" Margin="0,132,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="Windows Directory" HorizontalAlignment="Left" Margin="0,167,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="Windows Version" HorizontalAlignment="Left" Margin="0,202,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Label Content="Region" HorizontalAlignment="Left" Margin="0,237,0,0" VerticalAlignment="Top" Height="30" Width="170" Background="#FF98D6EB" Foreground="White"/>
        <Button Name="btnExit" Content="Exit" HorizontalAlignment="Left" Margin="0,272,0,0" VerticalAlignment="Top" Width="525" Height="34" BorderThickness="0"/>
        <TextBox Name="txtHostName" HorizontalAlignment="Left" Height="30" Margin="175,27,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtOSName" HorizontalAlignment="Left" Height="30" Margin="175,62,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtAvailableMemory" HorizontalAlignment="Left" Height="30" Margin="175,97,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtOSArchitecture" HorizontalAlignment="Left" Height="30" Margin="175,132,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtWindowsDirectory" HorizontalAlignment="Left" Height="30" Margin="175,167,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtWindowsVersion" HorizontalAlignment="Left" Height="30" Margin="175,202,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        <TextBox Name="txtSystemDrive" HorizontalAlignment="Left" Height="30" Margin="175,236,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="343" IsEnabled="False"/>
        
    
        </Grid>
</Window>
'@
#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

#===========================================================================
# Add events to Form Objects
#===========================================================================
$btnExit.Add_Click({$form.Close()})

#===========================================================================
# Stores WMI values in WMI Object from Win32_Operating System Class
#===========================================================================
$oWMIOS = $json.OS

#===========================================================================
# Links WMI Object Values to XAML Form Fields
#===========================================================================
$txtHostName.Text = $json.ComputerName

#Formats and displays OS name
$aOSName = $json.OS
$txtOSName.Text = $json.OS

#Formats and displays available memory
$sAvailableMemory = $json.RAM_Total
$txtAvailableMemory.Text = $sAvailableMemory

#Displays OS Architecture
$txtOSArchitecture.Text = $json.User

#Displays Windows Directory
$txtWindowsDirectory.Text = $json.SYS_Dir

#Displays Version
$txtWindowsVersion.Text = $json.OS_Build

#Displays System Drive
$txtSystemDrive.Text = $json.Country

#===========================================================================
# Shows the form
#===========================================================================
$Form.ShowDialog() | out-null