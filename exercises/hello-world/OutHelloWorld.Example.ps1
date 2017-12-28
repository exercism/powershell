Function Out-HelloWorld {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[string]$Person = "World"
	)

	Write-Output "Hello, $Person!"
}