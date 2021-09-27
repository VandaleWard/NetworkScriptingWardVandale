Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools -restart


$dnsArray = "192.168.1.2","192.168.1.3"
$macPrinter = "b8-e9-37-3e-55-86"
Add-DhcpServerInDC -DnsName "DC1.intranet.mijnschool.be" -IPAddress 192.168.1.1
Add-DhcpServerV4Scope -Name "Kortrijk" -StartRange 192.168.1.0 -EndRange 192.168.1.255 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -DnsServer $dnsArray -Router 192.168.1.1
Add-Dhcpserverv4ExclusionRange -ScopeId 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.11 -ClientId $macPrinter -Description "Reservation for Printer"

Add-DhcpServerV4Scope -Name "Brugge" -StartRange 192.168.2.0 -EndRange 192.168.2.255 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -DnsServer $dnsArray -Router 192.168.2.1
Add-Dhcpserverv4ExclusionRange -ScopeId 192.168.2.0 -StartRange 192.168.2.1 -EndRange 192.168.2.10
Restart-service dhcpserver