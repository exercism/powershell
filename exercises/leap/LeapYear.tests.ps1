$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "LeapYear Tests" {
    It "Year not divisible by 4: common year" {
        Test-LeapYear(2015) | Should be $false
    }

    It "Year divisible by 4, not divisible by 100: leap year" {
        Test-LeapYear(1996) | Should be $true
    }

    It "Year divisible by 100, not divisible by 400: common year" {
        Test-LeapYear(2100) | Should be $false
    }

    It "Year divisible by 400: leap year" {
        Test-LeapYear(2000) | Should be $true
    }
}
