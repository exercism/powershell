# Introduction

There are various ways to solve **leap**.
You can use a chain of Boolean expressions to tests for conditions.
You can use a datetime object and test for condition of the month.
Or you can "cheat" and use the built-in function.


## General guidance

The goal of this exercise is to check if a year is a leap year by testing if it is divisible by `4`, `100` and `400`.


## Approach: Using `Boolean` chain

This is the most common approach to solve this exercise, based exactly on the conditions to validate a leap year.
It utilize chaining `Boolean` values from tesing the divisibility of the year by `4`, `100` and `400` using modulus operator (`%`).

```powershell
function Test-Leap([int] $year) {
    $year % 4 -eq 0 -and $year % 100 -ne 0 -or $year % 400 -eq 0
}
```

For more information, check the [`Boolean` chain approach][approach-boolean-chain].


## Approach: Using `DateTime` object

We know for a fact that in a leap year, the second month (February) has 29 days.
For this approach we leverage this fact along with the cmdlet `Get-Date` to interact with a datetime object.

```powershell
function Test-Leap([int] $year) {
    (Get-Date -Year $year -Month 2 -Day 29).Month -eq 2
}
```

For more information, check the [`DateTime` object approach][approach-datetime-object].


## Approach: Using `IsLeapYear` method

Using the `DateTime` class, we can just utilize the built-in `IsLeapYear` static method and check if a year is leap or not.

```powershell
function Test-Leap([int] $year) {
    [DateTime]::IsLeapYear($year)
}
```

For more information, check the [`IsLeapYear` method approach][approach-built-in-method].


## Which approach to use?

- The chain of boolean expressions should be the most efficient, as it proceeds from the most to least likely conditions and takes advantage of short-circuiting. It has a maximum of three checks. It is the fastest approach when testing a year that is not evenly divisible by 100 that is not a leap year. Since most years fit those conditions, it is overall the most efficient approach.

- For idiomatic and convenience while coding, consider using the built-int `IsLeapYear` method despite it seems to be a "cheat" for the purpose of learning here.