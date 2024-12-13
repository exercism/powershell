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

[Find and replace](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-string-substitutions#find-and-replace-tokens) strings.  
About [Split operator](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split).  
About [Join operator](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_join).
