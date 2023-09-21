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
    Throw "Please implement this function"
}
