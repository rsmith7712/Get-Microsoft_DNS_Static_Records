<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.127
	 Created on:   	10/3/2016 9:43 AM
	 Created by:   	Richard Smith, ERocconi
	 Organization: 	
	 Filename:     	git-Get-Microsoft_DNS_Static_Records.ps1
	===========================================================================
	.DESCRIPTION
		Get all dns static dns records in a specific zone
#>

Import-Module ActiveDirectory

# VARIABLES 
$ServerName = "DOMAIN CONTROLLER.DOMAIN.com"
$ContainerName = "DOMAIN.com"

foreach ($Server in $ServerName) {
	
	Get-WmiObject -ComputerName $Server -Namespace "root\MicrosoftDNS" -Class "MicrosoftDNS_AType" `
	-Filter "ContainerName = '$ContainerName' AND TimeStamp=0" `
	| Select-Object OwnerName, IPAddress, TextRepresentation, TTL, @{ n = "TimeStamp"; e = { "Static" } } | Export-Csv -Path c:\static_DNS_entries.csv -Encoding ascii -NoTypeInformation
	
}
