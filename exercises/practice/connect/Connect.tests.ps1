BeforeAll {
    . "./Connect.ps1"
}

Describe "Connect test cases" {
    It "an empty board has no winner" {
        $board = @(
            ". . . . .",
            " . . . . .",
            "  . . . . .",
            "   . . . . .",
            "    . . . . ."
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::NONE

        $got | Should -BeExactly $want
    }

    It "X can win on a 1x1 board" {
        $board = @(
            "X"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::X

        $got | Should -BeExactly $want
    }

    It "O can win on a 1x1 board" {
        $board = @(
            "O"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::O

        $got | Should -BeExactly $want
    }

    It "only edges does not make a winner" {
        $board = @(
            "O O O X",
            " X . . X",
            "  X . . X",
            "   X O O O"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::NONE

        $got | Should -BeExactly $want
    }

    It "illegal diagonal does not make a winner" {
        $board = @(
            "X O . .",
            " O X X X",
            "  O X O .",
            "   . O X .",
            "    X X O O"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::NONE

        $got | Should -BeExactly $want
    }

    It "nobody wins crossing adjacent angles" {
        $board = @(
            "X . . .",
            " . X O .",
            "  O . X O",
            "   . O . X",
            "    . . O ."
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::NONE

        $got | Should -BeExactly $want
    }

    It "X wins crossing from left to right" {
        $board = @(
            ". O . .",
            " O X X X",
            "  O X O .",
            "   X X O X",
            "    . O X ."
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::X

        $got | Should -BeExactly $want
    }

    It "O wins crossing from top to bottom" {
        $board = @(
            ". O . .",
            " O X X X",
            "  O O O .",
            "   X X O X",
            "    . O X ."
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::O

        $got | Should -BeExactly $want
    }

    It "X wins using a convoluted path" {
        $board = @(
            ". X X . .",
            " X . X . X",
            "  . X . X .",
            "   . X X . .",
            "    O O O O O"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::X

        $got | Should -BeExactly $want
    }

    It "X wins using a spiral path" {
        $board = @(
            "O X X X X X X X X",
            " O X O O O O O O O",
            "  O X O X X X X X O",
            "   O X O X O O O X O",
            "    O X O X X X O X O",
            "     O X O O O X O X O",
            "      O X X X X X O X O",
            "       O O O O O O O X O",
            "        X X X X X X X X O"
        )
        $got  = [Connect]::new($board).GetWinner()
        $want = [Winner]::X

        $got | Should -BeExactly $want
    }
}
