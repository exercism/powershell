# Introduction

There are a couple of ways to solve **Acronym**.
You can use a series of `string` methods to interact with the original phrase.
You can use `regex` to match words in the phrase and interact with them.


## General guidance

The goal of this exercise is to turn a phrase into an acronym.
This being achieved by extracting the first letter of each word in the phrase, capitalize them and combine them together.


## Approach: Using `regex`

In this approach, we use `regex` ([regular expression](https://en.wikipedia.org/wiki/Regular_expression)) to match potential words in the input string, and then extract the acronym from those words.

```powershell
Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    (-join ([regex]::Matches($Phrase, "\p{L}+'?\p{L}*") | ForEach-Object { $_.Value[0] })).ToUpper()
}
```

For more information, check the [`regex` approach][approach-regular-expression].


## Approach: Using `string` methods

In this approach, we utilize many string methods to interact with the original phrase and extract the acronym from it.

```powershell
Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    ( $Phrase -replace "[-_]"," " -split " " | Foreach-Object {$_[0].ToString().ToUpper()} ) -join ""
}
```

For more information, check the [`string` methods approach][approach-string-methods].


## Approach: Using `foreach` loop and `boolean` value

In this approach, we use `foreach` loop and a flag (`boolean` value) to extract the acronym from the input.

```powershell
    foreach ($char in $Phrase.ToCharArray()) {
        if ($newWord -and $char -match "[a-z]") {
            $acronym += $char
            $newWord = $false
        }
        if (-not $newWord -and $char -match "[_\- ]") {
            $newWord = $true
        }
    }
    $acronym.ToUpper()
```

For more information, check the [`foreach` loop and `boolean` approach][approach-loop-boolean].


[approach-regular-expression]: https://exercism.org/tracks/powershell/exercises/acronym/approaches/regular-expression
[approach-string-methods]: https://exercism.org/tracks/powershell/exercises/acronym/approaches/string-methods
[approach-loop-boolean]: https://exercism.org/tracks/powershell/exercises/acronym/approaches/loop-boolean