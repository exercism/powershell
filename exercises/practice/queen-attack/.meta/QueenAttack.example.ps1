<#
.SYNOPSIS
    Given the positions of two queens on a chess board,
    indicate whether or not they are positioned so that they can attack each other.

.DESCRIPTION
    In a chessboard represented by an 8 by 8 array, check if a queen can attack another queen based on their positions.
    In the game of chess, a queen can attack pieces which are on the same row, column, or diagonal.
    If there are no position provided, queens will be placed at their starting positions: White at bottom (7,3), Black at top (0,3).

.EXAMPLE
    #Positions provided:
    $whitePosition = @(2, 2)
    $blackPosition = @(5, 6)
    $board = [ChessBoard]::new($whitePosition, $blackPosition)
    $board.CanAttack() => False
    $board.DrawBoard()
    @"
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ W _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ B _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    "@

    #No positions provided:
    $board2 = [ChessBoard]::new()
    $board2.CanAttack() => True
    $board.DrawBoard()
    @"
    _ _ _ B _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ W _ _ _ _
    "@
#>
Class ChessBoard {
    [int[]]$White
    [int[]]$Black

    ChessBoard() {
        $this.White = @(7,3)
        $this.Black = @(0,3)
    }

    ChessBoard([int[]]$WhitePos,[int[]]$BlackPos) {
        [ChessBoard]::ValidateQueens($WhitePos, $BlackPos)
        $this.White = $WhitePos
        $this.Black = $BlackPos
    }

    static [void] ValidateQueens([int[]]$WhitePos, [int[]]$BlackPos) {
        if ($WhitePos | Where-Object {$_ -gt 7 -or $_ -lt 0 }) {
            Throw "White queen must be placed on the board"
        }
        if ($BlackPos | Where-Object {$_ -gt 7 -or $_ -lt 0 }) {
            Throw "Black queen must be placed on the board"
        }
        if (-not (Compare-Object $WhitePos $BlackPos)) {
            Throw 'Queens can not share the same space'
        }
    }

    [bool] CanAttack() {
        $row_check = $this.White[0] -eq $this.Black[0]
        $col_check = $this.White[1] -eq $this.Black[1]
        $diag_check = [Math]::Abs($this.White[0] - $this.Black[0]) -eq [Math]::Abs($this.White[1] - $this.Black[1])
        return  $row_check -or $col_check -or $diag_check
    }

    [string] DrawBoard() {
        $empty_row = @('_') * 8
        $Board = @(0..7 | ForEach-Object {,$empty_row.Clone()})
        $Board[$this.White[0]][$this.White[1]] = 'W'
        $Board[$this.Black[0]][$this.Black[1]] = 'B'
        return ($Board | ForEach-Object {$_ -join " "}) -join "`r`n"
    }
}