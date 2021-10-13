$s = New-PSSession -ComputerName "DC2" -Credential "INTRANET\Administrator" #Connecting to Remote PS on DC2

Invoke-Command -Session $s -ScriptBlock { # Sending commands to the remote PS session
    $PrimaryDHCPServer = "dc1.intranet.mijnschool.be"
    $dnsName2 = "dc2.intranet.mijnschool.be"
    $scope = "192.168.1.0"


    Install-WindowsFeature -Name DHCP -IncludeManagementTools # Installing DHCP
    Add-DhcpServerInDC -IPAddress 192.168.1.3 -DnsName $dnsName2 # Configuring the DHCP Server on Dc2
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2 # Removing Post-Installation Warning in Server Manager
    Add-DhcpServerv4Failover -ComputerName $PrimaryDHCPServer -Name "SFO-SIN-Failover" -PartnerServer $dnsName2 -ScopeId $scope -SharedSecret "P@ssw0rd" # Creating a Failover to the DHCP Server on DC1
}