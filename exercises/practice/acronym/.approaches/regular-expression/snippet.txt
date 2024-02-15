Function Get-Acronym() {
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )
    (-join ([regex]::Matches($Phrase, "\p{L}+'?\p{L}*") | ForEach-Object { $_.Value[0] })).ToUpper()
}