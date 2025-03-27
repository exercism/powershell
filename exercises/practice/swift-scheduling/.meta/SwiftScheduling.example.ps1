Function Invoke-SwiftScheduling() {
    <#
    .SYNOPSIS
    Find the actual dates for deliveries.

    .DESCRIPTION
    Convert delivery date descriptions to actual delivery dates, based on when the meeting started.

    .PARAMETER MeetingStart
    A datetime object for delivery date.

    .PARAMETER Description
    A string describes the nature of the delivery date.

    .EXAMPLE
     #>
    [CmdletBinding()]
    Param(
        [datetime]$MeetingStart,
        [string]$Description
    )
    switch -Regex ($Description) {
        "NOW"   { Now $MeetingStart    }
        "ASAP"  { Asap $MeetingStart   }
        "EOW"   { Eow $MeetingStart    }
        "\d+M"  { Month $MeetingStart $Description  }
        "Q\d"   { Quarter $MeetingStart $Description}
    }
}

function Now($Date) {
    $Date.AddHours(2)
}

function Asap($Date) {
    if ( $Date.Hour -lt 13) {
        [DateTime]::new($Date.Year, $Date.Month, $Date.Day, 17, 0, 0)
    } else {
        $dt = $Date.AddDays(1)
        [DateTime]::new($dt.Year, $dt.Month, $dt.Day, 13, 0, 0)
    }
}

function Eow($Date) {
    switch ($Date.DayOfWeek) {
        {$_ -in "Thursday", "Friday"} { 
            $dt = $Date.AddDays(([System.DayOfWeek]::Sunday - $start.DayOfWeek + 7) % 7)
            [DateTime]::new($dt.Year, $dt.Month, $dt.Day, 20, 0, 0)
        }
        Default {
            $dt = $Date.AddDays([System.DayOfWeek]::Friday - $start.DayOfWeek)
            [DateTime]::new($dt.Year, $dt.Month, $dt.Day, 17, 0, 0)
        }
    }
}

function Month($Date, $Desc) {
    $month = [int]::Parse($Desc.SubString(0, $Desc.LastIndexOf('M')))
    $newdate = [datetime]::New($Date.Year + ($Date.Month -lt $month ? 0 : 1), $month, 1, 8, 0 ,0)
    while ($newdate.DayOfWeek -in @('Saturday', 'Sunday') ) {
        $newdate = $newdate.AddDays(1)
    }
    $newdate
}

function Quarter($Date, $Desc) {
    $quarterMonths = @{
        "Q1" = @(3, 31);
        "Q2" = @(6, 30);
        "Q3" = @(9, 30);
        "Q4" = @(12, 31);
    }
    $newYear = $Date.Month -le $quarterMonths[$Desc][0] ? $Date.Year : $Date.Year + 1
    $newMonth = $quarterMonths[$Desc][0]
    $newDay = $quarterMonths[$Desc][1]
    $newDate = [datetime]::New($newYear, $newMonth, $newDay, 8, 0 ,0)
    while ($newdate.DayOfWeek -in @('Saturday', 'Sunday') ) {
        $newdate = $newdate.AddDays(-1)
    }
    $newdate
}
