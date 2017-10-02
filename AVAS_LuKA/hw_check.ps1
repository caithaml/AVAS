[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')
[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

$Form = New-Object -TypeName System.Windows.Forms.Form
$Form.text = 'Hardware Checks'
$Form.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (600, 600)

############################################## Start functions

function checkinfo 
{
  $HostName = $InputBox.text
  $newLine = [System.Environment]::NewLine

  $computerSystem = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $HostName
  $computerBIOS = Get-WmiObject -Class Win32_BIOS -ComputerName $HostName
  $computerOS = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $HostName
  $computerOSB = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $HostName
  $computerBLD = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $HostName
  $computerCPU = Get-WmiObject -Class Win32_Processor -ComputerName $HostName
  $computerHDD = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $HostName -Filter "DeviceID='C:'"
  Write-Host 'System Information for: ' $computerSystem.Name
  $Man = $computerSystem.Manufacturer
  $Mod = $computerSystem.Model -replace '32373A0', 'M92p' -replace '3237EF9', 'M92p' -replace '3167BC8', 'M71e' -replace '10A4S00R0D', 'M93' -replace '3664AK9', 'M72e' -replace '3267B69', 'M72e Tiny' -replace '0833AL2', 'M70e'
  $Ser = $computerBIOS.SerialNumber
  $CPUs = $computerSystem.NumberOfProcessors
  $Cores = $computerSystem.NumberOfLogicalProcessors
  $HDD = '{0:N2}' -f ($computerHDD.Size/1GB) + 'GB'
  $RAM = '{0:N2}' -f ($computerSystem.TotalPhysicalMemory/1GB) + 'GB'
  $OS = $computerOS.caption -replace 'Microsoft Windows 7 Enterprise , Service Pack: 1', 'Win 7'
  $OSB = $computerOSB.ConvertToDateTime(($computerOSB).InstallDate)
  $Usr = $computerSystem.UserName
  $Check = $Man, $newLine, $Mod, $newLine, $Ser, $newLine, $CPUs, $newLine, $Cores, $newLine, $HDD, $newLine, $RAM, $newLine, $OS, $newLine, $OSB, $newLine, $Urs
  $outputBox.text = $Check
}
############################################## end functions

############################################## Start group boxes

$groupBox = New-Object -TypeName System.Windows.Forms.GroupBox
$groupBox.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (250, 20)
$groupBox.size = New-Object -TypeName System.Drawing.Size -ArgumentList (130, 40)
$groupBox.text = 'Hardware Info:'
$Form.Controls.Add($groupBox)

############################################## end group boxes

$groupBox1 = New-Object -TypeName System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (250, 70)
$groupBox1.size = New-Object -TypeName System.Drawing.Size -ArgumentList (130, 100)
$groupBox1.text = 'Checks by OS:'
$Form.Controls.Add($groupBox1)

############################################## end group boxes

############################################## Start check boxes

$Hardware = New-Object -TypeName System.Windows.Forms.checkbox
$Hardware.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (15, 20)
$Hardware.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (100, 15)
$Hardware.Checked = $true
$Hardware.Text = 'Hardware'
$groupBox.Controls.Add($Hardware)

############################################## end check boxes

############################################## Start radio buttons

$RadioButton1 = New-Object -TypeName System.Windows.Forms.RadioButton
$RadioButton1.Location = New-Object -TypeName System.Drawing.Point -ArgumentList (15, 15)
$RadioButton1.size = New-Object -TypeName System.Drawing.Size -ArgumentList (80, 20)
$RadioButton1.Text = 'Win 7'
$groupBox1.Controls.Add($RadioButton1)

$RadioButton2 = New-Object -TypeName System.Windows.Forms.RadioButton
$RadioButton2.Location = New-Object -TypeName System.Drawing.Point -ArgumentList (15, 45)
$RadioButton2.size = New-Object -TypeName System.Drawing.Size -ArgumentList (80, 20)
$RadioButton2.Text = 'XP'
$groupBox1.Controls.Add($RadioButton2)

$RadioButton3 = New-Object -TypeName System.Windows.Forms.RadioButton
$RadioButton3.Location = New-Object -TypeName System.Drawing.Point -ArgumentList (15, 75)
$RadioButton3.size = New-Object -TypeName System.Drawing.Size -ArgumentList (80, 20)
$RadioButton3.Text = 'Thin Client'
$groupBox1.Controls.Add($RadioButton3)

############################################## end radio buttons

############################################## Start text fields

$InputBox = New-Object -TypeName System.Windows.Forms.TextBox
$InputBox.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (20, 50)
$InputBox.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (150, 20)
$Form.Controls.Add($InputBox)

$outputBox = New-Object -TypeName System.Windows.Forms.TextBox
$outputBox.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (10, 200)
$outputBox.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (565, 200)
$outputBox.MultiLine = $true
$outputBox.ScrollBars = 'Vertical'
$Form.Controls.Add($outputBox)

############################################## end text fields

############################################## Start buttons

$Button = New-Object -TypeName System.Windows.Forms.Button
$Button.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (450, 30)
$Button.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (75, 75)
$Button.Text = 'Check'
$Button.Add_Click({
    checkinfo
})
$Form.Controls.Add($Button)

############################################## end buttons

############################################## Start buttons

$cancelButton = New-Object -TypeName System.Windows.Forms.Button
$cancelButton.Location = New-Object -TypeName System.Drawing.Size -ArgumentList (450, 520)
$cancelButton.Size = New-Object -TypeName System.Drawing.Size -ArgumentList (75, 25)
$cancelButton.Text = 'Close'
$cancelButton.Add_Click({
    $Form.Tag = $null
    $Form.Close()
})
$Form.Controls.Add($cancelButton)

############################################## end buttons

$Form.Add_Shown({
    $Form.Activate()
})
[void] $Form.ShowDialog()

