BeforeAll {
    . ".\NucleotideCount.ps1"
}

Describe "NucleotideCountTests" {
	It "empty strand" {
        Get-NucleotideCount -Strand "" | Should -BeExactly "A:0 C:0 G:0 T:0"
	}

	It "can count one nucleotide in single-character input" {
		Get-NucleotideCount -Strand "G" | Should -BeExactly "A:0 C:0 G:1 T:0"
	}

	It "strand with repeated nucleotide" {
		Get-NucleotideCount -Strand "GGGGGGG" | Should -BeExactly "A:0 C:0 G:7 T:0"
	}

	It "strand with multiple nucleotides" {
		Get-NucleotideCount -Strand "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" | Should -BeExactly "A:20 C:12 G:17 T:21"
	}

	It "strand with invalid nucleotides" {
		{ Get-NucleotideCount -Strand "AGXXACT" } | Should -Throw
	}	
}
