$s = New-PSSession -ComputerName "DC2" -Credential(Get-Credential)

Invoke-Command -Session $s -ScriptBlock {
    $Domain = "intranet.mijnschool.be"
    $Site = "Kortrijk"
    $Login = "intranet\administrator"
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
    Install-ADDSDomainController -CreateDnsDelegation:$false -DatabasePath 'C:\Windows\NTDS' -DomainName $Domain -InstallDns:$true -LogPath 'C:\Windows\NTDS' -NoGlobalCatalog:$false -SiteName $Site -SysvolPath 'C:\Windows\SYSVOL' -NoRebootOnCompletion:$true -Force:$true -Credential (Get-Credential $Login)
    Restart-Computer
}

$s = New-PSSession -ComputerName "DC2" -Credential(Get-Credential)

Invoke-Command -Session $s -ScriptBlock {
 #dns aanpassen
    $NetworkID = "192.168.1.0/24"


    $IP = "192.168.1.3"
    $MaskBits = 24
    $Gateway = "192.168.1.1"
    $IPType = "IPv4"

    $dns1 = "192.168.1.3"
    $dns2 = "192.168.1.2"

    # Retrieve the network adapter that you want to configure
    $adapter = Get-NetAdapter | where-object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
    # Remove any existing IP, gateway from our ipv4 adapter
    If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
     $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
    }
    If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
     $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
    }
     # Configure the IP address and default gateway
    $adapter | New-NetIPAddress `
     -AddressFamily $IPType `
     -IPAddress $IP `
     -PrefixLength $MaskBits `
     -DefaultGateway $Gateway
    # change dns
    $adapter | set-DnsClientServerAddress -ServerAddresses ($dns1 ,$dns2)   
}