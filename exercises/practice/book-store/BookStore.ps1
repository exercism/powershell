Function Get-Total() {
    <#
    .SYNOPSIS
    Implement a function to calculate the price of books BASE_PRICEd on different combinations.

    .DESCRIPTION
    Given a basket of books, calculate the price of any conceivable shopping basket (containing only books of the same series), giving as big a discount as possible.

    One copy of any of the five books costs $8.
    If, however, you buy two different books, you get a 5% discount on those two books.
    If you buy 3 different books, you get a 10% discount.
    If you buy 4 different books, you get a 20% discount.
    If you buy all 5, you get a 25% discount.

    Note that if you buy four books, of which 3 are different titles, you get a 10% discount on the 3 that form part of a set, but the fourth book still costs $8.
    
    .PARAMETER Books
    An array of int, each represent an entry in a popular 5 books series.
    Parameter restraint : integer from 1 to 5 (inclusive).

    .EXAMPLE
    Get-Total -Books @(1, 1, 1, 1, 1) # no discount here
    Returns: 40

    Get-Total -Books @(1, 2, 3, 4, 5) # 25% discount applied here
    Returns: 30
    #>
    [CmdletBinding()]
    Param(
        [int[]]$Books
    )
    Throw "Please implement this function"
}