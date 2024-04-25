# Introduction


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


## Comment-based help

[`Comment-based help`][comment-based help] in PowerShell helps provide detailed infomation for functions and scripts written in comments.
It use special help comment keywords to specify the topics in focus, e.g `.SYNOPSIS`, `.EXAMPLE` or `.NOTES`.

```powershell
function ExampleFunction($Arg) {
    <#
    .DESCRIPTION
    A detailed description of the function or script. This keyword can be used only once in each topic.

    .PARAMETER Arg
    The description of a parameter, it must be follow with the parameter name.
    #>
}
```

You can display the comment-based help infomation using the cmdlet `Get-Help`.

```powershell
> Get-Help -Name "ExampleFunction"
```

[booleans]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_booleans
[logical-operators]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators
[comment-based help]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help
