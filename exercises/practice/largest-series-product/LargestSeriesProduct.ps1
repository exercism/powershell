Function Get-LargestSeriesProduct() {
    <#
    .SYNOPSIS
    Get the largest product in a given span of long sequence of digits.
    
    .DESCRIPTION
    Given a string made up by number and a span lenght, find the largest product of all the number in that span.
    
    .PARAMETER Digits
    The string digits to be analyzed.

    .PARAMETER Span
    The lenght of the span.
    
    .EXAMPLE
    Get-LargestSeriesProduct -Digits "63915" -Span 3
    Return: 162
    #>
    [CmdletBinding()]
    Param(
        [string]$Digits,
        [int]$Span
    )
    Throw "Please implement this function."
}
