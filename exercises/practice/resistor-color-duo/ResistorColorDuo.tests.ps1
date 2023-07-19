BeforeAll {
    . "./ResistorColorDuo.ps1"
}

Describe "Test Get-ColorCodeValue" {
    It "Brown and blac" {
        $got = Get-ColorCodeValue -Colors @("brown", "black")
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Blue and grey" {
        $got = Get-ColorCodeValue -Colors @("blue", "grey")
        $want = 68

        $got | Should -BeExactly $want
    }

    It "Yellow and violet" {
        $got = Get-ColorCodeValue -Colors @("yellow", "violet")
        $want = 47

        $got | Should -BeExactly $want
    }

    It "White and red" {
        $got = Get-ColorCodeValue -Colors @("white", "red")
        $want = 92

        $got | Should -BeExactly $want
    }

    It "Orange and orange" {
        $got = Get-ColorCodeValue -Colors @("orange", "orange")
        $want = 33

        $got | Should -BeExactly $want
    }

    It "Ignore extra colors" {
        $got = Get-ColorCodeValue -Colors @("green", "brown", "orange")
        $want = 51

        $got | Should -BeExactly $want
    }

    It "Black and brown, one-digit" {
        $got = Get-ColorCodeValue -Colors @("black", "brown")
        $want = 1

        $got | Should -BeExactly $want
    }
}
