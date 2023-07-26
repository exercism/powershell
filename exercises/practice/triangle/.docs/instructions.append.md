# About Enum
The enum statement allows you to create a strongly typed set of labels.
You can use that enumeration in the code without having to parse or check for spelling errors.

Enumerations are internally represented as integers with a starting value of zero.
By default, PowerShell assigns the first label in the list the value zero, and assigns the remaining labels with consecutive integers.

Example:
```pwsh
Enum Fruits {
    APPLE       #default internal value 0
    ORANGE      #default internal value 1
    MANGO       #default internal value 2
}

$myFavFruit = [Fruits]::APPLE
Write-host $myFavFruit => APPLE
``````

To know more about Enum in powershell please check out [Enum module.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_enum)