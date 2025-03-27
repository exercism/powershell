BeforeAll {
    . "./SwiftScheduling.ps1"
}

Describe "SwiftScheduling test cases" {
    It "NOW translates to two hours later" {
        $start = [Datetime]::New(2012, 2, 13, 9, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "NOW"
        $want = [Datetime]::New(2012, 2, 13, 11, 0, 0)

        $got | Should -BeExactly $want
    }

    It "ASAP before one in the afternoon translates to today at five in the afternoon" {
        $start = [Datetime]::New(1999, 6, 3, 9, 45, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "ASAP"
        $want = [Datetime]::New(1999, 6, 3, 17, 0, 0)

        $got | Should -BeExactly $want
    }

    It "ASAP at one in the afternoon translates to tomorrow at one in the afternoon" {
        $start = [Datetime]::New(2008, 12, 21, 13, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "ASAP"
        $want = [Datetime]::New(2008, 12, 22, 13, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "ASAP after one in the afternoon translates to tomorrow at one in the afternoon" {
        $start = [Datetime]::New(2008, 12, 21, 14, 50, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "ASAP"
        $want = [Datetime]::New(2008, 12, 22, 13, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "EOW on Monday translates to Friday at five in the afternoon" {
        $start = [Datetime]::New(2025, 2, 3, 16, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(2025, 2, 7, 17, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "EOW on Tuesday translates to Friday at five in the afternoon" {
        $start = [Datetime]::New(1997, 4, 29, 10, 50, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(1997, 5, 2, 17, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "EOW on Wednesday translates to Friday at five in the afternoon" {
        $start = [Datetime]::New(2005, 9, 14, 11, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(2005, 9, 16, 17, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "EOW on Thursday translates to Sunday at eight in the evening" {
        $start = [Datetime]::New(2011, 5, 19, 8, 30, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(2011, 5, 22, 20, 0, 0)
    
        $got | Should -BeExactly $want
    }

    It "EOW on Friday translates to Sunday at eight in the evening" {
        $start = [Datetime]::New(2022, 8, 5, 14, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(2022, 8, 7, 20, 0, 0)

        $got | Should -BeExactly $want
    }

    It "EOW translates to leap day" {
        $start = [Datetime]::New(2008, 2, 25, 10, 30, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "EOW"
        $want = [Datetime]::New(2008, 2, 29, 17, 0, 0)

        $got | Should -BeExactly $want
    }

    It "2M before the second month of this year translates to the first workday of the second month of this year" {
        $start = [Datetime]::New(2007, 1, 2, 14, 15, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "2M"
        $want = [Datetime]::New(2007, 2, 1, 8, 0, 0)

        $got | Should -BeExactly $want
    }

    It "11M in the eleventh month translates to the first workday of the eleventh month of next year" {
        $start = [Datetime]::New(2013, 11, 21, 15, 30, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "11M"
        $want = [Datetime]::New(2014, 11, 3, 8, 0, 0)

        $got | Should -BeExactly $want
    }

    It "4M in the ninth month translates to the first workday of the fourth month of next year" {
        $start = [Datetime]::New(2019, 11, 18, 15, 15, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "4M"
        $want = [Datetime]::New(2020, 4, 1, 8, 0, 0)

        $got | Should -BeExactly $want
    }

    It "Q1 in the first quarter translates to the last workday of the first quarter of this year" {
        $start = [Datetime]::New(2003, 1, 1, 10, 45, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "Q1"
        $want = [Datetime]::New(2003, 3, 31, 8, 0, 0)

        $got | Should -BeExactly $want
    }

    It "Q4 in the second quarter translates to the last workday of the fourth quarter of this year" {
        $start = [Datetime]::New(2001, 4, 9, 9, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "Q4"
        $want = [Datetime]::New(2001, 12, 31, 8, 0, 0)

        $got | Should -BeExactly $want
    }

    It "Q3 in the fourth quarter translates to the last workday of the third quarter of next year" {
        $start = [Datetime]::New(2022, 10, 6, 11, 0, 0)

        $got = Invoke-SwiftScheduling -MeetingStart $start -Description "Q3"
        $want = [Datetime]::New(2023, 9, 29, 8, 0, 0)

        $got | Should -BeExactly $want
    }
}
