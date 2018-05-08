$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

$CommandName = "Get-TwoFer"

# Remove the function if its already found
If (Get-Command $CommandName -ErrorAction SilentlyContinue){
    Write-Verbose "Removing the existing $CommandName function as it exists"
    Remove-Item -Path "Function:\$CommandName"
}

# Load the script file
If (Test-Path "$ExercisePath\$ScriptFile"){
    Write-Output ("Loading: {0}" -f "$ExercisePath\$ScriptFile")
    . ("$ExercisePath\$ScriptFile")
}
Else {
    # Display an error and stop the tests
    Write-Error "The file $ScriptFile was not found. You need to create your answer in a file named $ScriptFile" -ErrorAction Stop
}


Describe "Get-TwoFer" {

    It "Given <Name> expects <Expected>" -TestCases @(
        @{ Name = $null; Expected = "One for you, one for me" },
        @{ Name = ""; Expected = "One for you, one for me" },
        @{ Name = "Alice"; Expected = "One for Alice, one for me" }
    ) {
        Param(
            $Name, $Expected
        )

        Get-TwoFer -Name $Name | Should -Be $Expected
    }
}