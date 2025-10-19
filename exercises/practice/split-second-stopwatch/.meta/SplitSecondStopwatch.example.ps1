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
    [ClockWrapper] hidden $_internalClock
    [datetime] hidden $_startTime
    [Timespan] hidden $_tracking

    SplitSecondStopwatch([object]$clock) {
        $this._internalClock = $clock
    }

    [TimeSpan] GetCurrentLap() {
        if ($this.State -eq [States]::Ready) {
            return [TimeSpan]::Zero
        } elseif ($this.State -eq [States]::Running) {
            return $this._tracking + ($this._internalClock.Now - $this._startTime)
        } else {
            return $this._tracking
        }
    }

    [TimeSpan] GetTotal() {
        if ($this.State -eq [States]::Ready) {
            return [TimeSpan]::Zero
        }
        $totalMs = ($this.PreviousLaps | ForEach-Object { $_.TotalMilliseconds } | Measure-Object -Sum).Sum
        return [TimeSpan]::FromMilliseconds($totalMs) + $this.GetCurrentLap()
    }

    [void] Start() {
        if ($this.State -eq [States]::Running) {
            throw "Invalid Operation"
        }
        $this.State = [States]::Running
        $this._startTime = $this._internalClock.Now
    }

    [void] Stop() {
        if ($this.State -ne [States]::Running) {
            throw "Invalid Operation"
        }
        $this._tracking = $this._internalClock.Now - $this._startTime
        $this.State = [States]::Stopped
    }

    [void] Lap() {
        if ($this.State -ne [States]::Running) {
            throw "Invalid Operation"
        }
        $this.PreviousLaps += $this.GetCurrentLap()
        $this._startTime = $this._internalClock.Now
    }

    [void] Reset() {
        if ($this.State -ne [States]::Stopped) {
            throw "Invalid Operation"
        }
        $this.State = [States]::Ready
        $this.PreviousLaps = @()
    }
}
