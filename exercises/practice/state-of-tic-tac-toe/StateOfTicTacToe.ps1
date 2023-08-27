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
    $board = @(
        "XXO",
        "X  ",
        "X  "
    )
    Get-StateOfTicTacToe -Board $board
    Returns: [GameStatus]::WIN
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Board
    )
    Throw "Please implement this function"
}