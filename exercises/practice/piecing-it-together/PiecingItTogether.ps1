<#
.SYNOPSIS
Given partial information about a jigsaw puzzle, add the missing pieces.

.DESCRIPTION
Calculate properties of a jigsaw puzzle with given information if possible.
If not possible due to insufficient or incorrect information, the user should be notified.
Read instructions for more information and example.
#>

enum Format {
    Portrait
    Square
    Landscape
}

class JigsawPuzzle {
    [int]$Pieces
    [int]$Border
    [int]$Inside
    [int]$Rows
    [int]$Columns
    [double]$AspectRatio
    [Format]$Format

    GetData([PSCustomObject]$partialData)
    {
        Throw "Please implement this function"
    }
}
