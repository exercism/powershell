$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".Example.")

# Remove the function if its already found
If (Get-Command Out-HelloWorld -ErrorAction SilentlyContinue){
	Write-Verbose "Removing the existing Out-HelloWorld function as it exists"
	Remove-Item -Path Function:\Out-HelloWorld
}

# Load the script file
. "$ExercisePath\$ScriptFile" -Force


Describe "Out-HelloWorld" {
	It "Outputs: Hello, World!" {
		Out-HelloWorld | Should -Be "Hello, World!"
	}

	It "Outputs: Hello, Alice!" {
		Out-HelloWorld "Alice" | Should -Be "Hello, Alice!"
	}

	It "Outputs: Hello, Bob!" {
		Out-HelloWorld "Bob" | Should -Be "Hello, Bob!"
	}
}