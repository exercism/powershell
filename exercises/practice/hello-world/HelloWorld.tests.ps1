$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "HelloWorldTest" {
	It "Outputs: 'Hello, World!'" {
		Get-HelloWorld | Should be 'Hello, World!'
	}

	It "Outputs: Hello, Alice!" {
		Get-HelloWorld 'Alice' | Should be 'Hello, Alice!'
	}

	It "Outputs: Hello, Bob!" {
		Get-HelloWorld -person 'Bob' | Should be 'Hello, Bob!'
	}
}
