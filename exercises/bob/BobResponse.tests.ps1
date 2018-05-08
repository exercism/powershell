$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "BobTests" {
	It "Enter1stTestHere" {
		#Get-BobResponse
		Throw "Tests not implemented"
	}
}
