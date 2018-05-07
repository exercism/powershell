$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "HelloWorldTest" {
	It "outputs 'Hello World!'" {
		HelloWorld | Should be 'Hello World!'
	}

	It "outputs Hello Alice!" {
		HelloWorld('Alice') | Should be 'Hello Alice!'
	}

	It "outpus Hello Bob!" {
		HelloWorld('Bob') | Should be 'Hello Bob!'
	}
}