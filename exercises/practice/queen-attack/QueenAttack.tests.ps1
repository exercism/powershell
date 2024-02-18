BeforeAll {
    . "./QueenAttack.ps1"
}

Describe "Queen Attack Test Cases" {
    Context "Passing tests" {
        It "queen with a valid position" {
            $board  = [ChessBoard]::new(@(2, 2), @(5, 6))
            $got    = $board.White
            $want   = @(2, 2)

            $got | Should -BeExactly $want
        }

        It "can not attack" {
            $board  = [ChessBoard]::new(@(2, 2), @(5, 6))
            $got    = $board.CanAttack()
            $want   = $false

            $got | Should -BeExactly $want
        }

        It "can attack on same row" {
            $board  = [ChessBoard]::new(@(2, 3), @(2, 6))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on same column" {
            $board  = [ChessBoard]::new(@(2, 4), @(6, 4))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on first diagonal" {
            $board  = [ChessBoard]::new(@(0, 3), @(4, 7))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on second diagonal" {
            $board  = [ChessBoard]::new(@(2, 2), @(6, 6))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on third diagonal" {
            $board  = [ChessBoard]::new(@(2, 2), @(3, 1))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on fourth diagonal" {
            $board  = [ChessBoard]::new(@(1, 7), @(0, 6))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "can attack on max distance diagonal" {
            $board  = [ChessBoard]::new(@(0, 0), @(7, 7))
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" {
            $board  = [ChessBoard]::new(@(4, 1), @(2, 5))
            $got    = $board.CanAttack()
            $want   = $false

            $got | Should -BeExactly $want
        }

        It "queens are in starting positions are valid" {
            $board  = [ChessBoard]::new()
            $got    = -join ($board.White + $board.Black)
            $want   = '7303'

            $got | Should -BeExactly $want
        }

        It "queens at starting position can always attack" {
            $board  = [ChessBoard]::new()
            $got    = $board.CanAttack()
            $want   = $true

            $got | Should -BeExactly $want
        }

        It "draw board queens can attack" {
            $board  = [ChessBoard]::new(@(1,1), @(6,6))
            $got    = $board.DrawBoard()
            $want   = ( '_ _ _ _ _ _ _ _',
                        '_ W _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ B _',
                        '_ _ _ _ _ _ _ _') -join "`r`n"

            $got | Should -BeExactly $want
        }

        It "draw board queens can not attack" {
            $board  = [ChessBoard]::new(@(6,4), @(1,2))
            $got    = $board.DrawBoard()
            $want   = ( '_ _ _ _ _ _ _ _',
                        '_ _ B _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ W _ _ _',
                        '_ _ _ _ _ _ _ _') -join "`r`n"

            $got | Should -BeExactly $want
        }

        It "draw board queens at their starting position" {
            $board  = [ChessBoard]::new()
            $got    = $board.DrawBoard()
            $want   = ( '_ _ _ B _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ _ _ _ _ _',
                        '_ _ _ W _ _ _ _') -join "`r`n"

            $got | Should -BeExactly $want
        }
    }

    Context "Invalid inputs" {
        It "queen must have positive row" {
            { [ChessBoard]::new(@(-2,3), @(1,4)) } | Should -Throw "*White queen must be placed on the board*"
        }

        It "queen must have row on board" {
            { [ChessBoard]::new(@(3,3), @(8,4)) }  | Should -Throw "*Black queen must be placed on the board*"
        }

        It "queen must have positive column" {
            { [ChessBoard]::new(@(3,-1), @(5,2)) } | Should -Throw "*White queen must be placed on the board*"
        }

        It "queen must have column on board" {
            { [ChessBoard]::new(@(3,2), @(4,9)) }  | Should -Throw "*Black queen must be placed on the board*"
        }

        It "queens can't occupy same space" {
            { [ChessBoard]::new(@(1,1), @(1,1)) }  | Should -Throw "*Queens can not share the same space*"
        }
    }
}