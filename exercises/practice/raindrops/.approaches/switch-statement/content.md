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
```powershell
$sounds = switch (0){
    ($Number % 3) {"Pling"}
    ($Number % 5) {"Plang"}
    ($Number % 7) {"Plong"}
}
```
And if none of those conditions are true, the default value will be the original number.
```powershell
#Other matches
Default {$Number}
```
Then you just call the `-join` operator at the end to get the result.
```powershell
-join $sounds
```
This approach doesn't need an additional check at the end to see if the result is "empty" or not because it leverage the default behavior of `switch` statement.


[Switch](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch) statement.