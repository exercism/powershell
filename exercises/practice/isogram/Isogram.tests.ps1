BeforeAll {
    . ".\Isogram.ps1"
}

Describe "IsogramTests" {
	It "empty string" {
        $got = Invoke-Isogram -Phrase ""

		$got | Should -Be $true
	}

    It "isogram with only lower case characters" {
        $got = Invoke-Isogram -Phrase "isogram"

        $got | Should -Be $true
    }

    It "word with one duplicated character" {
        $got = Invoke-Isogram -Phrase "eleven"

        $got | Should -Be $false
    }

    It "word with one duplicated character from the end of the alphabet" {
        $got = Invoke-Isogram -Phrase "zzyzx"

        $got | Should -Be $false
    }

    It "longest reported english isogram" {
        $got = Invoke-Isogram -Phrase "subdermatoglyphic"

        $got | Should -Be $true
    }

    It "word with duplicated character in mixed case" {
        $got = Invoke-Isogram -Phrase "Alphabet"

        $got | Should -Be $false
    }

    It "word with duplicated character in mixed case, lowercase first" {
        $got = Invoke-Isogram -Phrase "alphAbet"

        $got | Should -Be $false
    }

    It "hypothetical isogrammic word with hyphen" {
        $got = Invoke-Isogram -Phrase "thumbscrew-japingly"

        $got | Should -Be $true
    }

    It "hypothetical word with duplicated character following hyphen" {
        $got = Invoke-Isogram -Phrase "thumbscrew-jappingly"

        $got | Should -Be $false
    }

    It "isogram with duplicated hyphen" {
        $got = Invoke-Isogram -Phrase "six-year-old"

        $got | Should -Be $true
    }

    It "made-up name that is an isogram" {
        $got = Invoke-Isogram -Phrase "Emily Jung Schwartzkopf"

        $got | Should -Be $true
    }

    It "duplicated character in the middle" {
        $got = Invoke-Isogram -Phrase "accentor"

        $got | Should -Be $false
    }

    It "word with duplicated character and with two hyphens" {
        $got = Invoke-Isogram -Phrase "up-to-date"

        $got | Should -Be $false
    }
}
