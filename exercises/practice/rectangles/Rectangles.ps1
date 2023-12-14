Function Get-Rectangles() {
    <#
    .SYNOPSIS
    Count the rectangles in an ASCII diagram.

    .DESCRIPTION
    Given an ASCII diagram, count all the rectangles exist in it.
    A complete rectangle should have 4 corners and 4 valid sides.
    Example of possilbe sides:
    Valid: "+--+", "++"
    Invalid: "+--  +", "-+"

    .PARAMETER Strings
    An array of string that represent an ASCII diagram.
    You may assume that the input is always a proper rectangle (every string in the array has equal length).
    
    .EXAMPLE
    $diagram = @(
        "+-+-+",
        "+-+-+"
    )

    Get-Rectangles -Strings $diagram
    Returns: 3
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Strings
    )
    Throw "Please implement this function"
}