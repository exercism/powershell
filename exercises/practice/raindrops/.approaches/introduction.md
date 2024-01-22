# Introduction

Raindrops exercise is a twist of the popular `FizzBuzz` problem.
There are a couple ways to solve it idiomatic in PowerShell.
You can use a series of `if` statements.
Or you can leverage the useful `switch` statement.
Or try looping through the keys of a `hashtable` and looking up the values.


## General guidance

The goal of the exercise is to check if the input number is divisible by 3, 5 and 7, or maybe none of those.
For determining that, you can use the `modulus` operator (`%`).

*Note* : The order of testing is crucial in this exercise to arrive to the correct result.

## Approach: Using `if` statements

This is the most common approach to solve this exercise.
The result string being built up by a succession of `if` statements to check of the input can be divided cleanly by 3, 5 and 7.

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

Structurely, this approach is very similar to the `if` statements approach, however the `switch` statement lead to a cleaner syntax and a straight forward path to the result.

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

For more information, check the [`hashtable` approach][approach-ordered-hashtable].


## Which approach to use?

- The if statements approach is simple and straight to the point, however it has drawback from needing to create new string every time you do string concatenation.