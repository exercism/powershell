$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "LeapYear Tests" {
    It "tests leap year" {
        Test-LeapYear(1996) | Should be $true
    }

    It "tests standard and odd year" {
        Test-LeapYear(1997) | Should be $false
    }

    It "tests standard even year" {
        Test-LeapYear(1998) | Should be $false
    }

    It "tests standard ninteenth century" {
        Test-LeapYear(1900) | Should be $false
    }

    It "tests standard eighteenth year" {
        Test-LeapYear(1800) | Should be $false
    }

    It "tests leap twenty fourth century" {
        Test-LeapYear(2400) | Should be $true
    }

    It "tests leap year 2000" {
        Test-LeapYear(2000) | Should be $true
    }
}
