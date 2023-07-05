BeforeAll {
    . "./accumulate.ps1"
}

Describe 'Test Get-Accumulation.ps1' {
    It "accumulate empty" {
        $got = Get-Accumulation -List @() -Func { Param($numbers) $numbers * $numbers }
        $want = @()

        $got | Should -BeExactly $want
    }

    It "accumulate squares" {
        $got = Get-Accumulation -List @(1, 2, 3) -Func { Param($numbers) $numbers * $numbers }
        $want = @(1, 4, 9)

        $got | Should -BeExactly $want
    }

    It "accumulate upcases" {
        $got = Get-Accumulation -List @("Hello", "world") -Func { Param($word) $word.ToUpper() }
        $want = @("HELLO", "WORLD")

        $got | Should -BeExactly $want
    }

    It "accumulate reversed strings" {
        $got = Get-Accumulation -List @("the", "quick", "brown", "fox", "etc") -Func { Param($word) $word[-1..-($word.Length)] -join "" }
        $want = @("eht", "kciuq", "nworb", "xof", "cte")

        $got | Should -BeExactly $want
    }

    It "accumulate recursively" {
        $got = Get-Accumulation -List @("a", "b", "c") -Func { Param($letter) return @("1", "2", "3") | ForEach-Object { Invoke-Command -Scriptblock {Param($number) $letter + $number } -ArgumentList $_ } } 
        $want = @("a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3")

        $got | Should -BeExactly $want
    }
}
