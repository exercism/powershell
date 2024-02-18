BeforeAll {
    . "./StateOfTicTacToe.ps1"
}

Describe "StateOfTicTacToe test cases" {
    Context "won games" {
        It "Finished game where X won via left column victory" {
            $grid = @("XOO",
                      "X  ",
                      "X  ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }

        It "Finished game where X won via middle column victory" {
            $grid = @("OXO",
                      " X ",
                      " X ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via right column victory" {
            $grid = @("OOX",
                      "  X",
                      "  X")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via left column victory" {
            $grid = @("OXX",
                      "OX ",
                      "O  ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via middle column victory" {
            $grid = @("XOX",
                      " OX",
                      " O ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via right column victory" {
            $grid = @("XXO",
                      " XO",
                      "  O")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via top row victory" {
            $grid = @("XXX",
                      "XOO",
                      "O  ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via middle row victory" {
            $grid = @("O  ",
                      "XXX",
                      " O ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via bottom row victory" {
            $grid = @(" OO",
                      "O X",
                      "XXX")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via top row victory" {
            $grid = @("OOO",
                      "XXO",
                      "XX ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via middle row victory" {
            $grid = @("XX ",
                      "OOO",
                      "X  ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via bottom row victory" {
            $grid = @("XOX",
                      " XX",
                      "OOO")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via falling diagonal victory" {
            $grid = @("XOO",
                      " X ",
                      "  X")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via rising diagonal victory" {
            $grid = @("O X",
                      "OX ",
                      "X  ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via falling diagonal victory" {
            $grid = @("OXX",
                      "OOX",
                      "X O")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where O won via rising diagonal victory" {
            $grid = @("  O",
                      " OX",
                      "OXX")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via a row and a column victory" {
            $grid = @("XXX",
                      "XOO",
                      "XOO")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    
        It "Finished game where X won via two diagonal victories" {
            $grid = @("XOX",
                      "OXO",
                      "XOX")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::WIN

            $got | Should -BeExactly $want
        }
    }
    
    Context "drawn games" {
        It "draw game" {
            $grid = @("XOX",
                      "XXO",
                      "OXO")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::DRAW

            $got | Should -BeExactly $want
        }
    
        It "Another draw" {
            $grid = @("XXO",
                      "OXX",
                      "XOO")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::DRAW

            $got | Should -BeExactly $want
        }
    }
    
    Context "ongoing games" {
        It "Ongoing game: one move in" {
            $grid = @("   ",
                      "X  ",
                      "   ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::ONGOING

            $got | Should -BeExactly $want
        }
    
        It "Ongoing game: two moves in" {
            $grid = @("O  ",
                      " X ",
                      "   ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::ONGOING

            $got | Should -BeExactly $want
        }
    
        It "Ongoing game: five moves in" {
            $grid = @("X  ",
                      " XO",
                      "OX ")
            $got  = Get-StateOfTicTacToe -Board $grid
            $want = [GameStatus]::ONGOING

            $got | Should -BeExactly $want
        }
    }

    Context "invalud boards" {
        It "Invalid board: X went twice" {
            $grid = @("XX ",
                      "   ",
                      "   ")

            {Get-StateOfTicTacToe -Board $grid} | Should -Throw "*Wrong turn order: X went twice*"
        }
    
        It "Invalid board: O started" {
            $grid = @("OOX",
                      "   ",
                      "   ")

            {Get-StateOfTicTacToe -Board $grid} | Should -Throw "*Wrong turn order: O started*"
        }
    
        It "Invalid board: X won and O kept playing" {
            $grid = @("XXX",
                      "OOO",
                      "   ")

            {Get-StateOfTicTacToe -Board $grid} | Should -Throw "*Impossible board: game should have ended after the game was won*"
        }
    
        It "Invalid board: players kept playing after a win" {
            $grid = @("XXX",
                      "OOO",
                      "XOX")

            {Get-StateOfTicTacToe -Board $grid} | Should -Throw "*Impossible board: game should have ended after the game was won*"
        }
    }
}
