Function Test-MatchingBrackets() {
    <#
    .SYNOPSIS
    Determine if all brackets inside a string paired and nested correctly.
    
    .DESCRIPTION
    Given a string containing brackets `[]`, braces `{}`, parentheses `()`, or any combination thereof, verify that any and all pairs are matched and nested correctly.
    The string may also contain other characters, which for the purposes of this exercise should be ignored.
    
    .PARAMETER Text
    The string to be verified.
    
    .EXAMPLE
    Test-MatchingBrackets("[]") => True
    Test-MatchingBrackets("[)]") => False
    #>
    [CmdletBinding()]
    Param(
        [string]$Text
    )
    Throw "Please implement this function"
}