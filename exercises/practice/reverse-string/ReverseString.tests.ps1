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
		@{ Forward = "drawer"; Reverse = "reward" }
	) {
		Param(
			[string]$Forward,
			[string]$Reverse
		)

		Get-ReverseString -Forward $Forward | Should -BeExactly $Reverse
	}

    #these tests are harders due to dealing with unicode, so they are optional and will be skipped online
    #remove the -Skip flag offline to run them
    It "wide characters" -Skip {
		Get-ReverseString -Forward "子猫" | Should -BeExactly "猫子"
    }

    It "grapheme cluster with pre-combined form" -Skip {
		Get-ReverseString -Forward "Würstchenstand" | Should -BeExactly "dnatsnehctsrüW"
	}

    It "grapheme clusters (thai)" -Skip {
		Get-ReverseString -Forward "ผู้เขียนโปรแกรม" | Should -BeExactly "มรกแรปโนยขีเผู้"
    }
}
