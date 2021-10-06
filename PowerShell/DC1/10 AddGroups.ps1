Import-Module ActiveDirectory
$AddGroups = Import-Csv -Path "C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\Groups.csv" -Delimiter ";"

ForEach($Group In $AddGroups)
{
    $Name = $Group.Name
    $DisplayName = $Group.DisplayName
    $Path = $Group.Path
    $GroupScope = $Group.GroupScope
    $GroupCategory = $Group.GroupCategory
    $Desciption = $Group.Description

    Write-Host "Creating Group $Name" -ForegroundColor Green

    $CreateGroup = New-ADGroup `
        -Name $Name `
        -DisplayName $DisplayName `
        -Path $Path `
        -GroupScope $GroupScope `
        -GroupCategory $GroupCategory `
        -Description $Desciption

}