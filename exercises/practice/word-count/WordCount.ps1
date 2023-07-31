Function Get-WordCount() {
    <#
    .SYNOPSIS
    Given a phrase, count how many time each word appear.

    .DESCRIPTION
    Count how many time each word appear in a phrase. Number in string also counted as word, and words are case insensitive.

    .PARAMETER Phrase
    The phrase to count words.

    .EXAMPLE
    Get-WordCount -Phrase "Hello, welcome to exercism!"
    Return: @{ hello = 1; welcome = 1; to = 1; exercism = 1}
    #>
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )
    Throw "Please implement this function"
}

