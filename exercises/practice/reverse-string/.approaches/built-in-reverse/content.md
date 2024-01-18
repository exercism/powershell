# Using `reverse` built-in method

```powershell
function ReverseString([string] $String) {
    $charArray = $String.ToCharArray()
    [Array]::Reverse($charArray)
    -join $charArray
}
```

First, we turn the string into an array of chars.
Then, we pass the char array into the static method `Reverse` of the class `Array` from .NET.
Finally, we use `-join` to concatenate this char array back into one single string.

[Array.Reverse](https://learn.microsoft.com/en-us/dotnet/api/system.array.reverse) method.