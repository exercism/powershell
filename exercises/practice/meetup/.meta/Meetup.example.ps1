Function Get-MeetUp {
    <#
    .SYNOPSIS
    In this exercise you will be given the recurring schedule, along with a month and year, and then asked to find the exact date of the meetup.
    
    .DESCRIPTION
    Given information for a meep up : year, month, weekday and schedule, return a datetime object of the meetup date.
    
    .PARAMETER Year
    The year of the meetup date.

    .PARAMETER Month
    The month of the meetup date.

    .PARAMETER Weekday
    The weekday of the meetup date.

    .PARAMETER Schedule
    The position of the specified weekday within the month.
    
    .EXAMPLE
    Get-MeetUp -Year 2002 -Month 12 -Weekday Monday -Schedule first
    Return: Monday, December 2, 2002 00:00:00 

    Note: 00:00:00 is just an example, Get-Date will return the current time (hour, min) based on your system unless you specify them.
    #>
    param(
        [int]$year,
        [ValidateRange(1,12)]
        [int]$month,
        [ValidateSet("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")]
        [string]$weekday,
        [ValidateSet("first", "second", "third", "fourth", "last", "teenth")]
        [string]$schedule
    )
    $firstDay = Get-Date -Year $year -Month $month -Day 1

    while ($firstDay.DayOfWeek -ne $weekday) {
        $firstDay = $firstDay.AddDays(1)
    }
    $arrayOfDates = 0..4 | ForEach-Object {$firstDay.AddDays($_ * 7)} | Where-Object {$_.Month -eq $month}

    $meetupDate = switch ($schedule) {
        "first" { $arrayOfDates[0]  }
        "second"{ $arrayOfDates[1]  }
        "third" { $arrayOfDates[2]  }
        "fourth"{ $arrayOfDates[3]  }
        "last"  { $arrayOfDates[-1] }
        Default { $arrayOfDates | Where-Object {$_.Day -ge 13 -and $_.Day -le 19} }
    }
    $meetupDate
}