$users = Get-ADGroupMember -identity "secretariaat"

foreach ($user in $users) { 
    $SamAccountName = $user.SamAccountName
    Set-ADUser -Identity $user -Profilepath "\\DC2\Profiles$\$SamAccountName"
}