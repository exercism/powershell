using namespace System.Collections.Generic
using namespace System.Text

enum Status {
    Finished
    Loop
}

Function Invoke-Camicia() {
    <#
    .SYNOPSIS
    Simulate a game very similar to the classic card game Camicia.

    .DESCRIPTION
    Given two hands of cards, simulate a game (similar to Camicia) until it ends (or detect if it is in a loop).
    Read instruction for rules and game example.

    .PARAMETER PlayerA
    An array of string(s) represents the first player's cards.

    .PARAMETER PlayerB
    An array of string(s) represents the second player's cards.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$PlayerA,
        [string[]]$PlayerB
    )
    Throw "Please implement this function"
}
