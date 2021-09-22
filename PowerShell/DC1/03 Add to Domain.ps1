$DomainName= "intranet.mijnschool.be"

Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName $DomainName -InstallDNS

Restart-Computer