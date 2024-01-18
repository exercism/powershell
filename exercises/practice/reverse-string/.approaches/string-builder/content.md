# Using `StringBuilder` class

```powershell
function ReverseString([string] $String) {
    $strBuilder = [System.Text.StringBuilder]::new()
    foreach ($i in ($String.Length - 1)..0) {
        [void] $strBuilder.Append($String[$i])
    }
    $strBuilder.ToString()
}
```

First we create a new `StringBuilder` object from .NET.
Then we loop from the last index of the string to 0, each pass we append the current char to the `StringBuilder` object.
The append method has it own output showing some metadata, to avoid this we can ether cast [void] before the expression or pipe the output into `Out-Null` to suppress it.
When the loop is finished, we called the `ToString()` method on the `StringBuilder` object.

[StringBuilder](https://learn.microsoft.com/en-us/dotnet/api/system.text.stringbuilder) class.

[Out-Null](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/out-null) cmdlet.

[ToString](https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.psobject.tostring) method.