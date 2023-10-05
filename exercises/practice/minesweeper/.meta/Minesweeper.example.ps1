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
        [ValidatePattern("^[\s*]*$")]
        [string[]]$Minefield
    )

    $rows = $Minefield.Count
    $cols = $Minefield[0].Length

    if (-not $rows -or -not $cols) {
        return $Minefield
    }

    $neighbors = @(
        @(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1)
    )

    $fieldArray = @($Minefield | ForEach-Object { ,$_.ToCharArray() })

    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $cols; $col++) {
            $cell = $fieldArray[$row][$col]
            if ($cell -eq " ") {
                $minesCount = Get-MineCount $fieldArray @($row, $col) $neighbors
                if ($minesCount) {
                    $fieldArray[$row][$col] = $minesCount.ToString()
                }
            }
        }
    }
    $fieldArray | ForEach-Object {$_ -join ""}
}

Function Get-MineCount {
    param (
        [object[]]$Field,
        [int[]]$Cell,
        [object[]]$Neighbors
    )
    $counter = 0
    foreach ($neighbor in $Neighbors) {
        $x = $Cell[0] + $neighbor[0]
        $y = $Cell[1] + $neighbor[1]

        if ($x -lt 0 -or $x -eq $Field.Count -or $y -lt 0) {continue} #out of bound

        if ($Field[$x][$y] -eq "*") {
            $counter++
        }
    }
    $counter
}