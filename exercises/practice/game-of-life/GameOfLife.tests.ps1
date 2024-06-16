BeforeAll {
    . "./GameOfLife.ps1"
}

Describe "GameOfLife test cases" {
    It "empty matrix" {
        $got = Invoke-GameOfLife -Matrix @()
        $want = @()

        $got | Should -BeExactly $want
    }

    It "live cells with zero live neighbors die" {
        $got = Invoke-GameOfLife -Matrix @(
            @(0, 0, 0),
            @(0, 1, 0),
            @(0, 0, 0)
        )
        $want = @(
            @(0, 0, 0),
            @(0, 0, 0),
            @(0, 0, 0)
        )

        $got | Should -BeExactly $want
    }

    It "live cells with only one live neighbor die" {
        $got = Invoke-GameOfLife -Matrix @(
            @(0, 0, 0),
            @(0, 1, 0),
            @(0, 1, 0)
        )
        $want = @(
            @(0, 0, 0),
            @(0, 0, 0),
            @(0, 0, 0)
        )

        $got | Should -BeExactly $want
    }

    It "live cells with two live neighbors stay alive" {
        $got = Invoke-GameOfLife -Matrix @(
            @(1, 0, 1),
            @(1, 0, 1),
            @(1, 0, 1)
        )
        $want = @(
            @(0, 0, 0),
            @(1, 0, 1),
            @(0, 0, 0)
        )

        $got | Should -BeExactly $want
    }

    It "live cells with three live neighbors stay alive" {
        $got = Invoke-GameOfLife -Matrix @(
            @(0, 1, 0),
            @(1, 0, 0),
            @(1, 1, 0)
        )
        $want = @(
            @(0, 0, 0),
            @(1, 0, 0),
            @(1, 1, 0)
        )

        $got | Should -BeExactly $want
    }

    It "dead cells with three live neighbors become alive" {
        $got = Invoke-GameOfLife -Matrix @(
            @(1, 1, 0),
            @(0, 0, 0),
            @(1, 0, 0)
        )
        $want = @(
            @(0, 0, 0),
            @(1, 1, 0),
            @(0, 0, 0)
        )

        $got | Should -BeExactly $want
    }

    It "live cells with four or more neighbors die" {
        $got = Invoke-GameOfLife -Matrix @(
            @(1, 1, 1),
            @(1, 1, 1),
            @(1, 1, 1)
        )
        $want = @(
            @(1, 0, 1),
            @(0, 0, 0),
            @(1, 0, 1)
        )

        $got | Should -BeExactly $want
    }

    It "bigger matrix" {
        $got = Invoke-GameOfLife -Matrix @(
            @(1, 1, 0, 1, 1, 0, 0, 0),
            @(1, 0, 1, 1, 0, 0, 0, 0),
            @(1, 1, 1, 0, 0, 1, 1, 1),
            @(0, 0, 0, 0, 0, 1, 1, 0),
            @(1, 0, 0, 0, 1, 1, 0, 0),
            @(1, 1, 0, 0, 0, 1, 1, 1),
            @(0, 0, 1, 0, 1, 0, 0, 1),
            @(1, 0, 0, 0, 0, 0, 1, 1)
        )
        $want = @(
            @(1, 1, 0, 1, 1, 0, 0, 0),
            @(0, 0, 0, 0, 0, 1, 1, 0),
            @(1, 0, 1, 1, 1, 1, 0, 1),
            @(1, 0, 0, 0, 0, 0, 0, 1),
            @(1, 1, 0, 0, 1, 0, 0, 1),
            @(1, 1, 0, 1, 0, 0, 0, 1),
            @(1, 0, 0, 0, 0, 0, 0, 0),
            @(0, 0, 0, 0, 0, 0, 1, 1)
        )

        $got | Should -BeExactly $want
    }
}
