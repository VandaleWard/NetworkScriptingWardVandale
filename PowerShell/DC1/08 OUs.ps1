Import-Module ActiveDirectory # Using the Active Directory module
$ADOUs = Import-Csv C:\Users\Administrator\Desktop\NetworkScriptingWardVandale\PowerShell\DC1\FILES\OUs.csv -Delimiter ";" # Reading our CSV file with the ; as delimiter
foreach ($OU in $ADOUs) { # Loop for each record in the CSV
    $DisplayName = $OU.DisplayName # Var that will get the DisplayName
    $Name = $OU.Name # Var that will get the Name
    $Description = $OU.Description # Var that will get the Description
    $Path = $OU.Path # Var that will get the path

    # Creating a new OU with the vars included
    New-ADOrganizationalUnit `
        -DisplayName $DisplayName `
        -Name $Name `
        -Description $Description `
        -Path $Path
    Write-Host "The OU $Name is created." -ForegroundColor Cyan # Telling the user the OU has been created
}