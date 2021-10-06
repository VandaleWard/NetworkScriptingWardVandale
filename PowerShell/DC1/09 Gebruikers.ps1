Import-Module ActiveDirectory
$ADUsers = Import-Csv C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\UserAccounts.csv -Delimiter ";"

$UPN = "mijnschool.be"

foreach ($User in $ADUsers) {

    $Username = $User.Name.ToLower().replace(' ' , '""')
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
            -UserPrincipalName "$username@$UPN" `
            -Name $Name `
            -SamAccountName $SamAccountName `
            -GivenName $GivenName `
            -Surname $Surname `
            -DisplayName $DisplayName `
            -AccountPassword (ConvertTo-secureString $AccountPassword -AsPlainText -Force) `
            -HomeDrive $HomeDrive `
            -HomeDirectory $HomeDirectory `
            -ScriptPath $ScriptPath `
            -Path $Path `
            -Enabled $True

        Write-Host "The user account $Name is created." -ForegroundColor Cyan
}