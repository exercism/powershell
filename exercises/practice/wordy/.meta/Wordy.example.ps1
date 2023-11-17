$OPERATORS = @{
    'plus' = '+'
    'minus' = '-'
    'multiplied' = '*'
    'divided' = '/'
}

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

    $pattern = $OPERATORS.Keys -join '|'
    $stack = ($Question -replace $pattern, { $OPERATORS[$_.Value] } -replace "what|is|by|\?", '') -split " " -ne ""

    ValidateStack $stack
    ProcessStack $stack
}

Function ValidateStack($stack) {
    <#
    .DESCRIPTION
    Helper function to validate the stack. Throw error at unsupported operation, and insufficient elements.
    #>
    foreach ($token in $stack) {
        if (-not ($token -match '-?\d+|[+*-/]')) {
            Throw "Unknown operation"
        }
    }

    if ($stack.Count % 2 -eq 0) {
        Throw "Syntax Error"
    }
}

Function ProcessStack($stack) {
    <#
    .DESCRIPTION
    Helper function to process the stack. Throw error when needed.
    #>
    $result = $null
    $currentOperator = $null

    foreach ($token in $stack) {
        if ($token -match '^[+\-*/]$') {
            $currentOperator = $token

            if ($null -eq $result) {
                Throw "Syntax Error: Lacking operand"
            }

        }else {
            if ($result -and $null -eq $currentOperator) {
                Throw "Syntax Error: Lacking operator"
            }

            $number = [int]$token
            if ($null -eq $result) {
                $result = $number
            }else {
                switch ($currentOperator) {
                    '+' { $result += $number }
                    '-' { $result -= $number }
                    '*' { $result *= $number }
                    '/' { $result /= $number }
                }
            }
        }
    }
    $result
}
