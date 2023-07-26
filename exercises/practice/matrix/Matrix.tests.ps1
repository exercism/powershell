BeforeAll {
    . ".\Matrix.ps1"
}

Describe "Matrix Tests" {
    It "extract row from one number matrix" {
        $got = Invoke-Row -String "1" -Index 1
        $want = @(1)

        $got | Should -Be $want
    }

    It "extract row from matrix" {
        $got = Invoke-Row -String "1 2`n3 4" -Index 2
        $want = @(3, 4)

        $got | Should -Be $want
    }

    It "extract row where numbers have different widths" {
        $got = Invoke-Row -String "1 2`n10 20" -Index 2
        $want = @(10, 20)

        $got | Should -Be $want
    }

    It "can extract row from non-square matrix with no corresponding column" {
        $got = Invoke-Row -String "1 2 3`n4 5 6`n7 8 9`n8 7 6" -Index 4
        $want = @(8, 7, 6)

        $got | Should -Be $want
    }

    It "extract column from one number matrix" {
        $got = Invoke-Column -String "1" -Index 1
        $want = @(1)

        $got | Should -Be $want
    }

    It "extract column from matrix" {
        $got = Invoke-Column -String "1 2 3`n4 5 6`n7 8 9" -Index 3
        $want = @(3, 6, 9)

        $got | Should -Be $want
    }

    It "can extract column from non-square matrix with no corresponding row" {
        $got = Invoke-Column -String "1 2 3 4`n5 6 7 8`n9 8 7 6" -Index 4
        $want = @(4, 8, 6)

        $got | Should -Be $want
    }

    It "extract column where numbers have different widths" {
        $got = Invoke-Column -String "89 1903 3`n18 3 1`n9 4 800" -Index 2
        $want = @(1903, 3, 4)

        $got | Should -Be $want
    }
}
