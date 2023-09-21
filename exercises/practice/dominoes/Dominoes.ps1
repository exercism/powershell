Function Test-DominoesChain() {
    <#
    .SYNOPSIS
    Implement a function to test if a dominoes chain can be made.

    .DESCRIPTION
    Given a list of dominoes, check to see if they can form a chain.
    A correct chain mean the dots on one half of a stone match the dots on the neighboring half of an adjacent stone,
    and that dots on the halves of the stones which don't have a neighbor (the first and last stone) match each other.

    .PARAMETER Dominoes
    A list of 2-elements arrays, each array represent a domino.

    .EXAMPLE
    Test-DominoesChain -Dominoes @( @(1, 5), @(5, 6), @(6, 1))
    Return: true
    #>
    [CmdletBinding()]
    Param(
        [Collections.Generic.List[int[]]]$Dominoes
    )
}
