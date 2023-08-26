Function Invoke-Tournament {
    <#
    .SYNOPSIS
    Tally the results of a small football competition.

    .DESCRIPTION
    Given an array of string containing which team played against which and what the outcome was, create a tally table.

    .PARAMETER Results
    An array of the string, each line represent a match being played and its outcome.

    .EXAMPLE
    Invoke-Tournament -Results @("Annalyn;Elyses;win")
    
    return:
    @"
    Team                           | MP |  W |  D |  L |  P
    Annalyn                        |  1 |  1 |  0 |  0 |  3
    Elyses                         |  1 |  0 |  0 |  1 |  0
    "@
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Results
    )
    Throw "Please implement this function"
}
