Import-Module ActiveDirectory
$GroupMembers = Import-Csv C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\GroupMembers.csv -Delimiter ";"

ForEach($Mem In $GroupMembers)
{
    $Member = $Mem.Member
    $Identity = $Mem.Identity

    Write-Host "Adding $Member to $Identity" -ForegroundColor Green

    $CreateGroup = Add-ADGroupMember `
        -Identity $Identity `
        -Members $Member
}