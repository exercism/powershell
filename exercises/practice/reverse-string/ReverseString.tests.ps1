BeforeAll {
    . ".\ReverseString.ps1"
}

Describe "Get-ReverseString Tests" {
	It "Given <Forward> it outputs <Reverse>" -TestCases @(
		@{ Forward = ""; Reverse = "" },
		@{ Forward = "PowerShell"; Reverse = "llehSrewoP" },
		@{ Forward = "robot"; Reverse = "tobor" },
		@{ Forward = "Ramen"; Reverse = "nemaR" },
		@{ Forward = "I'm hungry!"; Reverse = "!yrgnuh m'I" },
		@{ Forward = "racecar"; Reverse = "racecar" }
	) {
		Param(
			[string]$Forward,
			[string]$Reverse
		)

		Get-ReverseString -Forward $Forward | Should -BeExactly $Reverse
	}
}
