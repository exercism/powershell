<#
.SYNOPSIS
Build a stopwatch to keep precise track of lap times
.DESCRIPTION
Implement a stopwatch with these four commands (start, stop, lap, and reset) to keep track of:
    1. The current lap's tracked time
    2. Previously recorded lap times
The stopwatch also should able to report infomation about : current lap, total time and time of previous laps.

.NOTES
Input and comparison in test suite using string in the format of "HH:MM:SS" for ease of reading.
However implementation should use Timespan as suggested.
#>

Enum States {
    Ready
    Running
    Stopped
}

class ClockWrapper {
    <#
    This class act as a simple timeprovider for the stopwatch
    DO NOT DELETE THIS CLASS
    #>
    [datetime]$Now
    ClockWrapper() {
        $this.Now = [datetime]::new(0)
    }

    [void] Advance([string]$span) {
        $this.Now += [TimeSpan]::Parse($span)
    }
}

class SplitSecondStopwatch {
    [States]$State = [States]::Ready
    [Timespan]$Total = [TimeSpan]::Zero
    [Timespan[]]$PreviousLaps = @()

    [TimeSpan] GetCurrentLap() {
        Throw "Please implement this function"
    }

    [TimeSpan] GetTotal() {
        Throw "Please implement this function"
    }

    [void] Start() {
        Throw "Please implement this function"
    }

    [void] Stop() {
        Throw "Please implement this function"
    }

    [void] Lap() {
        Throw "Please implement this function"
    }

    [void] Reset() {
        Throw "Please implement this function"
    }
}
