#requires -Version 3.0
## ODSTRANIT !!!! - debug
Write-Verbose -Message "$(Get-Date) - Obsah souboru: ($json)"
Start-Transcript -Path "./transcriptAVAS$(Get-Date -Format yyyy-MM-dd-hh-mm-ss).txt"
## ODSTRANIT !!!! - debug

$transcriptname              = Get-Date -UFormat 'AVAS_%Y_%m_%d'
Start-Transcript -Path "./$transcriptname.log"

Write-Verbose -Message "$(Get-Date) - Nacitani json konfiguracniho souboru"

Write-Verbose -Message "$(Get-Date) - Nacitani json konfiguracniho souboru"
Function Get-FileName($initialDirectory)
{
  $null                            = [System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')
    
  $OpenFileDialog                  = New-Object -TypeName System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.filter           = 'JSON (*.json)| *.json'
  $null                            = $OpenFileDialog.ShowDialog()
  $OpenFileDialog.filename
}
$inputfile                   = Get-FileName -initialDirectory 'D:\SICZ\avas\' #defaultni adresar
$inputdata                   = Get-Content -Path $inputfile

$json                        = $inputdata | ConvertFrom-Json
$jsondef                     = Get-Content -Path D:\SICZ\hash_luka.json | ConvertFrom-Json
