# Using `if` and `boolean` values

```powershell
function Get-BobResponse() {
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )
    $Greet = $HeyBob.TrimEnd()

    $IsSilence  = -not $Greet.Length
    $IsQuestion = $Greet[-1] -eq '?'
    $IsYelling  = $Greet.ToUpper() -ceq $Greet -and $Greet -match "[A-Za-z]"

    if ($IsSilence) { return "Fine. Be that way!" }
    if ($IsQuestion) {
        if ($IsYelling) { return "Calm down, I know what I'm doing!" }
        return "Sure."
    }
    if ($IsYelling) {return "Whoa, chill out!" }
    "Whatever."
}
```

First, we remove all the spaces at the end of the string, this will help further operations easier to perform.

```powershell
    $Greet = $HeyBob.TrimEnd()
```

Now, we understand that the logic of the exercise is mainly based on three different conditions : `silence`, `yelling` or `question`.
So we created three variable that will return a boolean value after their evaluation.

`IsSilence` : we test if the string has any length (the previous trim operation helped facilitate this).

`IsQuestion` : we test if the last character of the string is a question mark (the previous trim operation helped facilitate this).

`IsYelling` : we test if the string stay the same after turning uppercase, and if the string has any letter inside it.
The second part is crucial, because for example "1 2 3 4" to uppercase is still the same however it is not considered as a proper yelling response.

```powershell
    $IsSilence  = -not $Greet.Length
    $IsQuestion = $Greet.EndsWith('?')
    $IsYelling  = $Greet.ToUpper() -ceq $Greet -and $Greet -match "[A-Za-z]"
```

Lastly, it is just a matter of using `if` combine with the conditions based on the rules to return the correct response.
Since there are some overlap conditions between some responses, a correct order of `if` statements and the return values is important.
In this case either `IsQuestion` or `IsYelling` should be below the combination of `IsQuestion` and `IsYelling`.

```powershell
    if ($IsSilence) { return "Fine. Be that way!" }
    if ($IsQuestion) {
        if ($IsYelling) { return "Calm down, I know what I'm doing!" }
        return "Sure."
    }
    if ($IsYelling) {return "Whoa, chill out!" }
    "Whatever."
```

[If statement.](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if)

[Boolean.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_booleans)