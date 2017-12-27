Function Hello-World {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[string]$Person = "World"
	)

	Write-Output "Hello, $Person!"
}