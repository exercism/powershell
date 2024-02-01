# Using `IsLeapYear` method

```powershell
function Test-Leap([int] $year) {
    [DateTime]::IsLeapYear($year)
}
```

Utilizing the `DateTime` class from .NET, you can determine if a year is a leap year or not by passing it into the `IsLeapYear` static method.
This might not be the intended approach for learning, but it is an idiomatic way to check if a year is leap or not.

[IsLeapYear](https://learn.microsoft.com/en-us/dotnet/api/system.datetime.isleapyear) method.