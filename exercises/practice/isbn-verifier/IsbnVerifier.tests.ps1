BeforeAll {
    . ".\IsbnVerifier.ps1"
}

Describe "IsbnVerifierTests" {
	It "valid isbn" {
        $got = Test-Isbn -Isbn "3-598-21508-8"

		$got | Should -Be $true
	}

    It "invalid isbn check digit" {
        $got = Test-Isbn -Isbn "3-598-21508-9"

        $got | Should -Be $false
    }

    It "valid isbn with a check digit of 10" {
        $got = Test-Isbn -Isbn "3-598-21507-X"

        $got | Should -Be $true
    }

    It "check digit is a character other than X" {
        $got = Test-Isbn -Isbn "3-598-21507-A"

        $got | Should -Be $false
    }

    It "invalid check digit in isbn is not treated as zero" {
        $got = Test-Isbn -Isbn "4-598-21507-B"

        $got | Should -Be $false
    }

    It "invalid character in isbn is not treated as zero" {
        $got = Test-Isbn -Isbn "3-598-P1581-X"

        $got | Should -Be $false
    }

    It "X is only valid as a check digit" {
        $got = Test-Isbn -Isbn "3-598-2X507-9"

        $got | Should -Be $false
    }

    It "valid isbn without separating dashes" {
        $got = Test-Isbn -Isbn "3598215088"

        $got | Should -Be $true
    }

    It "isbn without separating dashes and X as check digit" {
        $got = Test-Isbn -Isbn "359821507X"

        $got | Should -Be $true
    }

    It "isbn without check digit and dashes" {
        $got = Test-Isbn -Isbn "359821507"

        $got | Should -Be $false
    }

    It "too long isbn and no dashes" {
        $got = Test-Isbn -Isbn "3598215078X"

        $got | Should -Be $false
    }

    It "too short isbn" {
        $got = Test-Isbn -Isbn "00"

        $got | Should -Be $false
    }

    It "isbn without check digit" {
        $got = Test-Isbn -Isbn "3-598-21507"

        $got | Should -Be $false
    }

    It "check digit of X should not be used for 0" {
        $got = Test-Isbn -Isbn "3-598-21515-X"

        $got | Should -Be $false
    }

    It "empty isbn" {
        $got = Test-Isbn -Isbn ""

        $got | Should -Be $false
    }

    It "input is 9 characters" {
        $got = Test-Isbn -Isbn "134456729"

        $got | Should -Be $false
    }

    It "invalid characters are not ignored after checking length" {
        $got = Test-Isbn -Isbn "3132P34035"

        $got | Should -Be $false
    }

    It "invalid characters are not ignored before checking length" {
        $got = Test-Isbn -Isbn "3598P215088"

        $got | Should -Be $false
    }

    It "input is too long but contains a valid isbn" {
        $got = Test-Isbn -Isbn "98245726788"

        $got | Should -Be $false
    }
}
