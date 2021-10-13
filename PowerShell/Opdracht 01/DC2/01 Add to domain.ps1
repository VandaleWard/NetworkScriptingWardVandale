$s = New-PSSession -ComputerName "DC2" -Credential(Get-Credential)

Invoke-Command -Session $s -ScriptBlock {
    Add-Computer -DomainName intranet.mijnschool.be -Credential Administrator -Restart # Adding the MS to the Domain intranet.mijnschool.be
}