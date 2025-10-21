Function Get-LetterFrequencies() {
    <#
    .SYNOPSIS
    Count the frequency of letters in texts using parallel computation.

    .PARAMETER Texts
    An array of strings.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Texts
    )
    $final = @{}
    $Texts | ForEach-Object -Parallel  {
        $local = @{}
        foreach ($ch in $_.ToLower().ToCharArray()) {
            if ($ch -match '\p{L}') {
                $local[$ch] = 1 + ($local[$ch] ?? 0)
            }
        }
        $local} | ForEach-Object {
        foreach ($k in $_.Keys) {
            $final[[string]$k] = ($final[[string]$k] ?? 0) + $_[$k]
        }
    }
   $final
}
