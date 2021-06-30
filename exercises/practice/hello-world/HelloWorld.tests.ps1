BeforeAll {
    . ".\HelloWorld.ps1"
}

Describe "HelloWorldTest" {
	It "Outputs: 'Hello, World!'" {
		Get-HelloWorld | Should -Be 'Hello, World!'
	}

	It "Outputs: Hello, Alice!" {
		Get-HelloWorld 'Alice' | Should -Be 'Hello, Alice!'
	}

	It "Outputs: Hello, Bob!" {
		Get-HelloWorld -person 'Bob' | Should -Be 'Hello, Bob!'
	}
}
