BeforeAll {
    . "./Strain.ps1"
}

Describe "strain test cases" {
    BeforeAll {
        $global:AlwaysTrue      = { $true }
        $global:IsOdd           = { param($num)  $num % 2 -eq 1 }
        $global:IsEven          = { param($num)  $num % 2 -eq 0 }
        $global:LessThanFive    = { param($num)  $num -lt 5 }
        $global:FiveLettersWord = { param($word) $word.Length -eq 5 }
        $global:SumOverTen      = { param($row) ($row | Measure-Object -Sum).Sum -gt 10 }
    }

    Context "keep tests" {
        It "keep on empty list returns empty list" {
            $got  = Invoke-Keep -Data @() -Predicate $global:AlwaysTrue
            $want = @()

            $got | Should -BeExactly $want

        }

        It "keep everything" {
            $got  = Invoke-Keep -Data @(1, 2, 3) -Predicate $global:LessThanFive
            $want = @(1, 2, 3)

            $got | Should -BeExactly $want
        }

        It "keep nothing" {
            $got  = Invoke-Keep -Data @(6, 7, 8) -Predicate $global:LessThanFive
            $want = @()

            $got | Should -BeExactly $want
        }

        It "keep first and last" {
            $got  = Invoke-Keep -Data @(1, 2, 3) -Predicate $global:IsOdd
            $want = @(1, 3)

            $got | Should -BeExactly $want
        }

        It "keep neither first nor last" {
            $got  = Invoke-Keep -Data @(1, 2, 3) -Predicate $global:IsEven
            $want = @(2)

            $got | Should -BeExactly $want

        }

        It "keep string" {
            $data = @("apple", "zebra", "banana", "eagle", "dynamic", "nuts")
            $got  = Invoke-Keep -Data $data -Predicate $global:FiveLettersWord
            $want = @("apple", "zebra", "eagle")

            $got | Should -BeExactly $want
        }

        It "keep list" {
            $data = @(
                @(1, 2, 3),
                @(5, 4, 2),
                @(5, 1, 3),
                @(2, 8, 7),
                @(1, 5, 4),
                @(2, 2, 9),
                @(1, 1, 4)
            )

            $got  = Invoke-Keep -Data $data -Predicate $global:SumOverTen
            $want = @(
                @(5, 4, 2),
                @(2, 8, 7),
                @(2, 2, 9)
            )

            $got | Should -Be $want
        }
    }

    Context "discard tests" {
        It "discard on empty list returns empty list" {
            $got  = Invoke-Discard -Data @() -Predicate $global:AlwaysTrue
            $want = @()

            $got | Should -BeExactly $want
        }

        It "discard everything" {
            $got  = Invoke-Discard -Data @(1, 2, 3) -Predicate $global:LessThanFive
            $want = @()

            $got | Should -BeExactly $want
        }

        It "discard nothing" {
            $got  = Invoke-Discard -Data @(6, 7, 8) -Predicate $global:LessThanFive
            $want = @(6, 7, 8)

            $got | Should -BeExactly $want
        }

        It "discard first and last" {
            $got  = Invoke-Discard -Data @(1, 2, 3) -Predicate $global:IsOdd
            $want = @(2)

            $got | Should -BeExactly $want
        }

        It "discard neither first nor last" {
            $got  = Invoke-Discard -Data @(1, 2, 3) -Predicate $global:IsEven
            $want = @(1, 3)

            $got | Should -BeExactly $want
        }

        It "discard string" {
            $data = @("apple", "zebra", "banana", "eagle", "dynamic", "nuts")
            $got  = Invoke-Discard -Data $data -Predicate $global:FiveLettersWord
            $want = @("banana", "dynamic", "nuts")

            $got | Should -BeExactly $want
        }

        It "discard list" {
            $data = @(
                @(1, 2, 3),
                @(5, 4, 2),
                @(5, 1, 3),
                @(2, 8, 7),
                @(1, 5, 4),
                @(2, 2, 9),
                @(1, 1, 4)
            )
            
            $got  = Invoke-Discard -Data $data -Predicate $global:SumOverTen
            $want = @(
                @(1, 2, 3),
                @(5, 1, 3),
                @(1, 5, 4),
                @(1, 1, 4)
            )

            $got | Should -Be $want
        }
    }
}