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
    Throw "Please implement this function"
}