$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "HelloWorldTest" {
	It "outputs 'Hello World!'" {
		Get-HelloWorld | Should be 'Hello World!'
	}

	It "outputs Hello Alice!" {
		Get-HelloWorld('Alice') | Should be 'Hello Alice!'
	}

	It "outpus Hello Bob!" {
		Get-HelloWorld('Bob') | Should be 'Hello Bob!'
	}
}
