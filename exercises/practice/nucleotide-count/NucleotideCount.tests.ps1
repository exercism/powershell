BeforeAll {
    . ".\NucleotideCount.ps1"
}

Describe "NucleotideCountTests" {
	It "empty strand" {
        $got = Get-NucleotideCount -Strand ""
		$want = @{ A = 0; C = 0; G = 0; T = 0 }

		$want.Keys | Should -HaveCount $got.Keys.Count
        $want.Keys | % {$want[$_] | Should -Be $got[$_]}
	}

	It "can count one nucleotide in single-character input" {
		$got = Get-NucleotideCount -Strand "G"
		$want = @{ A = 0; C = 0; G = 1; T = 0 }

		$want.Keys | Should -HaveCount $got.Keys.Count
		$want.Keys | % {$want[$_] | Should -Be $got[$_]}
	}

	It "strand with repeated nucleotide" {
		$got = Get-NucleotideCount -Strand "GGGGGGG"
		$want = @{ A = 0; C = 0; G = 7; T = 0 }

		$want.Keys | Should -HaveCount $got.Keys.Count
		$want.Keys | % {$want[$_] | Should -Be $got[$_]}
	}

	It "strand with multiple nucleotides" {
		$got = Get-NucleotideCount -Strand "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
		$want = @{ A = 20; C = 12; G = 17; T = 21 }

		$want.Keys | Should -HaveCount $got.Keys.Count
		$want.Keys | % {$want[$_] | Should -Be $got[$_]}
	}

	It "strand with invalid nucleotides" {
		{ Get-NucleotideCount -Strand "AGXXACT" } | Should -Throw "Invalid nucleotide in strand"
	}	
}
