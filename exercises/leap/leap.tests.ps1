$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
. "$here\$sut"

Describe "LeapYear Tests" {
	It "tests leap year" {
		Leap(1996) | Should be True
	}

	It "tests standard and odd year" {
		Leap(1997) | Should be False
	}

	It "tests standard even year" {
		Leap(1998) | Should be False
	}
	
	It "tests standard ninteenth century" {
		Leap(1900) | Should be False
	}

	It "tests standard eighteenth year" {
		Leap(1800) | Should be False
	}

	It "tests leap twenty fourth century" {
		Leap(2400) | Should be True
	}

	It "tests leap year 2000" {
		Leap(2000) | Should be True
	}
}
