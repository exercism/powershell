BeforeAll {
    . "./HammingDifference.ps1"
}

Describe "Get-Hamming Test cases" {
    Context "Passing Tests" {
        It "empty strands" {
            Get-HammingDifference '' '' | Should -Be 0
        }
        
        It "single letter identical strands" {
            Get-HammingDifference 'A' 'A' | Should -Be 0
        }

        It "single letter different strands" {
            Get-HammingDifference 'G' 'T' | Should -Be 1
        }

        It "long identical strands" {
            Get-HammingDifference "GGACTGAAATCTG" "GGACTGAAATCTG" | Should -Be 0
        }

        It "long different strands" {
            Get-HammingDifference "GGACGGATTCTG" "AGGACGGATTCT" | Should -Be 9
        }
    }

    Context "Invalid Inputs" {
        It "disallow first strand longer" {
            { Get-HammingDifference "AATG" "AAA" } | Should -Throw "strands must be of equal length."
        }

        It "disallow second strand longer" {
            { Get-HammingDifference "ATA" "AGTG" } | Should -Throw "strands must be of equal length."
        }

        It "disallow left empty strand" {
            { Get-HammingDifference "" "G" } | Should -Throw "strands must be of equal length."
        }

        It "disallow right empty strand" {
            { Get-HammingDifference "G" "" } | Should -Throw "strands must be of equal length."
        }
    }
}
