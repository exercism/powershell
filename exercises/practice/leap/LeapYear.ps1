function Test-LeapYear {
    <#
    .SYNOPSIS
    Given a year, report if it is a leap year.
    
    .DESCRIPTION
    Calculate whether the supplied year is a leap year. A leap year is determined from the following
    calculation:

    on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
    
    .PARAMETER year
    The year to test
    
    .EXAMPLE
    Test-LeapYear -year 2018

    Returns false

    .EXAMPLE
    Test-LeapYear -year 2020

    Returns True
    #>
    param( [int]$year )

    Throw "Exercise not implemented"
}
