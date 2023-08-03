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

    Validator $Digits $Span

    $Product = 0
    for ($i = 0; $i -lt $Digits.Length - ($Span - 1); $i++) {
        $tempProduct = 1
        $Digits[$i..$($i+$Span-1)] | ForEach-Object { 
            if ([int]::Parse($_) -eq 0) {
                continue
            }
            $tempProduct *= [int]::Parse($_)
        }
        if ($tempProduct -gt $Product) {
            $Product = $tempProduct
        }
    }
    return $Product
}

Function Validator() {
    Param(
        [string]$Digits,
        [int]$Span
    )
    if ($Digits -match "[a-zA-Z]") {
        Throw "digits input must only contain digits"
    }
    if ($Span -gt $Digits.Length) {
        Throw "span must be smaller than string length"
    }
    if ($Span -lt 0) {
        Throw "span must not be negative"
    }
}