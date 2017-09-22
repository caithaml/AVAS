$openFileDialog = New-Object windows.forms.openfiledialog   
$openFileDialog.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()   
$openFileDialog.title = "Select JSON Configuration File to Import"   
$openFileDialog.filter = "All files (*.*)| *.*"   
$openFileDialog.filter = "JSON|*.json|All Files|*.*" 
$openFileDialog.ShowHelp = $True   
Write-Host "Select Downloaded Settings File... (see FileOpen Dialog)" -ForegroundColor Green  
$result = $openFileDialog.ShowDialog()   # Display the Dialog / Wait for user response 
# in ISE you may have to alt-tab or minimize ISE to see dialog box 
$result 
if($result -eq "OK")    {    
        Write-Host "Selected Downloaded Settings File:"  -ForegroundColor Green  
        $OpenFileDialog.filename   
        # $OpenFileDialog.CheckFileExists 
         
        # Import-AzurePublishSettingsFile -PublishSettingsFile $openFileDialog.filename  
        # Unremark the above line if you actually want to perform an import of a publish settings file  
        Write-Host "Import Settings File Imported!" -ForegroundColor Green 
    } 
    else { Write-Host "Import Settings File Cancelled!" -ForegroundColor Yellow} 