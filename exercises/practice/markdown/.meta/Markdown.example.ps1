Function Invoke-Parser() {
    <#
    .SYNOPSIS
    Refactor a Markdown parser.

    .DESCRIPTION
    The markdown exercise is a refactoring exercise.
    There is code that parses a given string with [Markdown syntax][markdown] and returns the associated HTML for that string.
    Even though this code is confusingly written and hard to follow, somehow it works and all the tests are passing!
    Your challenge is to re-write this code to make it easier to read and maintain while still making sure that all the tests keep passing.

    .PARAMETER Markdown
    A string of markdown text to be parsed into HTML.

    .EXAMPLE
    Invoke-Parser -Markdown "__Exercism__ is awesome"
    Returns: "<p><strong>Exercism</strong> is awesome</p>"
    #>
    [CmdletBinding()]
    Param(
        [string]$Markdown
    )

    $regexes = @{
        Strong = "__(.*?)__"
        Italic = "_(.*?)_"
        Header = "^(#{1,6}) (.+)"
        UList  = "^(\*) (.+)"
    }

    $lines = $Markdown -split "\\n"
    $inList  = $false
    $result = @()

    function CloseListTag($result, $inList) {
        if ($inList) {
            $result += "</ul>"
            $inList = $false
        }
        $result, $inList
    }
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i] -replace $regexes.Strong, '<strong>$1</strong>' -replace $regexes.Italic, '<em>$1</em>'
        if ($line -match $regexes.Header) {
            $result, $inList = CloseListTag $result $inList
            $count = $Matches[1].Length
            $content = $Matches[2]
            $result += "<h$count>$content</h$count>"
        }elseif ($line -match $regexes.UList) { 
            if (-not $inList) { #Start ul tag 
                $result += "<ul>"
                $inList = $true
            }
            $content = $Matches[2]
            $result += "<li>$content</li>"
        }else {
            $result, $inList = CloseListTag $result $inList
            $result += "<p>$line</p>"
        }
    }
    $result, $_ = CloseListTag $result $inList
    -join $result
}