$Suffix =  "mijnschool.be" # Var of new UPN
Get-ADForest | Set-ADForest -UPNSuffixes @{add=$Suffix} # Adding the UPN Suffix to the domain

Get-ADForest | Format-List UPNSuffixes # Show the UPN Suffixes

$Suffix =  "mijnschool.be" # Var of new UPN
$LocalUsers = Get-ADUser -Filter {UserPrincipalName -like '*intranet.mijnschool.be'} -Properties UserPrincipalName -ResultSetSize $nul #Getting all users that has the original, old, UPN Suffix
$LocalUsers | foreach {$newUpn = $_.UserPrincipalName.Replace("intranet.mijnschool.be",$Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn} # Changing the users with old suffix to new one