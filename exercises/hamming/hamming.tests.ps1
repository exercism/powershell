$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "HammingTest" {
	It "tests identical strands" {
		Compute 'A' 'A' | Should be 0
	}
	It "tests log identical strands" {
		Compute "GGACTGA" "GGACTGA" | Should be 0
	}

	It "tests complete distance in single nucleotide strands" {
		Compute "A" "G" | Should be 1
	}

	It "tests complete distance in small strands" {
		Compute "AG" "CT" | Should be 2
	}

	It "tests small distance in small strands" {
		Compute "AT"  "CT" | Should be 1
	}

	It "tests small distance" {
		Compute "GGACG" "GGTCG" | Should be 1
	}

	It "tests small distance in long strands" {
		Compute "ACCAGGG" "ACTATGG" | Should be 2
	}

	It "tests non unique character in first strand" {
		Compute "AGA" "AGG" | Should be 1
	}

	It "tests non unique character in second strand" {
		Compute "AGG" "AGA" | Should be 1
	}

	It "tests same nucleotides in different position" {
		Compute "TAG" "GAT" | Should be 2
	}

	It "tests large distance" {
		Compute "GATACA" "GCATAA" | Should be 4
	}

	It "tests large distance in off by one strand" {
		Compute "GGACGGATTCTG" "AGGACGGATTCT" | Should be 9
	}

	It "tests empty strands" {
		Compute "" "" | Should be 0
	}

	It "tests disallow first strand longer" {
		{ Compute "AATG" "AAA" } | Should Throw "Mismatching string lengths"
	}

	It "tests disallow second strand longer" {
		{ Compute "ATA" "AGTG" } | Should Throw "Mismatching string lengths"
	}
}
