BeforeAll {
    . "./ProteinTranslation.ps1"
}

Describe "Test Invoke-ProteinTranslation.ps1" {
    Context "Passing Tests" {
        It "Empty RNA sequence results in no proteins" {
            $got = Invoke-ProteinTranslation -Strand ""
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Methionine codon translates into protein" {
            $got = Invoke-ProteinTranslation -Strand "AUG"
            $want = @("Methionine")
    
            $got | Should -BeExactly $want
        }

        It "Phenylalanine RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UUU"
            $want = @("Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Phenylalanine RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UUC"
            $want = @("Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Leucine RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UUA"
            $want = @("Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Leucine RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UUG"
            $want = @("Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UCU"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UCC"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 3" {
            $got = Invoke-ProteinTranslation -Strand "UCA"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 4" {
            $got = Invoke-ProteinTranslation -Strand "UCG"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Tyrosine RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UAU"
            $want = @("Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Tyrosine RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UAC"
            $want = @("Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Cysteine RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UGU"
            $want = @("Cysteine")
    
            $got | Should -BeExactly $want
        }

        It "Cysteine RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UGC"
            $want = @("Cysteine")
    
            $got | Should -BeExactly $want
        }

        It "Tryptophan RNA sequence" {
            $got = Invoke-ProteinTranslation -Strand "UGG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 1" {
            $got = Invoke-ProteinTranslation -Strand "UAA"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 2" {
            $got = Invoke-ProteinTranslation -Strand "UAG"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 3" {
            $got = Invoke-ProteinTranslation -Strand "UGA"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Sequence of two different protein codons translates into proteins" {
            $got = Invoke-ProteinTranslation -Strand "UUAUUG"
            $want = @("Leucine", "Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Translate RNA strand into correct protein list" {
            $got = Invoke-ProteinTranslation -Strand "AUGUUUUGG"
            $want = @("Methionine", "Phenylalanine", "Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at beginning of sequence" {
            $got = Invoke-ProteinTranslation -Strand "UAGUGG"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at end of two-codon sequence" {
            $got = Invoke-ProteinTranslation -Strand "UGGUAG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at end of three-codon sequence" {
            $got = Invoke-ProteinTranslation -Strand "AUGUUUUAA"
            $want = @("Methionine", "Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon in middle of three-codon sequence" {
            $got = Invoke-ProteinTranslation -Strand "UGGUAGUGG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon in middle of six-codon sequence" {
            $got = Invoke-ProteinTranslation -Strand "UGGUGUUAUUAAUGGUUU"
            $want = @("Tryptophan", "Cysteine", "Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Incomplete RNA sequence can translate if valid until a STOP codon" {
            $got = Invoke-ProteinTranslation -Strand "UUCUUCUAAUGGU"
            $want = @("Phenylalanine", "Phenylalanine")
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Invalid Inputs" {
        It "Non-existing codon can't translate" {
            { Invoke-ProteinTranslation -Strand "AAA" } | Should -Throw "error: Invalid codon"
        }

        It "Unknown amino acids, not part of a codon, can't translate" {
            { Invoke-ProteinTranslation -Strand "XYZ" } | Should -Throw "error: Invalid codon"
        }

        It "Incomplete RNA sequence can't translate" {
            { Invoke-ProteinTranslation -Strand "AUGU" } | Should -Throw "error: Invalid codon"
        }
    }
}
