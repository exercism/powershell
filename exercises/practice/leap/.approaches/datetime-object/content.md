# Using `DateTime` object

```powershell
function Test-Leap([int] $year) {
    (Get-Date -Year $year -Month 2 -Day 29).Month -eq 2
}
```

The main characteristic of a leap year is the second month (February) has 29 days instead of 28.
In this approach we will use `Get-Date` with : $year for `Year` parameter, 2 for `Month` Parameter, and 29 for `Day` parameter, and this will give us a `DateTime` object.
Next we access the `Month` property of this object and compare it with 2, if they are equal then the year is a leap year.
In the event of a year is not a leap year, `Get-Date` for Month 2 and Day 29 in fact return a `DateTime` object of March the 1st, which mean the `Month` property now has the value of 3.

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date) cmdlet.