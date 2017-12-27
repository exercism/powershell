$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

# Remove the function if its already found
If (Get-Command Hello-World -ErrorAction SilentlyContinue){
	Write-Verbose "Removing the existing Hello-World function as it exists"
	Remove-Item -Path Function:\Hello-World
}

# Load the script file
If (Test-Path "$ExercisePath\$ScriptFile"){
	. "$ExercisePath\$ScriptFile"
}
Else {
	# Display an error and stop the tests
	Write-Error "The file $ScriptFile was not found. You need to create your answer in a file named $ScriptFile" -ErrorAction Stop
}


Describe "Hello-World" {
	It "Outputs: Hello, World!" {
		Hello-World | Should -Be "Hello, World!"
	}

	It "Outputs: Hello, Alice!" {
		Hello-World "Alice" | Should -Be "Hello, Alice!"
	}

	It "Outputs: Hello, Bob!" {
		Hello-World "Bob" | Should -Be "Hello, Bob!"
	}
}