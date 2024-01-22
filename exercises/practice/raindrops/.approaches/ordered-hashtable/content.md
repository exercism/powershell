# Using `ordered-hashtable` and `foreach`

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

This approach loop through an ordered `hashtable`'s keys.
If the input number is divisible against a key, then use that key to look up the specific string in the `hashtable`.
The loop can be assign into a variable to represent the final collection.
If the collect is empty at the end, return the original number as string.


[foreach](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach) loop.
[Hashtable](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables) data structure.