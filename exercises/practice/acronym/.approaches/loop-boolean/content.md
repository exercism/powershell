# Using `foreach` loop and `boolean` values

```powershell
Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    $newWord = $true
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
}
```

This approach use a flag with a `boolean` value to mark when a new word is about to begin or not.

```powershell
    $newWord = $true
```

We then loop over the characters from the input using `foreach` and `.ToCharArray()` method.
If we are about to start a new word (`true`) and the current char is a letter, then we add that letter to the result, and switch the flag to `false`.
If we are not in phase of starting a new word (`false`) and the current char match one of the delimiters, then we switch the flag to true, signify that we are ready to start a new word.

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

After the loop is finished, we call `ToUpper()` method on the result and got our acronym in all capitalized letters.

[Booleans.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_booleans)

[Foreach loop.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach)