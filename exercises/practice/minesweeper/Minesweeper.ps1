Function Get-Annotate() {
    <#
    .SYNOPSIS
    Add the mine counts to a completed Minesweeper board.

    .DESCRIPTION
    Minesweeper is a popular game where the user has to find the mines using numeric hints that indicate how many mines are directly adjacent (horizontally, vertically, diagonally) to a square.

    In this exercise you have to create some code that counts the number of mines adjacent to a given empty square and replaces that square with the count.

    The board is a rectangle composed of blank space (' ') characters.
    A mine is represented by an asterisk (`*`) character.

    If a given space has no adjacent mines at all, leave that square blank.

    .PARAMETER Minefield
    An array of string, each represent a row of the minefield.
    This parameter should be validated to check that only blank space and asterisk are in it.

    .EXAMPLE
    Get-Annotate -Minefield @(" *** ")
    Returns: @("1***1")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Minefield
    )
    Throw "Please implement this function"
}