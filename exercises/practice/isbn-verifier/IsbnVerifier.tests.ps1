BeforeAll {
    . ".\IsbnVerifier.ps1"
}

Describe "IsbnVerifierTests" {
	It "valid isbn" {
        $got = Test-Isbn -Isbn "3-598-21508-8"

		$got | Should -BeTrue
	}

    It "invalid isbn check digit" {
        $got = Test-Isbn -Isbn "3-598-21508-9"

        $got | Should -BeFalse
    }

    It "valid isbn with a check digit of 10" {
        $got = Test-Isbn -Isbn "3-598-21507-X"

        $got | Should -BeTrue
    }

    It "check digit is a character other than X" {
        $got = Test-Isbn -Isbn "3-598-21507-A"

        $got | Should -BeFalse
    }

    It "invalid check digit in isbn is not treated as zero" {
        $got = Test-Isbn -Isbn "4-598-21507-B"

        $got | Should -BeFalse
    }

    It "invalid character in isbn is not treated as zero" {
        $got = Test-Isbn -Isbn "3-598-P1581-X"

        $got | Should -BeFalse
    }

    It "X is only valid as a check digit" {
        $got = Test-Isbn -Isbn "3-598-2X507-9"

        $got | Should -BeFalse
    }

    It "valid isbn without separating dashes" {
        $got = Test-Isbn -Isbn "3598215088"

        $got | Should -BeTrue
    }

    It "isbn without separating dashes and X as check digit" {
        $got = Test-Isbn -Isbn "359821507X"

        $got | Should -BeTrue
    }

    It "isbn without check digit and dashes" {
        $got = Test-Isbn -Isbn "359821507"

        $got | Should -BeFalse
    }

    It "too long isbn and no dashes" {
        $got = Test-Isbn -Isbn "3598215078X"

        $got | Should -BeFalse
    }

    It "too short isbn" {
        $got = Test-Isbn -Isbn "00"

        $got | Should -BeFalse
    }

    It "isbn without check digit" {
        $got = Test-Isbn -Isbn "3-598-21507"

        $got | Should -BeFalse
    }

    It "check digit of X should not be used for 0" {
        $got = Test-Isbn -Isbn "3-598-21515-X"

        $got | Should -BeFalse
    }

    It "empty isbn" {
        $got = Test-Isbn -Isbn ""

        $got | Should -BeFalse
    }

    It "input is 9 characters" {
        $got = Test-Isbn -Isbn "134456729"

        $got | Should -BeFalse
    }

    It "invalid characters are not ignored after checking length" {
        $got = Test-Isbn -Isbn "3132P34035"

        $got | Should -BeFalse
    }

    It "invalid characters are not ignored before checking length" {
        $got = Test-Isbn -Isbn "3598P215088"

        $got | Should -BeFalse
    }

    It "input is too long but contains a valid isbn" {
        $got = Test-Isbn -Isbn "98245726788"

        $got | Should -BeFalse
    }
}
