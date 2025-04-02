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
    $runs = 1000
    $count = 0
    for ($i = 0; $i -lt $runs; $i++) {
        $birthdays = Get-RandomBirthdates -People $People
        $count += Test-SharedBirthday -Birthdates $birthdays
    }
    $count /  100.00
}

Function Get-RandomBirthdate([int]$Year) {
    $month = Get-Random -Minimum 1 -Maximum (12 + 1)
    $day   = Get-Random -Minimum 1 -Maximum (([DateTime]::DaysInMonth($Year, $month)) + 1)
    [datetime]::New($Year, $month, $day)
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
    do {
        $year = Get-Random -Minimum 1900 -Maximum ((Get-Date).Year + 1)
    } until (-not [DateTime]::IsLeapYear($year))

    for ($i = 0; $i -lt $People; $i++) {
        Get-RandomBirthdate $year
    }
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
    for ($i = 0; $i -lt $Birthdates.Count; $i++) {
        for ($j = $i+1; $j -lt $Birthdates.Count; $j++) {
            if ($Birthdates[$i].DayOfYear -eq $Birthdates[$j].DayOfYear) {
                return $true
            }
        }
    }
    $false
}
