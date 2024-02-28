# Introduction

`Bob` is a staple exercise on Exercism, and a popular one for learners to ask for code review.
There are various ways to solve `Bob`.
A typical approach is uing multiple `if` statements to test for the conditions based on exercise's rules.
A more advanced approach involved using the `switch` statement and `regex` to match specific patterns with the given input.

## General guidance

- Consider trimming the input first, using `Trim` or `TrimEnd`.

- Avoid re-run to check for logic and conditions, turning them into `boolean` variable that could be used for later like `IsQuestion` or `IsYelling` is preferable.

- Return early with `if` statement to avoid using extra `else if` or `else`.
Consider the order of `if` statements to arrive to the correct value.

- `Switch` statement can be exit early with `break` keyword.

## Approach: `if` statements

Setting variables with `boolean` values as condition, then use `if` statements with the conditions for the result.

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

For more information, check the [`if` statements approach][approach-conditional-bools].


## Approach: `switch` statements and `regex`

Using `switch` statement along with `regex` to get the result.

```powershell
function Get-BobResponse() {
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )
    switch -Regex -CaseSensitive ($HeyBob.TrimEnd()) {
        "^[A-Z ]+\?$"           {"Calm down, I know what I'm doing!"; break}
        "^$"                    {"Fine. Be that way!"}
        "\?$"                   {"Sure."}
        "^[^a-z]*[A-Z][^a-z]*$" {"Whoa, chill out!"}
        Default                 {"Whatever."}
    }
}
```

For more information, check the [`switch` statements and `regex` approach][approach-regex-switch].

[approach-conditional-bools]: https://exercism.org/tracks/powershell/exercises/bob/approaches/conditional-bools

[approach-regex-switch]: https://exercism.org/tracks/powershell/exercises/bob/approaches/regex-switch