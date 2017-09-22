Start-Transcript -Path "./transcriptopenfile$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"

Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "JSON (*.json)| *.json"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
$inputfile = Get-FileName "C:\SICZ"
$inputdata = get-content $inputfile
$inputdata
Read-Host "zmackni neco"