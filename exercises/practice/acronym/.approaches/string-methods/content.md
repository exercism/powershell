# Using `string` methods

```powershell
Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    ( $Phrase -replace "[-_]"," " -split " " | Foreach-Object {$_[0].ToString().ToUpper()} ) -join ""
}
```



[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date) cmdlet.