Enum GameStatus {
    WIN
    DRAW
    ONGOING
}

Function Get-StateOfTicTacToe() {
    <#
    .SYNOPSIS
    Implement a program that determines the state of a tic-tac-toe game.

    .DESCRIPTION
    The games is played on a 3×3 grid represent by an array of 3 strings.
    Players take turns to place `X`s and `O`s on the grid.
    The game ends:
    - when one player has won by placing three of marks in a row, column, or along a diagonal of the grid
    - when the entire grid is filled up

    In this exercise, we will assume that `X` always starts first.

    .PARAMETER Board
    An array of 3 strings represeting the board in the form of 3x3 grid.

    .EXAMPLE
    $grid = @(
        "XXO",
        "X  ",
        "X  "
    )
    Get-StateOfTicTacToe -Board $grid
    Returns: [GameStatus]::WIN
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Board
    )

    $combinedString = (-join $Board).ToCharArray() | Group-Object -AsHashTable -AsString
    $Xs    = $combinedString.X.Count
    $Os    = $combinedString.O.Count
    $empty = $combinedString.' '.Count
    
    Test-ValidBoard $Xs $Os

    if (Test-Winner $Board $Xs $Os) {
        $gameState = [GameStatus]::WIN
    }else {
        $gameState = $empty ? [GameStatus]::ONGOING : [GameStatus]::DRAW
    }
    $gameState
}

Function Test-ValidBoard($Xcount, $Ocount) {
    <#
    .DESCRIPTION
    A helper function to test if the board is valid based on count of X and O
    #>
    if (($Xcount - $Ocount) -gt 1) {
        Throw "Wrong turn order: X went twice"
    }
    if ($Ocount -gt $Xcount) {
        Throw "Wrong turn order: O started"
    }
}

Function Test-Winner($board, $Xcount, $Ocount) {
    <#
    .DESCRIPTION
    A helper function to check if there is a winner, and if the winner is in a valid state
    Winner validation logic based on the fact that X goes first
    - If X win, then X count - O count must be equal 1
    - If X win, then X count and O count must be equal
    #>
    $hasWinner = $false
    $wholeBoard = $board + (Get-Columns $board) + (Get-Diagonals $board)

    $wincon = @{
        'XXX' = {param($x,$o) ($x - $o) -eq 1 }
        'OOO' = {param($x,$o) $x -eq $o }
    }

    foreach ($pattern in $wincon.Keys) {
        if ($wholeBoard -contains $pattern) {
            $validCheck = $wincon[$pattern]
            if (& $validCheck $Xcount $Ocount) {
                $hasWinner = $true
            } else {
                Throw "Impossible board: game should have ended after the game was won"
            }
        }
    }
    $hasWinner
}

Function Get-Columns($board) {
    <#
    .DESCRIPTION
    A helper function get all the columns string, this work for any square NxN size grid
    #>
    $columns = 0..($board.Count-1) | ForEach-Object {
        $index = $_
        $col = -join ($board | ForEach-Object {$_[$index]})
        $col
    }
    $columns
}

Function Get-Diagonals($board) {
    <#
    .DESCRIPTION
    A helper function get the 2 diagonals string, this work for any square NxN size grid
    #>
    $size = $board.Count
    
    $risingDiagonal = @()
    $fallingDiagonal = @()

    for ($i = 0; $i -lt $size; $i++) {
        $risingDiagonal  += $board[$i][$i]
        $fallingDiagonal += $board[$i][$size - 1 - $i]
    }
    -join $risingDiagonal, -join $fallingDiagonal
}