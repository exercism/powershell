Function Get-LineUp() {
    <#
    .SYNOPSIS
    Produce a greeting for customer in a line.
    
    .DESCRIPTION
    Given a name and a number, your task is to produce a sentence using that name and that number as an ordinal numeral.

    .PARAMETER Name
    String represents name of the customer.

    .PARAMETER Number
    Integer represents the order of the customer in line. (1 to 999)

    .EXAMPLE
    Get-LineUp -Name "Exercism" -Number 1
    Returns: "Exercism, you are the 1st customer we serve today. Thank you!"
    #>
    [CmdletBinding()]
    Param(
        [string]$Name,
        [int]$Number
    )
    Throw "Please implement this function"
}
