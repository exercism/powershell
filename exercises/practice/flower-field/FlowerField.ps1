Function Get-Annotate() {
    <#
    .SYNOPSIS
    Add the flower counts to a completed Flower Field board.

    .DESCRIPTION
    Flower Field is a popular game where the user has to find the flowers using numeric hints that indicate how many flowers are directly adjacent (horizontally, vertically, diagonally) to a square.

    In this exercise you have to create some code that counts the number of flowers adjacent to a given empty square and replaces that square with the count.

    The board is a rectangle composed of blank space (' ') characters.
    A flower is represented by an asterisk (`*`) character.

    If a given space has no adjacent flowers at all, leave that square blank.

    .PARAMETER Garden
    An array of string, each representing a row of the garden.
    This parameter should be validated to check that only blank spaces and asterisks are in it.

    .EXAMPLE
    Get-Annotate Garden @(" *** ")
    Returns: @("1***1")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Garden
    )
    Throw "Please implement this function"
}