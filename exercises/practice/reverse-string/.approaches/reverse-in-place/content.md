# Reverse (swap) in place

```powershell
function ReverseString([char[]] $String) {
    $last = $String.Count - 1
    $mid  = [Math]::Ceiling($String.Count / 2)
    for ($i = 0; $i -lt $mid; $i++) {
        $String[$i], $String[$last - $i] = $String[$last - $i], $String[$i]
    }
    -join $String
}
```

This is another approach dealing with char array, so to cheat here a bit, first let cast the string into an array of char straight from parameter.
To reverse an array here, what essentially happen is that we swap the values of the first and last indices, travelling inward up to the middle index of the array.
For this method, we use a for loop to loop from 0 to the middle index, and for each step of the loop we swap values.
After the loop has completed, use `-join` operator to concatenate this char array back into one single string.

Visualize here:
```
[1,2,3,4,5] <- original array, 3 is the middle

 v       v
[5,2,3,4,1] <- first pass

   v   v
[5,4,3,2,1] <- second pass, array got reversed
```

[For](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_for) loop.