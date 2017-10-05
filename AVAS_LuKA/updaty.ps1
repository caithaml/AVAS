gwmi -cl win32_reliabilityRecords -filter "sourcename = 'Microsoft-Windows-WindowsUpdateClient'" |

select @{LABEL = 'date';EXPRESSION = {$_.ConvertToDateTime($_.timegenerated)}},

user, productname
# SIG # Begin signature block
# MIID7QYJKoZIhvcNAQcCoIID3jCCA9oCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUr6Hxs8XiENUBOaT8Jd2/6wTB
# HLGgggIHMIICAzCCAWygAwIBAgIQZDdTxzu4+YFMYeyTtmLtgDANBgkqhkiG9w0B
# AQUFADAcMRowGAYDVQQDDBFMdUthcyBLYXJhYmVjIElDWjAeFw0xNzEwMDIwNzMw
# MzRaFw0yMTEwMDIwMDAwMDBaMBwxGjAYBgNVBAMMEUx1S2FzIEthcmFiZWMgSUNa
# MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCapIWqwo94eQlMVMdxEPR947uo
# w2XCvRla7bI5idyFp4/4voJ15FsYZqldLYIh2O78M+fmH1mb+Rh61E+Bn/NlV88T
# H/H4fygqjDC6YjuTJRVsFp/uosTkDWKkKyp596dtNFoc86ZJ4aRD9pasJ14zXMW0
# UhCNAhR9gaRDT/3UZQIDAQABo0YwRDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNV
# HQ4EFgQUtEk3bGdVsA6tSNyvrPu3dejsd7UwDgYDVR0PAQH/BAQDAgeAMA0GCSqG
# SIb3DQEBBQUAA4GBAFs5K1cObLWgA37VO5OWsF4mCUasA9lOLlxeKIXI1flYjJAr
# Fn9xrSc9jF5u0MmivVzo3W3gWJVMCGmmuvN2X/NVh19XwpNdFrzuFx1MkLEELL6h
# DHeAofdRyRo3ZNer43N0DPKwnhazoL5LrEgOL+SaZAD3pMpRCRBp6Il8uMwkMYIB
# UDCCAUwCAQEwMDAcMRowGAYDVQQDDBFMdUthcyBLYXJhYmVjIElDWgIQZDdTxzu4
# +YFMYeyTtmLtgDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKA
# ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUnX6z8RW+nLx4mRoo6QJkIVxoaikw
# DQYJKoZIhvcNAQEBBQAEgYBiSHGMdy6/X1fW1XPM6pzNJnU2FMD+4JSmNH6Nz1tg
# H+yrIGSaWfr1pAQoy/wJ0ngmb5umk04cAq4t6SSsib6Sl9UIC9zN0/yzHKs51j4E
# bLyfsQ2U7Txx2cD5UjrCtGgbIAWb7g53zKiiaeMUMCldO4Ue31gufoSpB7pD/WvA
# Fw==
# SIG # End signature block
