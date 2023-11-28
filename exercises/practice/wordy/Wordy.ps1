Function Get-Answer() {
    <#
    .SYNOPSIS
    Parse and evaluate simple math word problems.
    
    .DESCRIPTION
    Implement a function that take in a string represent a math word problem and return the answer in integer.
    Throw error if the question doesn't make sense or doesn't related to math problem.

    .PARAMETER Question
    The string represent the math problem.

    .EXAMPLE
    Get-Answer -Question "What is 1 plus 1?"
    Returns: 2
    #>
    [CmdletBinding()]
    Param(
        [string]$Question
    )
    Throw "Please implement this function"
}
