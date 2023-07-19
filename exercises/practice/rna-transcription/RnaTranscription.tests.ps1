BeforeAll {
    . ".\RnaTranscription.ps1"
}

Describe "RnaTranscriptionTests" {
	It "Empty RNA sequence" {
        $got = Invoke-RnaTranscription -Strand ""
        $want = ""

        $got | Should -Be $want
	}

    It "RNA complement of cytosine is guanine" {
        $got = Invoke-RnaTranscription -Strand "C"
        $want = "G"

        $got | Should -Be $want
    }

    It "RNA complement of guanine is cytosine" {
        $got = Invoke-RnaTranscription -Strand "G"
        $want = "C"

        $got | Should -Be $want
    }

    It "RNA complement of thymine is adenine" {
        $got = Invoke-RnaTranscription -Strand "T"
        $want = "A"

        $got | Should -Be $want
    }

    It "RNA complement of adenine is uracil" {
        $got = Invoke-RnaTranscription -Strand "A"
        $want = "U"

        $got | Should -Be $want
    }

    It "RNA complement" {
        $got = Invoke-RnaTranscription -Strand "ACGTGGTCTTAA"
        $want = "UGCACCAGAAUU"

        $got | Should -Be $want
    }
}
