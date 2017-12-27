Function Hello-World {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[string]$Person = ""
	)

	Write-Output ""
}