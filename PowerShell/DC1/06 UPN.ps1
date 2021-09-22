$Suffix =  "mijnschool.be"

Get-ADForest | Set-ADForest -UPNSuffixes @{add=$Suffix}

Get-ADForest | Format-List UPNSuffixes


$LocalUsers = Get-ADUser -Filter {UserPrincipalName -like '*exoip.local'} -Properties UserPrincipalName -ResultSetSize $nul
$LocalUsers | foreach {$newUpn = $_.UserPrincipalName.Replace("exoip.local","exoip.com"); $_ | Set-ADUser -UserPrincipalName $newUpn}