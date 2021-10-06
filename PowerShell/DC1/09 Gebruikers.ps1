Import-Module ActiveDirectory
$ADUsers = Import-Csv C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\UserAccounts.csv -Delimiter ";"
foreach ($User in $ADUsers) {
    $Name = $User.Name
    $SamAccountName = $User.SamAccountName
    $GivenName = $User.GivenName
    $Surname = $User.Surname
    $DisplayName = $User.DisplayName
    $AccountPassword = $User.AccountPassword
    $HomeDrive = $User.HomeDrive
    $HomeDirectory = $User.HomeDirectory
    $ScriptPath = $User.ScriptPath
    $Path = $User.Path
    New-ADUser `
        -Name $DisplayName `
        -SamAccountName $Name `
        -GivenName $Description `
        -Surname $Path `
        -DisplayName $DisplayName `
        -AccountPassword (ConvertTo-SecureString $AccountPassword -AsPlainText -Force) `
        -HomeDrive $HomeDrive `
        -HomeDirectory $HomeDirectory `
        -ScriptPath $ScriptPath `
        -Path $Path
    Write-Host "The User $Name is created." -ForegroundColor Cyan
}