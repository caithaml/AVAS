gwmi -cl win32_reliabilityRecords -filter "sourcename = 'Microsoft-Windows-WindowsUpdateClient'" |

select @{LABEL = "date";EXPRESSION = {$_.ConvertToDateTime($_.timegenerated)}},

user, productname

Read-Host "Press any key to exit..."
exit