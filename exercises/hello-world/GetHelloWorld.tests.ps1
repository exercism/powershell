$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# Remove the function if its already found
If (Get-Command Get-HelloWorld -ErrorAction SilentlyContinue){
    Write-Verbose "Removing the existing Get-HelloWorld function as it exists"
	Remove-Item -Path Function:\Get-HelloWorld
	}

# Load the script file
. "$ExercisePath\$ScriptFile" -Force

Describe "GetHelloWorldTest" {
    It "outputs 'Hello World!'" {
        Get-HelloWorld | Should be 'Hello, World!'
	}

	It "outputs Hello Alice!" {
        Get-HelloWorld('Alice') | Should be 'Hello, Alice!'
	}

	It "outpus Hello Bob!" {
        Get-HelloWorld('Bob') | Should be 'Hello, Bob!'
	}
}