BeforeAll {
    . ".\LeapYear.ps1"
}

Describe "LeapYear Tests" {
    It "Year not divisible by 4: common year" {
        Test-LeapYear(2015) | Should -Be $false
    }

    It "Year divisible by 4, not divisible by 100: leap year" {
        Test-LeapYear(1996) | Should -Be $true
    }

    It "Year divisible by 100, not divisible by 400: common year" {
        Test-LeapYear(2100) | Should -Be $false
    }

    It "Year divisible by 400: leap year" {
        Test-LeapYear(2000) | Should -Be $true
    }
}
