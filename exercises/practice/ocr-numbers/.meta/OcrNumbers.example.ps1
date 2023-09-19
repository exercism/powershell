$OCR = @{
    " _ | ||_|   " = 0
    "     |  |   " = 1
    " _  _||_    " = 2
    " _  _| _|   " = 3
    "   |_|  |   " = 4
    " _ |_  _|   " = 5
    " _ |_ |_|   " = 6
    " _   |  |   " = 7
    " _ |_||_|   " = 8
    " _ |_| _|   " = 9
    }

Function Invoke-OCR() {
    <#
    .SYNOPSIS
    Implement a function for OCR (optical character recognition) to convert it into a number.

    .DESCRIPTION
    Given a grid of pipes, underscores, and spaces, determine which number is represented, or whether it is garbled.
    Return the number string or "?" if it is garbled.

    .PARAMETER Grid
    An array of strings, each represent a row of the grid.

    .EXAMPLE
    $lines = (
        "   ",
        "  |",
        "  |",
        "   "
    )
    Convert-OCR -Grid $lines
    Return: "1"
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Grid
    )
    ValidateGrid $Grid

    # split into blocks, each block span 4 rows
    $blocks = $Grid.Count / 4
    # count how many digits per block, each digit span 3 columns
    $digits = $Grid[0].Length / 3

    if ($blocks -eq 1) {
        return ProcessOCR $Grid $digits
    }

    $blocksInfo = 0..($blocks - 1) | ForEach-Object {,$Grid[($_*4)..($_*4+3)]}
    ($blocksInfo | ForEach-Object {ProcessOCR $_ $digits}) -join ","
}

Function ProcessOCR($block, $digits) {
    <#
    .DESCRIPTION
    Helper function to process each block into a string of number
    #>
    $numStr = foreach ($digit in 0..($digits-1)) {
        $temp = ""
        foreach ($line in $block) {
            $temp += $line.Substring($digit*3,3)
        }

        $OCR.ContainsKey($temp) ? $OCR[$temp] : "?"
    }

    -join $numStr
}

Function ValidateGrid([string[]]$grid) {
    <#
    .DESCRIPTION
    Helper function to validate the grid
    #>
    if ($grid.Count % 4) {
        Throw "Number of input lines is not a multiple of four"
    }
    foreach ($line in $grid) {
        if ($line.Length % 3) {
            Throw "Number of input columns is not a multiple of three"
        }
    }
}