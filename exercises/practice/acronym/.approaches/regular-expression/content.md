# Using `regex`

```powershell
Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    (-join ([regex]::Matches($Phrase, "\p{L}+'?\p{L}*") | ForEach-Object { $_.Value[0] })).ToUpper()
}
```

This approach use the `regex` class from .NET to match potential words inside the phrase using a specific pattern.

```powershell
[regex]::Matches($Phrase, "\p{L}+'?\p{L}*")
```

The pattern match any regular word and those that have apostrophe inside it, for example `doesn't` or `Halley's` in a test case.
We then collect the matched objects and loop over them, extracting the match value first index, which is the first char of each word.

```powershell
ForEach-Object { $_.Value[0] }
```

Then we call the `-join` operator upon the collection to turn this into a string, and then call the string method `.ToUpper()` to make sure it is all in uppercase to fit with acronym behavior.

[Regex expression](https://learn.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex) for .NET