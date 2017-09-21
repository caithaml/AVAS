Start-Transcript -Path "./transcript$(get-date -f yyyy-MM-dd-hh-mm-ss).txt"
Write-Host -Object "$(1..50000 | % {Set-Variable -Name MaximumHistoryCount -Value $_ })"