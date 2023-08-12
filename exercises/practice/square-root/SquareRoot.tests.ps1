BeforeAll {
    . "./SquareRoot.ps1"
}

Describe "Square root test cases" {
    It "root of 1" {
        Get-SquareRoot -Radicand 1 | Should -Be 1
    }

    It "root of 4" {
        Get-SquareRoot -Radicand 4 | Should -Be 2
    }

    It "root of 25" {
        Get-SquareRoot -Radicand 25 | Should -Be 5
    }

    It "root of 81" {
        Get-SquareRoot -Radicand 81 | Should -Be 9
    }

    It "root of 196" {
        Get-SquareRoot -Radicand 196 | Should -Be 14
    }

    It "root of 65025" {
        Get-SquareRoot -Radicand 65025 | Should -Be 255
    }
}