BeforeAll {
    . ".\PascalsTriangle.ps1"
}

Describe "PascalsTriangleTests" {
	It "zero rows" {
        $got = Get-PascalsTriangleRows -Count 0
        $want = @()

        $got | Should -Be $want
	}

    It "single row" {
        $got = Get-PascalsTriangleRows -Count 1
        $want = @(
            @(1)
        )

        $got | Should -Be $want
    }

    It "two rows" {
        $got = Get-PascalsTriangleRows -Count 2
        $want = @(
            @(1),
            @(1, 1)
        )

        $got | Should -Be $want
    }

    It "three rows" {
        $got = Get-PascalsTriangleRows -Count 3
        $want = @(
            @(1),
            @(1, 1),
            @(1, 2, 1)
        )

        $got | Should -Be $want
    }

    It "four rows" {
        $got = Get-PascalsTriangleRows -Count 4
        $want = @(
            @(1),
            @(1, 1),
            @(1, 2, 1),
            @(1, 3, 3, 1)
        )

        $got | Should -Be $want
    }

    It "five rows" {
        $got = Get-PascalsTriangleRows -Count 5
        $want = @(
            @(1),
            @(1, 1),
            @(1, 2, 1),
            @(1, 3, 3, 1),
            @(1, 4, 6, 4, 1)
        )

        $got | Should -Be $want
    }

    It "six rows" {
        $got = Get-PascalsTriangleRows -Count 6
        $want = @(
            @(1),
            @(1, 1),
            @(1, 2, 1),
            @(1, 3, 3, 1),
            @(1, 4, 6, 4, 1),
            @(1, 5, 10, 10, 5, 1)
        )

        $got | Should -Be $want
    }

    It "ten rows" {
        $got = Get-PascalsTriangleRows -Count 10
        $want = @(
            @(1),
            @(1, 1),
            @(1, 2, 1),
            @(1, 3, 3, 1),
            @(1, 4, 6, 4, 1),
            @(1, 5, 10, 10, 5, 1),
            @(1, 6, 15, 20, 15, 6, 1),
            @(1, 7, 21, 35, 35, 21, 7, 1),
            @(1, 8, 28, 56, 70, 56, 28, 8, 1),
            @(1, 9, 36, 84, 126, 126, 84, 36, 9, 1)
        )

        $got | Should -Be $want
    }
}
