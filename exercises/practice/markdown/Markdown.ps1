Function Invoke-Parser {
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

    $lines = $markdown -split '\\n'
    $result = ""
    $inList = $false

    $strongPattern = "(.*)(__)(.+)(__)(.*)"
    $italicPattern = "(.*)(_)(.+)(_)(.*)"

    foreach ($line in $lines) {
        if ($line.StartsWith("#")){
            if ($Line.StartsWith("# ")) {
                $content = $Line.Substring(2)
                $Line = "<h1>$content</h1>"
            }elseif ($Line.StartsWith("## ")) {
                $content = $Line.Substring(3)
                $Line = "<h2>$content</h2>"
            }elseif ($Line.StartsWith("### ")) {
                $content = $Line.Substring(4)
                $Line = "<h3>$content</h3>"
            }elseif ($Line.StartsWith("#### ")) {
                $content = $Line.Substring(5)
                $Line = "<h4>$content</h4>"
            }elseif ($Line.StartsWith("##### ")) {
                $content = $Line.Substring(6)
                $Line = "<h5>$content</h5>"
            }elseif ($Line.StartsWith("###### ")) {
                $content = $Line.Substring(7)
                $Line = "<h6>$content</h6>"
            }else {
                $Line = "<p>$Line</p>"
            }
        }elseif ($line.StartsWith("* ")) {
            if (-not $inList) {
                $line = $line.Substring(2)
                if ($line -match $strongPattern){
                    $open  = "<strong>"
                    $close = "</strong>"
                    $text = $Matches[3]
                    $line = $Matches[1] + $open + $text + $close + $Matches[5]
                }
                if ($line -match $italicPattern){
                    $open  = "<em>"
                    $close = "</em>"
                    $text = $Matches[3]
                    $line = $Matches[1] + $open + $text + $close + $Matches[5]
                }
                $line = "<ul><li>$line</li>"
                $inList = $true
            }else {
                $line = $line.Substring(2)
                if ($line -match $strongPattern){
                    $open  = "<strong>"
                    $close = "</strong>"
                    $text = $Matches[3]
                    $line = $Matches[1] + $open + $Matches[3] + $close + $Matches[5]
                }
                if ($line -match $italicPattern){
                    $open  = "<em>"
                    $close = "</em>"
                    $text = $Matches[3]
                    $line = $Matches[1] + $open + $Matches[3] + $close + $Matches[5]
                }
                $line = "<li>$line</li>"
            }
        }else {
            if ($line -match $strongPattern){
                $open  = "<strong>"
                $close = "</strong>"
                $text = $Matches[3]
                $line = $Matches[1] + $open + $Matches[3] + $close + $Matches[5]
            }
            if ($line -match $italicPattern){
                $open  = "<em>"
                $close = "</em>"
                $text = $Matches[3]
                $line = $Matches[1] + $open + $Matches[3] + $close + $Matches[5]
            }
            $line = "<p>" + $line + "</p>"

            if($inList) {
                $line = "</ul>$line"
                $inList = $false
            }
        }
        $result += $line
    }

    if ($inList) {
        $result += "</ul>"
    }
    return $result
}