$Suffix =  "mijnschool.be"
Get-ADForest | Set-ADForest -UPNSuffixes @{add=$Suffix}

Get-ADForest | Format-List UPNSuffixes

$Suffix =  "mijnschool.be"
$LocalUsers = Get-ADUser -Filter {UserPrincipalName -like '*intranet.mijnschool.be'} -Properties UserPrincipalName -ResultSetSize $nul
$LocalUsers | foreach {$newUpn = $_.UserPrincipalName.Replace("intranet.mijnschool.be",$Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn}