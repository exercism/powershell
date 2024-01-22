# Using `switch` statement

```powershell
function Raindrops() {
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    $sounds = switch (0) {
        ($Number % 3) {"Pling"}
        ($Number % 5) {"Plang"}
        ($Number % 7) {"Plong"}
        Default {$Number}
    }
    -join $sounds
}
```

This approach is similar to the `if` statements.
The value `0` is used to match if the input number is divisible for `3`, `5` and `7`.
And if none of those give a match then the default will be the original number.
Then you just call the `-join` operator at the end to get the result.
This approach doesn't need an additional check at the end to see if the result is "empty" or not because it leverage the default behavior of `switch` statement.


[Switch](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch) statement.