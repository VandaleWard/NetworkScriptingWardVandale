$users = Get-ADGroupMember -identity "secretariaat" #Getting Users in group Secretariaat

foreach ($user in $users) { 
    $SamAccountName = $user.SamAccountName #Getting the AccountName to make the Profile Path
    Set-ADUser -Identity $user -Profilepath "\\DC2\Profiles$\$SamAccountName" #Adding the profile path to the roaming profile
}