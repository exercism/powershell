# Using `range` operator and `-join`

```powershell
function ReverseString([string] $String) {
    -join $String[$String.Length..0]
}
```

Using `range` from `$String.Length..0`, we created a range of indices from the length down to 0.
Apply the range to the string give us an array of object, in this case an array of char in reverse order of the original string.
Then we use `-join` to concatenate these character back into a single string, effectively reversing the input string.

*Note* : Technically speaking the valid range is from `($String.Length-1)..0` due to the nature of 0 based index.
However PowerShell is forgiving in these cases, and this convient feature allows simplified code, making it more concise and readable.
Whenever you need precise range of indices, make sure to use the correct range.

[Range](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators) operator.

[Join](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_join?view) operator.