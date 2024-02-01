Function ValidateAge() {
    <#
    .SYNOPSIS
    Simple function to check if the input age is over 18.

    .DESCRIPTION
    This is a function to validate an age.
    It will throw a termination error when :
    a. The input value for the Age param won't satisfy the ValidateScript
    b. The input value doesn't match the expected type [int]
    Do not delete or modify this.

    .PARAMETER Age
    An integer represent the age, it should be 18 or up.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({$_ -ge 18},
        ErrorMessage = "'{0}' is not a valid age. Valid value is 18 and up")]
        [int] $Age
    )
    return "I'm $Age years old!"
}

#Start all your code below this
Function NonTerminationError {
    <#
    .DESCRIPTION
    A simple function that return an error message but doesnt terminate the function.
    #>
    Throw "Please implement this function"
}

Function ValueErrorHandling {
    <#
    .DESCRIPTION
    A function that take in an input for the predefined ValidateAge function, it may catch error and return normal string with a warning message. 
    #>
    param (
        $Age
    )
    Throw "Please implement this function"
}

Function TypedErrorHandling {
    <#
    .DESCRIPTION
    A function that take in a string represent a path to open a file.
    This function should handle 2 different termination errors:
    - File not found
    - File path is too long (256)

    .PARAMETER Path
    String represent a filepath.
    #>
    param (
        [string] $Path
    )
    Throw "Please implement this function"
}

Function ReThrowErrorHandling {
    <#
    .DESCRIPTION
    A simple function to demonstrate the ability to rethrow a different error.
    Instead of throwing a filepath not exist, throw a custom error when the Path parameter wasn't provided.
    #>
    param (
        [string] $Path
    )
    Throw "Please implement this function"
}