BeforeAll {
    . "./LineUp.ps1"
}

Describe "LineUp test cases" {
    It "format smallest non-exceptional ordinal numeral 4" {
        $got = Get-LineUp -Name "Gianna" -Number 4
        $expect = "Gianna, you are the 4th customer we serve today. Thank you!"

        $got | Should -BeExactly $expect
    }

    It "format greatest single digit non-exceptional ordinal numeral 9" {
        $got = Get-LineUp -Name "Maarten" -Number 9
        $expect = "Maarten, you are the 9th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 5" {
        $got = Get-LineUp -Name "Petronila" -Number 5
        $expect = "Petronila, you are the 5th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 6" {
        $got = Get-LineUp -Name "Attakullakulla" -Number 6
        $expect = "Attakullakulla, you are the 6th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 7" {
        $got = Get-LineUp -Name "Kate" -Number 7
        $expect = "Kate, you are the 7th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 8" {
        $got = Get-LineUp -Name "Maximiliano" -Number 8
        $expect = "Maximiliano, you are the 8th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 1" {
        $got = Get-LineUp -Name "Mary" -Number 1
        $expect = "Mary, you are the 1st customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 2" {
        $got = Get-LineUp -Name "Haruto" -Number 2
        $expect = "Haruto, you are the 2nd customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 3" {
        $got = Get-LineUp -Name "Henriette" -Number 3
        $expect = "Henriette, you are the 3rd customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format smallest two digit non-exceptional ordinal numeral 10" {
        $got = Get-LineUp -Name "Alvarez" -Number 10
        $expect = "Alvarez, you are the 10th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 11" {
        $got = Get-LineUp -Name "Jacqueline" -Number 11
        $expect = "Jacqueline, you are the 11th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 12" {
        $got = Get-LineUp -Name "Juan" -Number 12
        $expect = "Juan, you are the 12th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 13" {
        $got = Get-LineUp -Name "Patricia" -Number 13
        $expect = "Patricia, you are the 13th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 21" {
        $got = Get-LineUp -Name "Washi" -Number 21
        $expect = "Washi, you are the 21st customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 62" {
        $got = Get-LineUp -Name "Nayra" -Number 62
        $expect = "Nayra, you are the 62nd customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 100" {
        $got = Get-LineUp -Name "John" -Number 100
        $expect = "John, you are the 100th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 101" {
        $got = Get-LineUp -Name "Zeinab" -Number 101
        $expect = "Zeinab, you are the 101st customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format non-exceptional ordinal numeral 112" {
        $got = Get-LineUp -Name "Knud" -Number 112
        $expect = "Knud, you are the 112th customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }

    It "format exceptional ordinal numeral 123" {
        $got = Get-LineUp -Name "Yma" -Number 123
        $expect = "Yma, you are the 123rd customer we serve today. Thank you!"
        
        $got | Should -BeExactly $expect
    }
}
