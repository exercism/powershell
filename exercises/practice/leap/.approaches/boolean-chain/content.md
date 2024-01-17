# Using `Boolean` chain

```powershell
function Test-Leap([int] $year) {
    $year % 4 -eq 0 -and $year % 100 -ne 0 -or $year % 400 -eq 0
}
```

One of the most common approach to solve this exercise based on the given information.
First we test if the year is divisible by 4 using modulus, if it return `false` here then the chain is short circuit and return `false`.
If the year is indeed divisible by 4, then we test whether it can't divisible by 100 or can divisible by 400.
If one of those condition return `true` then our chain will return `true`, but if both return `false` then our chain here will return `false`.

You can visualize the chain like this:

|divisible by 4          | not divisible by 100 | divisible by 400   |          |
|------------------------|----------------------|--------------------|----------|
|false (short circuit)   |                      |                    | => false |
|true                    |either this is true   | or this to be true | => true  |
|true                    |   false              |   false            | => false |

[Arithmetic operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators)