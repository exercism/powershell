Function Get-BestHand() {
    <#
    .SYNOPSIS
    Pick the best hand(s) from a list of poker hands.

    .DESCRIPTION
    Given an array of poke hands, pick out the best (highest value) hand(s) and return them in an array.

    .PARAMETER Hands
    An array of string(s), each representing a poker hand.

    .EXAMPLE
    Get-BestHand -Hands @("AS QS KS 10S JS", "JS AH QD 10S KC")
    Return: @("AS QS KS 10S JS")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Hands
    )
    Throw "Please implement this function"
}