$ExercisePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ScriptFile = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'

$CommandName = "Get-HammingDifference"

# Remove the function if its already found
If (Get-Command $CommandName -ErrorAction SilentlyContinue){
    Write-Verbose "Removing the existing $CommandName function from memory as it is already loaded"
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

Describe "Get-Hamming Test cases" {

    It "Empty strands" {
        Get-HammingDifference '' '' | Should be 0
    }
    
    It "Empty strands" {
        Get-HammingDifference 'A' 'A' | Should be 0
    }

    It "Long identical strands" {
        Get-HammingDifference "GGACTGA" "GGACTGA" | Should be 0
    }

    It "Complete distance in single nucleotide strands" {
        Get-HammingDifference "A" "G" | Should be 1
    }

    It "Complete distance in small strands" {
        Get-HammingDifference "AG" "CT" | Should be 2
    }

    It "Small distance in small strands" {
        Get-HammingDifference "AT"  "CT" | Should be 1
    }

    It "Small distance" {
        Get-HammingDifference "GGACG" "GGTCG" | Should be 1
    }

    It "Small distance in long strands" {
        Get-HammingDifference "ACCAGGG" "ACTATGG" | Should be 2
    }

    It "Non-unique character in first strand" {
        Get-HammingDifference "AAG" "AAA" | Should be 1
    }

    It "Non-unique character in second strand" {
        Get-HammingDifference "AAA" "AAG" | Should be 1
    }

    It "Same nucleotides in different positions" {
        Get-HammingDifference "TAG" "GAT" | Should be 2
    }

    It "Large distance" {
        Get-HammingDifference "GATACA" "GCATAA" | Should be 4
    }

    It "Large distance in off-by-one strand" {
        Get-HammingDifference "GGACGGATTCTG" "AGGACGGATTCT" | Should be 9
    }

    It "Disallow first strand longer" {
        { Get-HammingDifference "AATG" "AAA" } | Should Throw "Left and right strands must be of equal length."
    }

    It "Disallow second strand longer" {
        { Get-HammingDifference "ATA" "AGTG" } | Should Throw "Left and right strands must be of equal length."
    }
}
