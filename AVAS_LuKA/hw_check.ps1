[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.text = "Hardware Checks"
$Form.Size = New-Object System.Drawing.Size(600,600)

############################################## Start functions

function checkinfo {
$HostName=$InputBox.text;
$newLine = [System.Environment]::NewLine

$computerSystem = get-wmiobject Win32_ComputerSystem -ComputerName $HostName
$computerBIOS = get-wmiobject Win32_BIOS -ComputerName $HostName
$computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerOSB = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerBLD = get-wmiobject Win32_OperatingSystem -ComputerName $HostName
$computerCPU = get-wmiobject Win32_Processor -ComputerName $HostName
$computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $HostName -Filter "DeviceID='C:'"
write-host "System Information for: " $computerSystem.Name
$Man = $computerSystem.Manufacturer
$Mod = $computerSystem.Model -replace "32373A0", "M92p" -replace "3237EF9", "M92p" -replace "3167BC8", "M71e" -replace "10A4S00R0D", "M93" -replace "3664AK9", "M72e" -replace "3267B69", "M72e Tiny" -replace "0833AL2", "M70e"
$Ser = $computerBIOS.SerialNumber
$CPUs = $ComputerSystem.NumberOfProcessors
$Cores = $ComputerSystem.NumberOfLogicalProcessors
$HDD = "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
$RAM = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
$OS = $computerOS.caption -replace "Microsoft Windows 7 Enterprise , Service Pack: 1", "Win 7"
$OSB = $computerOSB.ConvertToDateTime(($computerOSB).InstallDate)
$Usr = $computerSystem.UserName
$Check=$Man, $newline, $Mod, $newline, $Ser, $newline, $CPUs,$newline, $Cores, $newline, $HDD, $newline, $RAM, $newline, $OS, $newline, $OSB, $newline, $Urs
$outputBox.text=$Check
}
############################################## end functions

############################################## Start group boxes

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(250,20)
$groupBox.size = New-Object System.Drawing.Size(130,40)
$groupBox.text = "Hardware Info:"
$Form.Controls.Add($groupBox)

############################################## end group boxes

$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = New-Object System.Drawing.Size(250,70)
$groupBox1.size = New-Object System.Drawing.Size(130,100)
$groupBox1.text = "Checks by OS:"
$Form.Controls.Add($groupBox1)

############################################## end group boxes

############################################## Start check boxes

$Hardware = New-Object System.Windows.Forms.checkbox
$Hardware.Location = New-Object System.Drawing.Size(15,20)
$Hardware.Size = New-Object System.Drawing.Size(100,15)
$Hardware.Checked = $true
$Hardware.Text = "Hardware"
$groupBox.Controls.Add($Hardware)

############################################## end check boxes

############################################## Start radio buttons

$RadioButton1 = New-Object System.Windows.Forms.RadioButton
$RadioButton1.Location = new-object System.Drawing.Point(15,15)
$RadioButton1.size = New-Object System.Drawing.Size(80,20)
$RadioButton1.Text = "Win 7"
$groupBox1.Controls.Add($RadioButton1)

$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton2.Location = new-object System.Drawing.Point(15,45)
$RadioButton2.size = New-Object System.Drawing.Size(80,20)
$RadioButton2.Text = "XP"
$groupBox1.Controls.Add($RadioButton2)

$RadioButton3 = New-Object System.Windows.Forms.RadioButton
$RadioButton3.Location = new-object System.Drawing.Point(15,75)
$RadioButton3.size = New-Object System.Drawing.Size(80,20)
$RadioButton3.Text = "Thin Client"
$groupBox1.Controls.Add($RadioButton3)

############################################## end radio buttons

############################################## Start text fields

$InputBox = New-Object System.Windows.Forms.TextBox
$InputBox.Location = New-Object System.Drawing.Size(20,50)
$InputBox.Size = New-Object System.Drawing.Size(150,20)
$Form.Controls.Add($InputBox)

$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Location = New-Object System.Drawing.Size(10,200)
$outputBox.Size = New-Object System.Drawing.Size(565,200)
$outputBox.MultiLine = $True
$outputBox.ScrollBars = "Vertical"
$Form.Controls.Add($outputBox)

############################################## end text fields

############################################## Start buttons

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(450,30)
$Button.Size = New-Object System.Drawing.Size(75,75)
$Button.Text = "Check"
$Button.Add_Click({checkinfo})
$Form.Controls.Add($Button)

############################################## end buttons

############################################## Start buttons

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Size(450,520)
$cancelButton.Size = New-Object System.Drawing.Size(75,25)
$cancelButton.Text = "Close"
$cancelButton.Add_Click({ $form.Tag = $null; $form.Close() })
$Form.Controls.Add($cancelButton)

############################################## end buttons

$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

