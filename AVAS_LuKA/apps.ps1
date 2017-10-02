#$json = Get-Content d:\SICZ\hash_mica.json | ConvertFrom-Json
function appdiff
{
  $app = Get-Content -Path D:\SICZ\app_default.json | ConvertFrom-Json  
  $app2 = Get-Content -Path D:\SICZ\app.json | ConvertFrom-Json  

  $Diff = ForEach ($line1 in $app)   
  {
    ForEach ($line2 in $app2)   
    {
      IF ($line1.DisplayName -eq $line2.DisplayName)   # If stejny nazev
      {
        IF ($line1.DisplayVersion -ne $line2.DisplayVersion)   # If jina verze
        {        
          New-Object -TypeName PSObject -Property @{
            DisplayName    = $line1.DisplayName
            DisplayVersion = $line1.DisplayVersion
            Publisher      = $line1.Publisher
          }  
        }
      }
    }                                                
  }
    
  $Diff | Select-Object -Property DisplayName, DisplayVersion, Publisher 
  $Diff
}
appdiff

$apps = appdiff
$apps | Out-GridView

$line2 | Out-GridView

