Import-Module ActiveDirectory
$ADOUs = Import-Csv C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\OUs.csv -Delimiter ";"
foreach ($OU in $ADOUs) {
    $DisplayName = $OU.DisplayName
    $Name = $OU.Name
    $Description = $OU.Description
    $Path = $OU.Path
    New-ADOrganizationalUnit `
        -DisplayName $DisplayName `
        -Name $Name `
        -Description $Description `
        -Path $Path
    Write-Host "The OU $Name is created." -ForegroundColor Cyan
}