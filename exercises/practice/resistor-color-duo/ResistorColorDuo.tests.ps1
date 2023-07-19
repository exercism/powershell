BeforeAll {
    . "./ResistorColorDuo.ps1"
}

Describe "Test Get-ColorValue" {
    It "Brown and black" {
        $got = Get-ColorValue -Color @("brown", "black")
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Blue and grey" {
        $got = Get-ColorValue -Color @("blue", "grey")
        $want = 68

        $got | Should -BeExactly $want
    }

    It "Yellow and violet" {
        $got = Get-ColorValue -Color @("yellow", "violet")
        $want = 47

        $got | Should -BeExactly $want
    }

    It "White and red" {
        $got = Get-ColorValue -Colors @("white", "red")
        $want = 92

        $got | Should -BeExactly $want
    }

    It "Orange and orange" {
        $got = Get-ColorValue -Colors @("orange", "orange")
        $want = 33

        $got | Should -BeExactly $want
    }

    It "Ignore additional colors" {
        $got = Get-ColorValue -Colors @("green", "brown", "orange")
        $want = 51

        $got | Should -BeExactly $want
    }

    It "Black and brown, one-digit"{
        $got = Get-ColorValue -Colors @("black", "brown")
        $want = 1

        $got | Should -Throw $want
    }
}
