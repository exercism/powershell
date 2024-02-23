BeforeAll {
    . ".\Isogram.ps1"
}

Describe "IsogramTests" {
	It "empty string" {
        $got = Invoke-Isogram -Phrase ""

		$got | Should -BeTrue
	}

    It "isogram with only lower case characters" {
        $got = Invoke-Isogram -Phrase "isogram"

        $got | Should -BeTrue
    }

    It "word with one duplicated character" {
        $got = Invoke-Isogram -Phrase "eleven"

        $got | Should -BeFalse
    }

    It "word with one duplicated character from the end of the alphabet" {
        $got = Invoke-Isogram -Phrase "zzyzx"

        $got | Should -BeFalse
    }

    It "longest reported english isogram" {
        $got = Invoke-Isogram -Phrase "subdermatoglyphic"

        $got | Should -BeTrue
    }

    It "word with duplicated character in mixed case" {
        $got = Invoke-Isogram -Phrase "Alphabet"

        $got | Should -BeFalse
    }

    It "word with duplicated character in mixed case, lowercase first" {
        $got = Invoke-Isogram -Phrase "alphAbet"

        $got | Should -BeFalse
    }

    It "hypothetical isogrammic word with hyphen" {
        $got = Invoke-Isogram -Phrase "thumbscrew-japingly"

        $got | Should -BeTrue
    }

    It "hypothetical word with duplicated character following hyphen" {
        $got = Invoke-Isogram -Phrase "thumbscrew-jappingly"

        $got | Should -BeFalse
    }

    It "isogram with duplicated hyphen" {
        $got = Invoke-Isogram -Phrase "six-year-old"

        $got | Should -BeTrue
    }

    It "made-up name that is an isogram" {
        $got = Invoke-Isogram -Phrase "Emily Jung Schwartzkopf"

        $got | Should -BeTrue
    }

    It "duplicated character in the middle" {
        $got = Invoke-Isogram -Phrase "accentor"

        $got | Should -BeFalse
    }

    It "word with duplicated character and with two hyphens" {
        $got = Invoke-Isogram -Phrase "up-to-date"

        $got | Should -BeFalse
    }
}
