Function Invoke-BafflingBirthdays {
    <#
    .SYNOPSIS
    Estimate the birthday paradox's probabilities.

    .DESCRIPTION
    To solve the birthday paradox exercise you need to do these steps:
    - Generate random birthdates.
    - Check if a collection of randomly generated birthdates contains at least two with the same birthday.
    - Estimate the probability that at least two people in a group share the same birthday for different group sizes.

    .PARAMETER People
    Number of people in the group.
    #>
    [CmdletBinding()]
    Param(
        [int]$People
    )
    Throw "Please implement this function"
}

Function Get-RandomBirthdates {
    <#
    .SYNOPSIS
    Generate a collection of birthdates based on a number of people.

    .PARAMETER People
    Number of birthdates to be generated.
    #>
    [CmdletBinding()]
    Param(
        [int]$People
    )
    Throw "Please implement this function"
}

Function Test-SharedBirthday {
    <#
    .SYNOPSIS
    Check if there is a shared birthday in a list of random birthdates.

    .PARAMETER Birthdates
    A collection of random Datetime objects represents.
    #>
    [CmdletBinding()]
    Param(
        [DateTime[]]$Birthdates
    )
    Throw "Please implement this function"
}
