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
        [ValidatePattern("^[\s*]*$")]
        [string[]]$Garden
    )

    $rows = $Garden.Count
    $cols = $Garden[0].Length

    if (-not $rows -or -not $cols) {
        return $Garden
    }

    $neighbors = @(
        @(-1, -1), @(-1, 0), @(-1, 1), @(0, -1), @(0, 1), @(1, -1), @(1, 0), @(1, 1)
    )

    $fieldArray = @($Garden | ForEach-Object { ,$_.ToCharArray() })

    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $cols; $col++) {
            $cell = $fieldArray[$row][$col]
            if ($cell -eq " ") {
                $flowerCount = Get-FlowerCount $fieldArray @($row, $col) $neighbors
                if ($flowerCount) {
                    $fieldArray[$row][$col] = $flowerCount.ToString()
                }
            }
        }
    }
    $fieldArray | ForEach-Object {$_ -join ""}
}

Function Get-FlowerCount {
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