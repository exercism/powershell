# About

## Booleans

PowerShell has the [`bool`][booleans] type to represents true and false values.
In this type there are only two values: `True` and `False`.
You can bind these values to variables with the prefix `$`:

```powershell
> $TrueVar  = $true
> $FalseVar = $FALSE
#Case senstitivity doesn't matter here
```

We can use [logical operators][logical-operators] like `-and`, `-or`, and `-not` to combine and evaluate Boolean expressions.

```powershell
> $TrueVar  = $true -and $true
> $FalseVar = $true -and $false

> $TrueVar  = $true -or $false
> $FalseVar = $false -or $false

> $TrueVar  = -not $false
> $FalseVar = -not $true
```

## Conversion and truthiness

PowerShell can implicitly treat any type as a Boolean.
However you can also use the Boolean type accelerator `[bool]` for explicit conversion.

Here are some general rules that PowerShell use to convert other types to Boolean values:

$false:
- Emptry strings like `''` or `""`
- Null values like `$null`
- Numeric type with the value of zero (0)

$true:
- Non-empty strings
- Instances of any other non-collection type

```powershell
> [bool] 0
False

> [bool] 0.0
False

> [bool] ""
False

> [bool] "Hello"
True

> [bool] 1234
True
```

For in depth rules about converting Boolean values from collection types, please read [here][collection-conversion].

[booleans]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_booleans?view=powershell
[logical-operators]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators
[collection-conversion]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_booleans?#converting-from-collection-types
