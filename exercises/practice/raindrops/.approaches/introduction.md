# Introduction

Raindrops exercise is a twist on the popular [`FizzBuzz`](https://en.wikipedia.org/wiki/Fizz_buzz) problem.
There are a couple ways to solve it idiomatically in PowerShell.
You can use a series of `if` statements.
Or you can leverage the useful `switch` statement.
Or try looping through the keys of a `hashtable` and looking up the values.


## General guidance

The goal of the exercise is to check if the input number is divisible by 3, 5 and 7, or maybe none of those.
For determining that, you can use the `modulus` operator (`%`).

*Note* : The order of testing is crucial in this exercise to arrive to the correct result.


## Approach: Using `if` statements

This is the most common approach to solve this exercise.
The result string is built up by a succession of `if` statements checking if the input can be divided cleanly by 3, 5, and 7.

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

For more information, check the [`if` statements approach][approach-if-statements].


## Approach: Using `switch` statement

Structurally, this approach is very similar to the `if` statements approach, however the `switch` statement leads to a cleaner syntax and a straight forward path to the result.

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

For more information, check the [`switch` statement approach][approach-switch-statement].


## Approach: Using `ordered-hashtable` and `foreach`

This approach relies on an `ordered hashtable`, looping through its keys to test for divisibility and then use those keys to look up for the values.

```powershell
function Raindrops() {
    [CmdletBinding()]
    Param(
        [int]$Number
    )
    $table = [ordered]@{
        3 = "Pling"
        5 = "Plang"
        7 = "Plong"
    }
    $sounds = foreach ($key in $table.Keys) {
        if ($Number % $key -eq 0) {
            $table.$key
        }
    }
    $sounds.Count -eq 0 ? "$Number" : -join $sounds
}
```

For more information, check the [`ordered hashtable` approach][approach-ordered-hashtable].


## Which approach to use?

- The `if` statements approach is simple and straight to the point, however it has the drawback of needing to create a new string every time you do string concatenation.

- The `ordered hashtable` approach is also quite simple, but working with `ordered hashtable` to retrieve value is quite a bit different than normal hashtable. Bracket notation is used for accessing index in this case instead of accessing key value, so dot notation is recommended.
Similar to `if` statements approach, this approach required an additional check at the end.

- The `switch` statement is the fastest of the three based on a quick benchmark run. The simplicity of the syntax and the flexibility of `switch` statement lends itself very well to solve this exercise idiomatically.


[approach-if-statements]: https://exercism.org/tracks/powershell/exercises/raindrops/approaches/if-statements
[approach-switch-statement]: https://exercism.org/tracks/powershell/exercises/raindrops/approaches/switch-statement
[approach-ordered-hashtable]: https://exercism.org/tracks/powershell/exercises/raindrops/approaches/ordered-hashtable