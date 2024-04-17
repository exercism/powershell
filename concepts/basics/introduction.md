# Introduction

PowerShell is a dynamic and implicitly typed (_but also supporting [strongly typed][strong typed] variables_) scripting language from Microsoft, mostly focused on task automation and configuration management.

PowerShell supports imperative, functional, object-oriented, and even pipeline style programming.

PowerShell was built on the .NET platform and first released in 2006.
It has been included by default in all modern Windows OS, and can also be installed on Mac and Linux.


## Variables

There are two common ways to define a variable in PowerShell.

Variable names in PowerShell must start with a `$`, and use the assignment operator `=` to bind the variable name to a value.

```powershell
> $intVar = 1
> $doubleVar = 2.0
> $stringVar = "Hello"

# Checking a variable type using the GetType() method
> Write-Host $doubleVar.GetType()
System.Double
```

You can also specify a variable's type explicitly, if you want to enforce/require the value be of a certain type.
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

Constants in PowerShell are variables that can't be **changed** nor **removed** after definition.
This leads us to the second way of defining variables: using the cmdlet `New-Variable`.

```powershell
> New-Variable -Name "MyConstant" -Value 100 -Option Constant
> $MyConstant
```

For more detailed and advanced ways to create a new variable, please read [New-Variable][New-Variable].


## Functions

[Functions][functions] in PowerShell are defined using the `function` keyword.
Each function can have zero or more formal parameters in `()` parenthesis, followed by the function scope starting  with `{` and ending with `}`.

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

Single comments in PowerShell start with a `#`, and end at line termination.
Comment blocks in PowerShell start with `<#` and end with `#>`.
An advanced showcase of comment block to create Comment-Based Help will be covered in the `Functions` concept module.

```powershell
function Main() {
    #This is a comment
    <#
    And this is a comment block
    that can span multiple lines
    #>
}
```


[parameters]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters
[strong typed]: https://pscustomobject.github.io/powershell/coding%20habits/powershell%20best%20practice/PowerShell-Strongly-Typed-Variables/
[assignment operator]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_assignment_operators
[New-Variable]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-variable
[scope]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes
[functions]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions
