BeforeAll {
    . "./ResistorColor.ps1"
}

Describe "Test Get-ColorCode" {
    It "Black" {
        $got = Get-ColorCode -Color "black"
        $want = 0

        $got | Should -BeExactly $want
    }

    It "White" {
        $got = Get-ColorCode -Color "white"
        $want = 9

        $got | Should -BeExactly $want
    }

    It "Orange" {
        $got = Get-ColorCode -Color "orange"
        $want = 3

        $got | Should -BeExactly $want
    }

    It "Colors" {
        $got = Get-Colors
        $want = @("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")

        $got | Should -BeExactly $want
    }
}
