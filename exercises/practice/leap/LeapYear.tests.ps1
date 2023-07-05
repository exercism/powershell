BeforeAll {
    . ".\LeapYear.ps1"
}

Describe "LeapYear Tests" {
    It "year not divisible by 4 in common year" {
        Test-LeapYear(2015) | Should -Be $false
    }

    It "year divisible by 2, not divisible by 4 in common year" {
        Test-LeapYear(1970) | Should -Be $false
    }

    It "year divisible by 4, not divisible by 100 in leap year" {
        Test-LeapYear(1996) | Should -Be $true
    }

    It "year divisible by 4 and 5 is still a leap year" {
        Test-LeapYear(1960) | Should -Be $true
    }

    It "year divisible by 100, not divisible by 400 in common year" {
        Test-LeapYear(2100) | Should -Be $false
    }

    It "year divisible by 100 but not by 3 is still not a leap year" {
        Test-LeapYear(1900) | Should -Be $false
    }

    It "year divisible by 400 in leap year" {
        Test-LeapYear(2000) | Should -Be $true
    }

    It "year divisible by 400 but not by 125 is still a leap year" {
        Test-LeapYear(2400) | Should -Be $true
    }

    It "year divisible by 200, not divisible by 400 in common year" {
        Test-LeapYear(1800) | Should -Be $false
    }
}
