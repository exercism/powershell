BeforeAll {
    . ".\Raindrops.ps1"
}

Describe "Test Get-Raindrops" {

	It "Given the number <Number> it should output <Result>" -TestCases @(
		@{ Number = 1; Result = "1" },
		@{ Number = 3; Result = "Pling" },
		@{ Number = 5; Result = "Plang" },
		@{ Number = 7; Result = "Plong" },
		@{ Number = 6; Result = "Pling" },
		@{ Number = 9; Result = "Pling" },
		@{ Number = 10; Result = "Plang" },
		@{ Number = 14; Result = "Plong" },
		@{ Number = 15; Result = "PlingPlang" },
		@{ Number = 21; Result = "PlingPlong" },
		@{ Number = 25; Result = "Plang" },
		@{ Number = 27; Result = "Pling" },
		@{ Number = 35; Result = "PlangPlong" },
		@{ Number = 49; Result = "Plong" },
		@{ Number = 52; Result = "52" },
		@{ Number = 105; Result = "PlingPlangPlong" },
		@{ Number = 3125; Result = "Plang" },
		@{ Number = 12121; Result = "12121" }
	) {
		Param(
			[int]$Number,
			[string]$Result
		)

		Get-Raindrops -Rain $Number | Should -BeExactly $Result
	}
}