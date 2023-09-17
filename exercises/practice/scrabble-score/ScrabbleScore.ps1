Function Get-ScrabbleScore() {
    <#
    .SYNOPSIS
    Given a word, compute the Scrabble score for that word.

    .DESCRIPTION
    Take a string and return an integer value as score based on the values of letters.
    If the word landed on a bonus, double the point for that word.

    Letter                           Value
    A, E, I, O, U, L, N, R, S, T       1
    D, G                               2
    B, C, M, P                         3
    F, H, V, W, Y                      4
    K                                  5
    J, X                               8
    Q, Z                               10

    .PARAMETER Word
    The string to calculate scrabble score.

    .PARAMETER Bonus
    A boolean value that activate the bonus point if present.

    .EXAMPLE
    Get-ScrabbleScore -Word "Hello"
    Return: 8
    #>
    [CmdletBinding()]
    Param(
        [string]$Word,
        [switch]$Bonus
    )
    Throw "Please implement this function"
}