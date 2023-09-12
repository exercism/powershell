BeforeAll {
    . "./ResistorColorExpert.ps1"
}

Describe "ResistorColorExpert test cases" {
    Describe "Resistor Label Tests" {
        It "test orange orange black and red" {
            $got  = Get-ResistorLabel -Colors @("orange", "orange", "black", "red")
            $want = "33 ohms ±2%"

            $got | Should -BeExactly $want
        }
    
        It "test blue grey brown and violet" {
            $got  = Get-ResistorLabel -Colors @("blue", "grey", "brown", "violet")
            $want = "680 ohms ±0.1%"

            $got | Should -BeExactly $want
        }
    
        It "test red black red and green" {
            $got  = Get-ResistorLabel -Colors @("red", "black", "red", "green")
            $want = "2 kiloohms ±0.5%"

            $got | Should -BeExactly $want
        }
    
        It "test green brown orange and grey" {
            $got  = Get-ResistorLabel -Colors @("green", "brown", "orange", "grey")
            $want = "51 kiloohms ±0.05%"

            $got | Should -BeExactly $want
        }
    
        It "test one black band" {
            $got  = Get-ResistorLabel -Colors @("black")
            $want = "0 ohms"

            $got | Should -BeExactly $want
        }
    
        It "test orange orange yellow black and brown" {
            $got  = Get-ResistorLabel -Colors @("orange", "orange", "yellow", "black", "brown")
            $want = "334 ohms ±1%"

            $got | Should -BeExactly $want
        }
    
        It "test red green yellow yellow and brown" {
            $got  = Get-ResistorLabel -Colors @("red", "green", "yellow", "yellow", "brown")
            $want = "2.54 megaohms ±1%"

            $got | Should -BeExactly $want
        }
    
        It "test blue grey white red and brown" {
            $got  = Get-ResistorLabel -Colors @("blue", "grey", "white", "brown", "brown")
            $want = "6.89 kiloohms ±1%"

            $got | Should -BeExactly $want
        }
    
        It "test violet orange red and grey" {
            $got  = Get-ResistorLabel -Colors @("violet", "orange", "red", "grey")
            $want = "7.3 kiloohms ±0.05%"

            $got | Should -BeExactly $want
        }
    
        It "test brown red orange green and blue" {
            $got  = Get-ResistorLabel -Colors @("brown", "red", "orange", "green", "blue")
            $want = "12.3 megaohms ±0.25%"

            $got | Should -BeExactly $want
        }
    }
}
