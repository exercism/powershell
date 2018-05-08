$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "HammingTest" {
    It "tests identical strands" {
    Get-HammingDifference 'A' 'A' | Should be 0
    }

    It "tests log identical strands" {
        Get-HammingDifference "GGACTGA" "GGACTGA" | Should be 0
    }

    It "tests complete distance in single nucleotide strands" {
        Get-HammingDifference "A" "G" | Should be 1
    }

    It "tests complete distance in small strands" {
        Get-HammingDifference "AG" "CT" | Should be 2
    }

    It "tests small distance in small strands" {
        Get-HammingDifference "AT"  "CT" | Should be 1
    }

    It "tests small distance" {
        Get-HammingDifference "GGACG" "GGTCG" | Should be 1
    }

    It "tests small distance in long strands" {
        Get-HammingDifference "ACCAGGG" "ACTATGG" | Should be 2
    }

    It "tests non unique character in first strand" {
        Get-HammingDifference "AGA" "AGG" | Should be 1
    }

    It "tests non unique character in second strand" {
        Get-HammingDifference "AGG" "AGA" | Should be 1
    }

    It "tests same nucleotides in different position" {
        Get-HammingDifference "TAG" "GAT" | Should be 2
    }

    It "tests large distance" {
        Get-HammingDifference "GATACA" "GCATAA" | Should be 4
    }

    It "tests large distance in off by one strand" {
        Get-HammingDifference "GGACGGATTCTG" "AGGACGGATTCT" | Should be 9
    }

    It "tests empty strands" {
        Get-HammingDifference "" "" | Should be 0
    }

    It "tests disallow first strand longer" {
        { Get-HammingDifference "AATG" "AAA" } | Should Throw "Mismatching string lengths"
    }

    It "tests disallow second strand longer" {
        { Get-HammingDifference "ATA" "AGTG" } | Should Throw "Mismatching string lengths"
    }
}
