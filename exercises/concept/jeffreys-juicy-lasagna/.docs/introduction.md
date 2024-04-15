# Introduction

PowerShell is a dynamically implicit typed (also support strongly typed variables) scripting language from Microsoft, mostly focus on task automation and confifuration management.

PowerShell supports imperative, functional, object-oriented programming, and even pipeline style.

PowerShell was built on the .NET platform and first released in 2006.
It has been included by default in all modern Windows OS, and can be installed on Mac and Linux.


## Variables

There are two common ways to define a variable in PowerShell.

Varible name in PowerShell must start with `$` and using the assignment operator `=` to bind the variable name to a value.

```powershell
> $intVar = 1
> $doubleVar = 2.0
> $stringVar = "Hello"

# Checking a variable type using the GetType() method
> Write-Host $doubleVar.GetType()
System.Double
```

You can also explicitly specify a variable's type if you want to enforce a specific [type][strong typed].
PowerShell will try its best to convert the value from one type to another if possible.

```powershell
# String represents a floating number can be converted to integer
> [int]$staticOne = "1.234"
> $staticOne
1

# String of letters can not be converted to double type
> [double]$staticTwo = "hello"
MetadataError: Cannot convert value "hello" to type "System.Double"
```


### Constants

Constants in PowerShell are read-only variables that can't be **removed** after defined.
This lead us to the second way to define variables using the cmdlet `New-Variable`.

```powershell
> New-Variable -Name "MyConstant" -Value 100 -Option Constant
> $MyConstant
```

For a more detailed and advanced way to create a new variable with various options, please see [New-Variable][New-Variable] cmdlet.


## Functions

[Functions][functions] in PowerShell are defined using the `function` keyword.
Each function can have zero or more formal [parameters][parameters] in `()` parenthesis, followed by its own [scope][scope] start  with `{` and end with `}`. 

```powershell
function Greeting {
    return "Hello!"
}
```

Functions in PowerShell can return values explicitly via the `return` keyword, after being called using the syntax `FuncName $Arg`.

```powershell
function AddTwoNumbers($NumOne, $NumTwo):
    $result = $NumOne + $NumTwo
    return $result

> AddTwoNumbers 10 20
30
```

An advanced look of how to write a detailed function definition, and how functions can return values implicitly will be covered in the `Functions` concept module.


## Comments

Single comment in PowerShell start with a `#`, and end at line termination.
Comment block in PowerShell start with `<#` and end with `#>`.
An advanced showcase of comment block to create Comment-Based Help will be covered in the `Functions` concept module.

```powershell
function Main() {
    #This is a comment
}
```


[parameters]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters
[strong typed]: https://pscustomobject.github.io/powershell/coding%20habits/powershell%20best%20practice/PowerShell-Strongly-Typed-Variables/
[assignment operator]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_assignment_operators
[New-Variable]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-variable
[scope]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes
[functions]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions
