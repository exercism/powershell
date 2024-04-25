# Introduction


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
