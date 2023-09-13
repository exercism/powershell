$scoreValues = @{
    'A' = 1;'E' = 1;'I' = 1;'O' = 1;'U' = 1;'L' = 1;'N' = 1;'R' = 1;'S' = 1;'T' = 1
    'D' = 2;'G' = 2
    'B' = 3;'C' = 3;'M' = 3;'P' = 3
    'F' = 4;'H' = 4;'V' = 4;'W' = 4;'Y' = 4
    'K' = 5
    'J' = 8;'X' = 8
    'Q' = 10;'Z' = 10
}

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
    $score = 0
    $Word.ToUpper().ToCharArray() | ForEach-Object { $score += $scoreValues[[string]$_]}
    if($Bonus) {$score *= 2}
    $score
}