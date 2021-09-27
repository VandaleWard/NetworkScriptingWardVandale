Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools -Restart


$dnsArray = "192.168.1.2","192.168.1.3"
$macPrinter = "b8-e9-37-3e-55-86"
Add-DhcpServerInDC -DnsName "DC1.intranet.mijnschool.be" -IPAddress 192.168.1.2
Add-DhcpServerV4Scope -Name "Kortrijk" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -DnsServer $dnsArray -Router 192.168.1.1 -Force
Add-Dhcpserverv4ExclusionRange -ScopeId 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.11 -ClientId $macPrinter -Description "Reservation for Printer"