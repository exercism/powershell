BeforeAll {
    . ".\SumOfMultiples.ps1"
}

Describe "Get-SumOfMultiples Tests" {
	It "Given the factors <Multiples> and to a limit of <Limit> the sum of multiples should be <ExpectedResult>" -TestCases @(
		@{ Multiples = @(3, 5); Limit = 1; ExpectedResult = 0 },
		@{ Multiples = @(3, 5); Limit = 4; ExpectedResult = 3 },
		@{ Multiples = @(3); Limit = 7; ExpectedResult = 9 },
		@{ Multiples = @(3, 5); Limit = 10; ExpectedResult = 23 },
		@{ Multiples = @(3, 5); Limit = 100; ExpectedResult = 2318 },
		@{ Multiples = @(3, 5); Limit = 1000; ExpectedResult = 233168 },
		@{ Multiples = @(7, 13, 17); Limit = 20; ExpectedResult = 51 },
		@{ Multiples = @(4, 6); Limit = 15; ExpectedResult = 30 },
		@{ Multiples = @(5, 6, 8); Limit = 150; ExpectedResult = 4419 },
		@{ Multiples = @(5, 25); Limit = 51; ExpectedResult = 275 },
		@{ Multiples = @(43, 47); Limit = 10000; ExpectedResult = 2203160 },
		@{ Multiples = @(1); Limit = 100; ExpectedResult = 4950 },
		@{ Multiples = @(); Limit = 1000; ExpectedResult = 0 }
	) {
		Param(
			[int[]]$Multiples,
			[int]$Limit,
			[int]$ExpectedResult
		)

		Get-SumOfMultiples -Multiples $Multiples -Limit $Limit | Should -BeExactly $ExpectedResult
	}
}
