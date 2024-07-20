BeforeAll {
    . "./Change.ps1"
}

Describe "coin change test cases" {
    Context "passing tests" {
        It "change for 1 cent" {
            $got  = Get-Change -Coins @(1, 2, 5) -Target 1
            $want = @(1)

            $got | Should -BeExactly $want
        }

        It "single coin change" {
            $got  = Get-Change -Coins @(1, 5, 10, 25, 100) -Target 10
            $want = @(10)

            $got | Should -BeExactly $want
        }

        It "multiple coin change" {
            $got  = Get-Change -Coins @(1, 5, 10, 25, 100) -Target 36
            $want = @(1, 10, 25)

            $got | Should -BeExactly $want
        }

        It "change with Lilliputian Coins" {
            $got  = Get-Change -Coins @(1, 4, 15, 20, 50) -Target 23
            $want = @(4, 4, 15)

            $got | Should -BeExactly $want
        }

        It "change with Lower Elbonia Coins" {
            $got  = Get-Change -Coins @(1, 5, 10, 21, 25) -Target 63
            $want = @(21, 21, 21)

            $got | Should -BeExactly $want
        }

        It "large target values" {
            $got  = Get-Change -Coins @(1, 2, 5, 10, 20, 50, 100) -Target 999
            $want = @(2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100)

            $got | Should -BeExactly $want
        }

        It "possible change without unit coins available" {
            $got  = Get-Change -Coins @(2, 5, 10, 20, 50) -Target 21
            $want = @(2, 2, 2, 5, 10)

            $got | Should -BeExactly $want
        }

        It "another possible change without unit coins available" {
            $got  = Get-Change -Coins @(4, 5) -Target 27
            $want = @(4, 4, 4, 5, 5, 5)

            $got | Should -BeExactly $want
        }

        It "a greedy approach is not optimal" {
            $got  = Get-Change -Coins @(1, 10, 11) -Target 20
            $want = @(10, 10)

            $got | Should -BeExactly $want
        }

        It "no coins make 0 change" {
            $got  = Get-Change -Coins @(1, 2, 5) -Target 0
            $want = @()

            $got | Should -BeExactly $want
        }
    }

    Context "invalid inputs" {
        It "error testing for change smaller than the smallest of coins" {
            {Get-Change -Coins @(5, 10) -Target 3} | Should -Throw "*Can't make change with given coins*"
        }

        It "error if no combination can add up to target" {
            {Get-Change -Coins @(5, 10) -Target 27} | Should -Throw "*Can't make change with given coins*"
        }

        It "cannot find negative change values" {
            {Get-Change -Coins @(5, 10) -Target -2} | Should -Throw "*Target can't be negative*"
        }
    }
}