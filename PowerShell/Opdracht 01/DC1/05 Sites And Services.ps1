$first_site_name = "Kortrijk" # Var site Kortrijk 
$second_site_name = "Brugge" # Var site Brugge

$subnet_first_site_name = "192.168.1.0/24" # Network address of subnet for Kortrijk
$subnet_second_site_name = "192.168.2.0/24" # Network address of subnet for Brugge

Get-ADReplicationSite "Default-First-Site-Name" | Rename-ADObject -NewName $first_site_name # Renaming the default site name to Kortrijk
Get-ADReplicationSite $first_site_name | Set-ADReplicationSite -Description $first_site_name # Adding a description to that site
New-ADReplicationSubnet -Name $subnet_first_site_name -Site $first_site_name -Description $first_site_name -location $first_site_name # Adding the IP to the site Kortrijk, witch description Kortrijk and location Kortrijk

New-ADReplicationSite $second_site_name # Creating a new site called Brugge
Get-ADReplicationsite $second_site_name | Set-ADReplicationSite -Description $second_site_name # Adding a description to that site
New-ADReplicationSubnet -Name $subnet_second_site_name -Site $second_site_name -Description $second_site_name -location $second_site_name # Adding the IP to the site Kortrijk, witch description Kortrijk and location Kortrijk