# Using `regular expression`

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

We begin by trimming the input from the end, then use it as input for the `switch` statement with `-Regex` and `-CaseSensitive` flags to start matching against patterns.
By default PowerShell will match insensitively, so the second flag is needed to check for the `yelling` condition.

```powershell
    switch -Regex -CaseSensitive ($HeyBob.TrimEnd())
```

The first case we should consider is the combined conditions of both `yelling` and `question`.
Which mean we should match for uppercase letter and space with at least one appearance, and a question martk at the end.
We break out of the `switch` statement if this got a match.

```powershell
    "^[A-Z ]+\?$"           {"Calm down, I know what I'm doing!"; break}
```

Then we can match individual cases that does not share conditions.
`silence` pattern match nothing from beginning to end,
`question` pattern match for a question mark at the end, and `yelling` match for uppercase letter.
If none of the patterns got a match, then we return the default response.

```powershell
    "^$"                    {"Fine. Be that way!"}
    "\?$"                   {"Sure."}
    "^[^a-z]*[A-Z][^a-z]*$" {"Whoa, chill out!"}
    Default                 {"Whatever."}
```

**Note : This approach is not recommended for new learners.**

[Regex.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_regular_expressions)