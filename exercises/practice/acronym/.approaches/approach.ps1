Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    ( $Phrase -replace "[-_]"," " -split " " | Foreach-Object {$_[0].ToString().ToUpper()} ) -join ""
}

Get-Acronym -Phrase "First in, First out"

