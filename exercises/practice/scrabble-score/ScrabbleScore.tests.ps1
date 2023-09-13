BeforeAll {
    . "./ScrabbleScore.ps1"
}

Describe "ScrabbleScore test cases" {
    It "lowercase letter" {
        $got  = Get-ScrabbleScore -Word "a"
        $want = 1

        $got | Should -BeExactly $want
    }

    It "uppercase letter" {
        $got  = Get-ScrabbleScore -Word "A"
        $want = 1

        $got | Should -BeExactly $want
    }

    It "valuable letter" {
        $got  = Get-ScrabbleScore -Word "f"
        $want = 4

        $got | Should -BeExactly $want
    }

    It "short word" {
        $got  = Get-ScrabbleScore -Word "at"
        $want = 2

        $got | Should -BeExactly $want
    }

    It "short, valuable word" {
        $got  = Get-ScrabbleScore -Word "zoo"
        $want = 12

        $got | Should -BeExactly $want
    }

    It "medium word" {
        $got  = Get-ScrabbleScore -Word "pinata"
        $want = 8

        $got | Should -BeExactly $want
    }

    It "medium, valuable word" {
        $got  = Get-ScrabbleScore -Word "quirky"
        $want = 22

        $got | Should -BeExactly $want
    }

    It "long, mixed-case word" {
        $got  = Get-ScrabbleScore -Word "OxyphenButazone"
        $want = 41

        $got | Should -BeExactly $want
    }

    It "english-like word" {
        $got  = Get-ScrabbleScore -Word "pinata"
        $want = 8

        $got | Should -BeExactly $want
    }

    It "empty input" {
        $got  = Get-ScrabbleScore -Word ""
        $want = 0

        $got | Should -BeExactly $want
    }

    It "entire alphabet available" {
        $got  = Get-ScrabbleScore -Word "abcdefghijklmnopqrstuvwxyz"
        $want = 87

        $got | Should -BeExactly $want
    }

    It "special name" {
        $got  = Get-ScrabbleScore -Word "Exercism"
        $want = 19

        $got | Should -BeExactly $want
    }

    It "special name with bonus" {
        $got  = Get-ScrabbleScore -Word "Exercism" -Bonus
        $want = 38

        $got | Should -BeExactly $want
    }
}
