<#
.SYNOPSIS
    Compute the result for a game of Hex / Polygon.

.DESCRIPTION
    Your goal is to build a program that given a simple representation of a board computes the winner (or lack thereof).
    Note that all games need not be "fair".
    Player 'O' plays from top to bottom, and player 'X' plays from left to right.
    
.EXAMPLE
    $board = @(
        "O O X",
        " X O X",
        "  X X O"
    )

    $game = [Connect]::new($board)
    $game.GetWinner()
    Returns: [Winner]::X
#>

Enum Winner {
    X
    O
    NONE
}

Class Connect {
    [string[]] hidden $_board
    [Winner]   hidden $_winner 
    [object[]] hidden $_neighbors
     
    Connect([string[]]$rawBoard) {
        $this._board = $rawBoard
        $this._winner = [Winner]::NONE
        $this._neighbors = @( @(0,-2), @(0, 2), @(-1,-1), @(-1, 1), @(1, 1), @(1, -1))
    }   

    [Winner] GetWinner() {
        if ($this.OWins()) {
            $this._winner = [Winner]::O
        }elseif ($this.XWins()) {
            $this._winner = [Winner]::X
        }
        return $this._winner
    }

    [bool] hidden OWins() {
        return $this.TestPath($this._board, "O")
    }

    [bool] hidden XWins() {
        $board = $this.Transpose($this._board)
        return $this.TestPath($board, "X")
    }

    [bool] hidden TestPath([string[]]$board, [string]$player) {
        $top = 0
        $bottom = $board.Count - 1

        #if the player doesnt exist in either top or bottom row, it doesnt win
        if ($board[$top] -notlike "*$player*" -or $board[$bottom] -notlike "*$player*") {
            return $false
        }

        $visited = New-Object Collections.Generic.List[string]
        $stack = New-Object System.Collections.Stack

        #add starting indices to the stack
        for ($i = 0; $i -lt $board[$top].Length; $i++) {
            if($board[$top][$i] -eq $player) {
                $stack.Push(@($top, $i))
            }
        }
        
        #dfs
        while ($stack.Count) {
            $current = $stack.Pop()

            $visited.Add(-join $current)

            if ($current[0] -eq $bottom -or $current[0] -eq -1) {
                return $true
            }

            foreach ($idxs in $this._neighbors) {
                $x = $current[0] + $idxs[0]
                $y = $current[1] + $idxs[1]

                if ($x -lt 0) {continue} #out of bound
                
                if ($board[$x][$y] -eq $player -and "$x$y" -notin $visited) {
                    $stack.Push(@($x, $y))
                }
            }
        }
        return $false
    }

    [object] hidden Transpose($board) {
        <#
        .DESCRIPTION
        Helper function to transpose the board 90 degree to the right, so finding X also work from top to bottom
        #>
        $board = $board | ForEach-Object { $_ -replace " ",""}

        $rows = ($board | Measure-Object -Maximum -Property Length).Maximum
        $cols = $board.Count
        
        $transposed = @()
        for ($row = 0; $row -lt $rows; $row++) {
            $temp = @()
            for ($col = $cols-1; $col -ge 0; $col--) {
                $temp += $board[$col][$row]
            }
            $transposed += "$(" "*($rows - $row - 1))$($temp -join " ")"
        }
        return $transposed
    }
}

