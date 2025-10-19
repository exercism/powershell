BeforeAll {
    . "./SplitSecondStopwatch.ps1"
}

Describe "SplitSecondStopwatch test cases" {
    BeforeEach {
        $clock = [ClockWrapper]::new()
        $stopWatch = [SplitSecondStopwatch]::new($clock)
    }

    It "new stopwatch starts in ready state" {
        $stopWatch.State | Should -Be ([States]::Ready)
    }

    It "new stopwatch's current lap has no elapsed time" {
        $stopWatch.GetCurrentLap() | Should -BeExactly "00:00:00"
    }

    It "new stopwatch's total has no elapsed time" {
        $stopWatch.GetTotal() | Should -BeExactly "00:00:00"
    }

    It "new stopwatch does not have previous laps" {
        $stopWatch.PreviousLaps | Should -BeExactly @()
    }

    It "start from ready state changes state to running" {
        $stopWatch.Start()
        $stopWatch.State | Should -Be ([States]::Running)
    }

    It "start does not change previous laps" {
        $stopWatch.Start()
        $stopWatch.PreviousLaps | Should -BeExactly @()
    }

    It "start initiates time tracking for current lap" {
        $stopWatch.Start()
        $clock.Advance("00:00:05")
        $stopWatch.GetCurrentLap() | Should -BeExactly "00:00:05"
    }

    It "start initiates time tracking for total" {
        $stopWatch.Start()
        $clock.Advance("00:00:23")
        $stopWatch.GetTotal() | Should -BeExactly "00:00:23"
    }

    It "start cannot be called from running state" {
        $stopWatch.Start()

        { $stopWatch.Start() } | Should -Throw "*Invalid Operation*"
    }

    It "stop from running state changes state to stopped" {
        $stopWatch.Start()
        $stopWatch.Stop()

        $stopWatch.State | Should -Be ([States]::Stopped)
    }

    It "stop pauses time tracking for current lap" {
        $stopWatch.Start()
        $clock.Advance("00:00:05")
        $stopWatch.Stop()
        $clock.Advance("00:00:08")

        $stopWatch.GetCurrentLap() | Should -BeExactly "00:00:05"
    }

    It "stop pauses time tracking for total" {
        $stopWatch.Start()
        $clock.Advance("00:00:13")
        $stopWatch.Stop()
        $clock.Advance("00:00:33")

        $stopWatch.GetTotal() | Should -BeExactly "00:00:13"
    }

    It "stop cannot be called from ready state" {
        { $stopWatch.Stop() } | Should -Throw "*Invalid Operation*"
    }

    It "stop cannot be called from stopped state" {
        $stopWatch.Start()
        $stopWatch.Stop()

        { $stopWatch.Stop() } | Should -Throw "*Invalid Operation*"
    }

    It "start from stopped state changes state to running" {
        $stopWatch.Start()
        $stopWatch.Stop()
        $stopWatch.Start()

        $stopWatch.State | Should -Be ([States]::Running)
    }

    It "start from stopped state resumes time tracking for current lap" {
        $stopWatch.Start()
        $clock.Advance("00:01:20")
        $stopWatch.Stop()
        $clock.Advance("00:00:20")
        $stopWatch.Start()
        $clock.Advance("00:00:08")

        $stopWatch.GetCurrentLap() | Should -BeExactly "00:01:28"
    }

    It "start from stopped state resumes time tracking for total" {
        $stopWatch.Start()
        $clock.Advance("00:00:23")
        $stopWatch.Stop()
        $clock.Advance("00:00:44")
        $stopWatch.Start()
        $clock.Advance("00:00:09")

        $stopWatch.GetTotal() | Should -BeExactly "00:00:32"
    }

    It "lap adds current lap to previous laps" {
        $stopWatch.Start()
        $clock.Advance("00:01:38")
        $stopWatch.Lap()

        ($stopWatch.PreviousLaps | ForEach-Object ToString) | Should -Be @("00:01:38")

        $clock.Advance("00:00:44")
        $stopWatch.Lap()

        ($stopWatch.PreviousLaps | ForEach-Object ToString) | Should -Be @("00:01:38", "00:00:44")
    }

    It "lap resets current lap and resumes time tracking" {
        $stopWatch.Start()
        $clock.Advance("00:08:22")
        $stopWatch.Lap()

        $stopWatch.GetCurrentLap() | Should -Be @("00:00:00")

        $clock.Advance("00:00:15")

        $stopWatch.GetCurrentLap() | Should -Be @("00:00:15")
    }

    It "lap continues time tracking for total" {
        $stopWatch.Start()
        $clock.Advance("00:00:22")
        $stopWatch.Lap()
        $clock.Advance("00:00:33")

        $stopWatch.GetTotal() | Should -BeExactly "00:00:55"
    }

    It "lap cannot be called from ready state" {
        { $stopWatch.Lap() } | Should -Throw "*Invalid Operation*"
    }

    It "lap cannot be called from stopped state" {
        $stopWatch.Start()
        $stopWatch.Stop()

        { $stopWatch.Lap() } | Should -Throw "*Invalid Operation*"
    }

    It "stop does not change previous laps" {
        $stopWatch.Start()
        $clock.Advance("00:11:22")
        $stopWatch.Lap()

        $stopWatch.PreviousLaps | Should -BeExactly @("00:11:22")

        $stopWatch.Stop()

        $stopWatch.PreviousLaps | Should -BeExactly @("00:11:22")
    }

    It "reset from stopped state changes state to ready" {
        $stopWatch.Start()
        $stopWatch.Stop()
        $stopWatch.Reset()

        $stopWatch.State | Should -Be ([States]::Ready)
    }

    It "reset resets current lap" {
        $stopWatch.Start()
        $clock.Advance("00:00:10")
        $stopWatch.Stop()
        $stopWatch.Reset()

        $stopWatch.GetCurrentLap() | Should -Be "00:00:00"
    }

    It "reset clears previous laps" {
        $stopWatch.Start()
        $clock.Advance("00:00:10")
        $stopWatch.Lap()
        $clock.Advance("00:00:20")
        $stopWatch.Lap()

        $stopWatch.PreviousLaps | Should -Be @("00:00:10", "00:00:20")

        $stopWatch.Stop()
        $stopWatch.Reset()

        $stopWatch.PreviousLaps | Should -Be @()
    }

    It "reset cannot be called from ready state" {
        { $stopWatch.Reset() } | Should -Throw "*Invalid Operation*"
    }

    It "reset cannot be called from running state" {
        $stopWatch.Start()

        { $stopWatch.Reset() } | Should -Throw "*Invalid Operation*"
    }

    It "supports very long laps" {
        $stopWatch.Start()
        $clock.Advance("01:23:45")

        $stopWatch.GetCurrentLap() | Should -Be "01:23:45"

        $stopWatch.Lap()

        $stopWatch.PreviousLaps | Should -Be @("01:23:45")

        $clock.Advance("04:01:40")

        $stopWatch.GetCurrentLap() | Should -Be "04:01:40"
        $stopWatch.GetTotal() | Should -Be "05:25:25"

        $stopWatch.Lap()

        $stopWatch.PreviousLaps | Should -Be @("01:23:45", "04:01:40")

        $clock.Advance("08:43:05")

        $stopWatch.GetCurrentLap() | Should -Be "08:43:05"
        $stopWatch.GetTotal() | Should -Be "14:08:30"

        $stopWatch.Lap()

        $stopWatch.PreviousLaps | Should -Be @("01:23:45", "04:01:40", "08:43:05")
    }
}
