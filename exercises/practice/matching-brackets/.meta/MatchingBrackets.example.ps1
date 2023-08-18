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
    $bracketsStack = [System.Collections.Generic.List[string]]::new()
    $bracketPairs  = @{
        '(' = ')'
        '[' = ']'
        '{' = '}'
    }

    foreach ($letter in $Text.ToCharArray()) {
        $letter = $letter.ToString()
        if ($bracketPairs.ContainsKey($letter)) {
            $bracketsStack.Add($letter)
        } elseif ($bracketPairs.ContainsValue($letter)) {
            if ($bracketsStack.Count -eq 0 -or $bracketPairs[$bracketsStack[-1]] -ne $letter) {
                return $false
            }
            $bracketsStack.RemoveAt($bracketsStack.Count - 1)
        }
    }
    return $bracketsStack.Count -eq 0
}