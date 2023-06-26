BeforeAll {
    . "./ProtienTranslation.ps1"
}

Describe "Test Invoke-ProtienTranslation.ps1" {
    Context "Passing Tests" {
        It "Empty RNA sequence results in no proteins" {
            $got = Invoke-ProtienTranslation -Strand ""
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Methionine codon translates into protein" {
            $got = Invoke-ProtienTranslation -Strand "AUG"
            $want = @("Methionine")
    
            $got | Should -BeExactly $want
        }

        It "Phenylalanine RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UUU"
            $want = @("Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Phenylalanine RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UUC"
            $want = @("Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Leucine RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UUA"
            $want = @("Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Leucine RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UUG"
            $want = @("Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UCU"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UCC"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 3" {
            $got = Invoke-ProtienTranslation -Strand "UCA"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Serine RNA sequence 4" {
            $got = Invoke-ProtienTranslation -Strand "UCG"
            $want = @("Serine")
    
            $got | Should -BeExactly $want
        }

        It "Tyrosine RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UAU"
            $want = @("Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Tyrosine RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UAC"
            $want = @("Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Cysteine RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UGU"
            $want = @("Cysteine")
    
            $got | Should -BeExactly $want
        }

        It "Cysteine RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UGC"
            $want = @("Cysteine")
    
            $got | Should -BeExactly $want
        }

        It "Tryptophan RNA sequence" {
            $got = Invoke-ProtienTranslation -Strand "UGG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 1" {
            $got = Invoke-ProtienTranslation -Strand "UAA"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 2" {
            $got = Invoke-ProtienTranslation -Strand "UAG"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "STOP codon RNA sequence 3" {
            $got = Invoke-ProtienTranslation -Strand "UGA"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Sequence of two different protein codons translates into proteins" {
            $got = Invoke-ProtienTranslation -Strand "UUAUUG"
            $want = @("Leucine", "Leucine")
    
            $got | Should -BeExactly $want
        }

        It "Translate RNA strand into correct protein list" {
            $got = Invoke-ProtienTranslation -Strand "AUGUUUUGG"
            $want = @("Methionine", "Phenylalanine", "Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at beginning of sequence" {
            $got = Invoke-ProtienTranslation -Strand "UAGUGG"
            $want = @()
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at end of two-codon sequence" {
            $got = Invoke-ProtienTranslation -Strand "UGGUAG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon at end of three-codon sequence" {
            $got = Invoke-ProtienTranslation -Strand "AUGUUUUAA"
            $want = @("Methionine", "Phenylalanine")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon in middle of three-codon sequence" {
            $got = Invoke-ProtienTranslation -Strand "UGGUAGUGG"
            $want = @("Tryptophan")
    
            $got | Should -BeExactly $want
        }

        It "Translation stops if STOP codon in middle of six-codon sequence" {
            $got = Invoke-ProtienTranslation -Strand "UGGUGUUAUUAAUGGUUU"
            $want = @("Tryptophan", "Cysteine", "Tyrosine")
    
            $got | Should -BeExactly $want
        }

        It "Incomplete RNA sequence can translate if valid until a STOP codon" {
            $got = Invoke-ProtienTranslation -Strand "UUCUUCUAAUGGU"
            $want = @("Phenylalanine", "Phenylalanine")
    
            $got | Should -BeExactly $want
        }
    }
    
    Context "Failing Tests" {
        It "Non-existing codon can't translate" {
            { Invoke-ProtienTranslation -Strand "AAA" } | Should -Throw "error: Invalid codon"
        }

        It "Unknown amino acids, not part of a codon, can't translate" {
            { Invoke-ProtienTranslation -Strand "XYZ" } | Should -Throw "error: Invalid codon"
        }

        It "Incomplete RNA sequence can't translate" {
            { Invoke-ProtienTranslation -Strand "AUGU" } | Should -Throw "error: Invalid codon"
        }
    }
}
