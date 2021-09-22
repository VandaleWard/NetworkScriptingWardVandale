$Suffix =  "mijnschool.be"

Get-ADForest | Set-ADForest -UPNSuffixes @{add=$Suffix}

Get-ADForest | Format-List UPNSuffixes