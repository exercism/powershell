Function Out-HelloWorld {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[string]$Person = ""
	)

	Write-Output ""
}