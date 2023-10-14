Function Invoke-MicroBlog() {
    <#
    .SYNOPSIS
    Implement a function to make micro blog post that only of 5 or less characters.

    .DESCRIPTION
    Given a string, truncate it into a string of maximum 5 characters.

    .PARAMETER Post
    A string object contains Unicode text encoding: alphabets, symbols or even emojis.

    .EXAMPLE
    Invoke-MicroBlog -Post "Lightning"
    Returns: "Light"
    #>
    [CmdletBinding()]
    Param(
        [string]$Post
    )
    # Split the input string into individual characters
    $charArray = [System.Globalization.StringInfo]::ParseCombiningCharacters($Post)
    $charList = @()

    $i = 0
    while ($charList.Count -lt 5 -and $i -lt $charArray.Length) {
        $start = $charArray[$i]
        $end = $i -lt $charArray.Length - 1 ? $charArray[$i + 1] : $Post.Length
        $character = $Post.Substring($start, $end - $start)

        # Add the character to the list
        $charList += $character
        $i++
    }
    -join $charList
}