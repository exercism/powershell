BeforeAll {
    . "./Gigasecond.ps1"
}

Describe "Test Add-Gigasecond.ps1" {
    It "date only specification of time" {
        $time = Get-Date -Year 2011 -Month 4 -Day 25 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
        $got = Add-Gigasecond -Time $time 
        $want = Get-Date -Year 2043 -Month 1 -Day 1 -Hour 1 -Minute 46 -Second 40 -Millisecond 0

        $got | Should -Be $want
    }

    It "second test for date only specification of time" {
        $time = Get-Date -Year 1977 -Month 6 -Day 13 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
        $got = Add-Gigasecond -Time $time
        $want = Get-Date -Year 2009 -Month 2 -Day 19 -Hour 1 -Minute 46 -Second 40 -Millisecond 0

        $got | Should -Be $want
    }

    It "third test for date only specification of time" {
        $time = Get-Date -Year 1959 -Month 7 -Day 19 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
        $got = Add-Gigasecond -Time $time
        $want = Get-Date -Year 1991 -Month 3 -Day 27 -Hour 1 -Minute 46 -Second 40 -Millisecond 0

        $got | Should -Be $want
    }

    It "full time specified" {
        $time = Get-Date -Year 2015 -Month 1 -Day 24 -Hour 22 -Minute 0 -Second 0 -Millisecond 0
        $got = Add-Gigasecond -Time $time
        $want = Get-Date -Year 2046 -Month 10 -Day 2 -Hour 23 -Minute 46 -Second 40 -Millisecond 0

        $wantString = $want.ToString("yyyy-MM-dd HH:mm:ss")
        $gotString = $got.ToString("yyyy-MM-dd HH:mm:ss")

        $got | Should -Be $want
    }

    It "full time with day roll-over" {
        $time = Get-Date -Year 2015 -Month 1 -Day 24 -Hour 23 -Minute 59 -Second 59 -Millisecond 0
        $got = Add-Gigasecond -Time $time
        $want = Get-Date -Year 2046 -Month 10 -Day 3 -Hour 1 -Minute 46 -Second 39 -Millisecond 0

        $wantString = $want.ToString("yyyy-MM-dd HH:mm:ss")
        $gotString = $got.ToString("yyyy-MM-dd HH:mm:ss")

        $got | Should -Be $want
    }
}
