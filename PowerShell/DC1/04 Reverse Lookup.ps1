$NetworkID = "192.168.1.0/24"
$ZoneFile = "1.168.192.in-addr.arpa.dns"

$Dns1 = "172.20.0.2"
$Dns2 = "172.20.0.3"
$IPType = "IPv4"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter -Physical | Where-Object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses ($Dns1, $Dns2)


Add-DnsServerPrimaryZone -NetworkID $NetworkID -ZoneFile $ZoneFile -DynamicUpdate None -PassThru