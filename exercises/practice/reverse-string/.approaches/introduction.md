# Introduction

Reversing a string is quite a common problem in programming, there are many ways to achieve it in PowerShell.
We can use a built-in `reverse` method for array.
We can use `StringBuilder` object to create a new string.
Or we can manipulate the char array before returning it into the reversed string.


## General guidance

String is an immutable datatype, to reverse a string basically mean creating a new string.
The most common way to create a new string without hardcoding it is to call the `-join` operator on an array of strings/chars (without argument follow it will default to empty space).
You can also build up a string by concatenation, using `StringBuilder` or call the `ToString()` method, each have their own behavior and trade off.


## Approach: Using `range` operator and `-join`

This is a short and idiomatic solution.
Creating a char array by appling the range operator with reverse index to the string, then simply join the array.

```powershell
function ReverseString([string] $String) {
    -join $String[$String.Length..0]
}
```

For more information, check the [Reverse in place approach][approach-join-range-operator].


## Approach: Using `reverse` built-in method

This is an easy way to achieve what we need with a buit-in method from .NET class [Array].

```powershell
function ReverseString([string] $String) {
    $charArray = $String.ToCharArray()
    [array]::Reverse($charArray)
    -join $charArray
}
```

For more information, check the [`reverse` approach][approach-built-in-reverse].


## Approach: Using `StringBuilder` class

Utilizing `StringBuilder` class from .NET to build a new string by appending chars from the end of the original string.

```powershell
function ReverseString([string] $String) {
    $strBuilder = [System.Text.StringBuilder]::new()
    foreach ($i in ($String.Length - 1)..0) {
        [void] $strBuilder.Append($String[$i])
    }
    $strBuilder.ToString()
}
```

For more information, check the [`StringBuilder` approach][approach-built-in-reverse].


## Approach: Reverse (swap) in place

Recognizing that reversing a string (in this case a char array), meaning we only need to swap the values of the first half to the values of the second half by the corresponding indices.

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

For more information, check the [Reverse in place approach][approach-reverse-in-place].


## Which approach to use?

Based on preliminary benchmark run, the `range` operator with `-join` is the fastest. So consider that approach for the concise code and efficiency.


