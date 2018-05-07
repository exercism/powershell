Function Get-HelloWorld {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[string]$Person = "World"
	)

	return "Hello, $Person!"
}