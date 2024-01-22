# Using `if` statements

```powershell
function Raindrops() {
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    $sounds = ""
    if ($Number % 3 -eq 0) {$sounds += "Pling"}
    if ($Number % 5 -eq 0) {$sounds += "Plang"}
    if ($Number % 7 -eq 0) {$sounds += "Plong"}
    $sounds.Length -eq 0 ? "$Number" : $sounds
}
```

A very standard approach to solve the exercise.
Using `if` statements to test divisibility of the input vs `3`, `5` and `7`.
If the test turn out to be `true`, then the result got concatenated with the designated string.
If none of the tests triggered to be true, then the result string stay empty.
The final ternary operation test if the result string to be empty, if so it would return the original input number as a string.

[If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if) statement.