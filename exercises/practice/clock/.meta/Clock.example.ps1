<#
.SYNOPSIS
    Implement a clock that handles times without dates.

.DESCRIPTION
    Implement a clock that handles times without dates in 24 hours format.
    You should be able to add and subtract minutes to it.
    Two clocks that represent the same time should be equal to each other.
    Note: Please try to implement the class and its method instead of using built-in module Datetime.

.EXAMPLE
    $clock1 = [Clock]::new(5,0)
    $clock1.ToString()
    Return: "05:00"

    $clock2 = [Clock]::new(6,-120)
    $clock2.Add(60).ToString()
    Return: "05:00"

    $clock1 -eq $clock2
    Return: $true
#>

class Clock {
    [int]$Hour
    [int]$Minute

    Clock([int]$hour, [int]$minute) {
        $this.NormalizeTime($hour, $minute)
    }

    hidden [void] NormalizeTime([int]$hour, [int]$minute) {
        $minsPerDay = 60 * 24
        $totalMinutes = ($hour * 60 + $minute) % $minsPerDay
        if ($totalMinutes -lt 0) {
            $totalMinutes += $minsPerDay
        }
        $this.Minute = $totalMinutes % 60
        $this.Hour   = [Math]::Floor($totalMinutes / 60)
    }

    [Clock] Add([int]$minutes = 0) {
        $this.NormalizeTime($this.Hour, $this.Minute + $minutes)
        return $this
    }

    [string] ToString() {
        $formatHour = '{0:D2}' -f $this.Hour
        $formatMin  = '{0:D2}' -f $this.Minute
        return "${formatHour}:${formatMin}"
    }

    [bool] Equals($otherClock) {
        return $this.ToString() -eq $otherClock.ToString()
    }
}