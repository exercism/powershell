BeforeAll {
    . ".\Luhn.ps1"
}

Describe "LuhnTests" {
	It "single digit strings can not be valid" {
        $got = Test-Luhn -Value "1"

		$got | Should -Be $false
	}

    It "a single zero is invalid" {
        $got = Test-Luhn -Value "0"

        $got | Should -Be $false
    }

    It "a simple valid SIN that remains valid if reversed" {
        $got = Test-Luhn -Value "059"

        $got | Should -Be $true
    }

    It "a simple valid SIN that becomes invalid if reversed" {
        $got = Test-Luhn -Value "59"

        $got | Should -Be $true
    }

    It "a valid Canadian SIN" {
        $got = Test-Luhn -Value "055 444 285"

        $got | Should -Be $true
    }

    It "invalid Canadian SIN" {
        $got = Test-Luhn -Value "055 444 286"

        $got | Should -Be $false
    }

    It "invalid credit card" {
        $got = Test-Luhn -Value "8273 1232 7352 0569"

        $got | Should -Be $false
    }

    It "invalid long number with an even remainder" {
        $got = Test-Luhn -Value "1 2345 6789 1234 5678 9012"

        $got | Should -Be $false
    }

    It "invalid long number with a remainder divisible by 5" {
        $got = Test-Luhn -Value "1 2345 6789 1234 5678 9013"

        $got | Should -Be $false
    }

    It "valid number with an even number of digits" {
        $got = Test-Luhn -Value "095 245 88"

        $got | Should -Be $true
    }

    It "valid number with an odd number of spaces" {
        $got = Test-Luhn -Value "234 567 891 234"

        $got | Should -Be $true
    }

    It "valid strings with a non-digit added at the end become invalid" {
        $got = Test-Luhn -Value "059a"

        $got | Should -Be $false
    }

    It "valid strings with punctuation included become invalid" {
        $got = Test-Luhn -Value "055-444-285"

        $got | Should -Be $false
    }

    It "valid strings with symbols included become invalid" {
        $got = Test-Luhn -Value "055# 444$ 285"

        $got | Should -Be $false
    }

    It "single zero with space is invalid" {
        $got = Test-Luhn -Value " 0"

        $got | Should -Be $false
    }

    It "more than a single zero is valid" {
        $got = Test-Luhn -Value "0000 0"

        $got | Should -Be $true
    }

    It "input digit 9 is correctly converted to output digit 9" {
        $got = Test-Luhn -Value "091"

        $got | Should -Be $true
    }

    It "very long input is valid" {
        $got = Test-Luhn -Value "9999999999 9999999999 9999999999 9999999999"

        $got | Should -Be $true
    }

    It "valid luhn with an odd number of digits and non zero first digit" {
        $got = Test-Luhn -Value "109"

        $got | Should -Be $true
    }

    It "using ascii value for non-doubled non-digit isn't allowed" {
        $got = Test-Luhn -Value "055b 444 285"

        $got | Should -Be $false
    }

    It "using ascii value for doubled non-digit isn't allowed" {
        $got = Test-Luhn -Value ":9"

        $got | Should -Be $false
    }

    It "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed" {
        $got = Test-Luhn -Value "59%59"

        $got | Should -Be $false
    }
}
