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

This approach loops through an `ordered hashtable`'s keys.
If the input number is divisible by a key, retrieve the string associated with the key from the hashtable.
The loop can be assigned to a variable to represent the final collection of sounds.
```powershell
$sounds = foreach ($key in $table.Keys) {
        if ($Number % $key -eq 0) {
            $table.$key
        }
    }
```
If the collection is empty at the end, return the original number as string.
```powershell
$sounds.Count -eq 0 ? "$Number" : -join $sounds
```

[foreach](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach) loop.

[Hashtable](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables) data structure.