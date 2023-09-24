Function Invoke-Transpose() {
    <#
    .SYNOPSIS
    Given an input text output it transposed.

    .DESCRIPTION
    Given a string, return the transposed string.
    The transpose of a matrix:
    ABC  =>  AD
    DEF      BE
             CF
    
    Rows become columns and columns become rows.

    .PARAMETER Text
    String to be transposed.

    .EXAMPLE
    Invoke-Transpose -Text "ABC`nDEF"
    Return:
    @"
    AD
    BE
    CF
    "@
    #>
    [CmdletBinding()]
    Param(
        [string]$Text
    )
    $lines = $Text -replace " ","█" -split "`n"
    $rows  = ($lines | Measure-Object -Property Length -Maximum).Maximum

    $transposed = for ($row = 0; $row -lt $rows; $row++) {
        (-join ($lines | ForEach-Object {$_[$row] ? $_[$row] : " "})).TrimEnd()
    }
    $transposed -join "`n" -replace "█"," "
}