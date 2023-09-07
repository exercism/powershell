BeforeAll {
    . "./ResistorColorTrio.ps1"
}

Describe "ResistorColorTrio test cases" {
    It "Orange and orange and black" {
        $got  = Get-ResistorLabel -Colors @("orange", "orange", "black")
        $want = "33 ohms" 

        $got | Should -BeExactly $want
    }

    It "Blue and grey and brown" {
        $got  = Get-ResistorLabel -Colors @("blue", "grey", "brown")
        $want = "680 ohms" 

        $got | Should -BeExactly $want
    }

    It "Red and black and red" {
        $got  = Get-ResistorLabel -Colors @("red", "black", "red")
        $want = "2 kiloohms"

        $got | Should -BeExactly $want
    }

    It "Green and brown and orange" {
        $got  = Get-ResistorLabel -Colors @("green", "brown", "orange")
        $want = "51 kiloohms"

        $got | Should -BeExactly $want
    }

    It "Yellow and violet and yellow" {
        $got  = Get-ResistorLabel -Colors @("yellow", "violet", "yellow")
        $want = "470 kiloohms"

        $got | Should -BeExactly $want
    }

    It "Blue and violet and blue" {
        $got  = Get-ResistorLabel -Colors @("blue", "violet", "blue")
        $want = "67 megaohms"

        $got | Should -BeExactly $want
    }

    It "Minimum possible value" {
        $got  = Get-ResistorLabel -Colors @("black", "black", "black")
        $want = "0 ohms"

        $got | Should -BeExactly $want
    }

    It "Maximum possible value" {
        $got  = Get-ResistorLabel -Colors @("white", "white", "white")
        $want = "99 gigaohms"

        $got | Should -BeExactly $want
    }

    It "First two colors make an invalid octal number" {
        $got  = Get-ResistorLabel -Colors @("black", "grey", "black")
        $want = "8 ohms"

        $got | Should -BeExactly $want
    }

    It "Ignore extra colors" {
        $got  = Get-ResistorLabel -Colors @("blue", "green", "yellow", "orange")
        $want = "650 kiloohms"

        $got | Should -BeExactly $want
    }

}
