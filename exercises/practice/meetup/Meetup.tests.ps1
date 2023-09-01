BeforeAll {
    . "./Meetup.ps1"
}

Describe "Meetup test cases" {
    Context "Monday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -TestCases @(
            @{ year = 2013; month = 5; weekday = 'Monday'; schedule = 'teenth'; expect = '2013-05-13' }
            @{ year = 2013; month = 8; weekday = 'Monday'; schedule = 'teenth'; expect = '2013-08-19' }
            @{ year = 2013; month = 9; weekday = 'Monday'; schedule = 'teenth'; expect = '2013-09-16' }
            @{ year = 2013; month = 3; weekday = 'Monday'; schedule = 'first' ; expect = '2013-03-04' }
            @{ year = 2013; month = 4; weekday = 'Monday'; schedule = 'first' ; expect = '2013-04-01' }
            @{ year = 2013; month = 3; weekday = 'Monday'; schedule = 'second'; expect = '2013-03-11' }
            @{ year = 2013; month = 4; weekday = 'Monday'; schedule = 'second'; expect = '2013-04-08' }
            @{ year = 2013; month = 3; weekday = 'Monday'; schedule = 'third' ; expect = '2013-03-18' }
            @{ year = 2013; month = 4; weekday = 'Monday'; schedule = 'third' ; expect = '2013-04-15' }
            @{ year = 2013; month = 3; weekday = 'Monday'; schedule = 'fourth'; expect = '2013-03-25' }
            @{ year = 2013; month = 4; weekday = 'Monday'; schedule = 'fourth'; expect = '2013-04-22' }
            @{ year = 2013; month = 3; weekday = 'Monday'; schedule = 'last'  ; expect = '2013-03-25' }
            @{ year = 2013; month = 4; weekday = 'Monday'; schedule = 'last'  ; expect = '2013-04-29' }
        ) { 
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Tuesday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 3; weekday = 'Tuesday'; schedule = 'teenth'; expect = '2013-03-19' }
            @{ year = 2013; month = 4; weekday = 'Tuesday'; schedule = 'teenth'; expect = '2013-04-16' }
            @{ year = 2013; month = 8; weekday = 'Tuesday'; schedule = 'teenth'; expect = '2013-08-13' }
            @{ year = 2013; month = 5; weekday = 'Tuesday'; schedule = 'first' ; expect = '2013-05-07' }
            @{ year = 2013; month = 6; weekday = 'Tuesday'; schedule = 'first' ; expect = '2013-06-04' }
            @{ year = 2013; month = 5; weekday = 'Tuesday'; schedule = 'second'; expect = '2013-05-14' }
            @{ year = 2013; month = 6; weekday = 'Tuesday'; schedule = 'second'; expect = '2013-06-11' }
            @{ year = 2013; month = 5; weekday = 'Tuesday'; schedule = 'third' ; expect = '2013-05-21' }
            @{ year = 2013; month = 6; weekday = 'Tuesday'; schedule = 'third' ; expect = '2013-06-18' }
            @{ year = 2013; month = 5; weekday = 'Tuesday'; schedule = 'fourth'; expect = '2013-05-28' }
            @{ year = 2013; month = 6; weekday = 'Tuesday'; schedule = 'fourth'; expect = '2013-06-25' }
            @{ year = 2013; month = 5; weekday = 'Tuesday'; schedule = 'last'  ; expect = '2013-05-28' }
            @{ year = 2013; month = 6; weekday = 'Tuesday'; schedule = 'last'  ; expect = '2013-06-25' }
        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Wednesday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 1 ; weekday = 'Wednesday'; schedule = 'teenth'; expect = '2013-01-16' }
            @{ year = 2013; month = 2 ; weekday = 'Wednesday'; schedule = 'teenth'; expect = '2013-02-13' }
            @{ year = 2013; month = 6 ; weekday = 'Wednesday'; schedule = 'teenth'; expect = '2013-06-19' }
            @{ year = 2013; month = 7 ; weekday = 'Wednesday'; schedule = 'first' ; expect = '2013-07-03' }
            @{ year = 2013; month = 8 ; weekday = 'Wednesday'; schedule = 'first' ; expect = '2013-08-07' }
            @{ year = 2013; month = 7 ; weekday = 'Wednesday'; schedule = 'second'; expect = '2013-07-10' }
            @{ year = 2013; month = 8 ; weekday = 'Wednesday'; schedule = 'second'; expect = '2013-08-14' }
            @{ year = 2013; month = 7 ; weekday = 'Wednesday'; schedule = 'third' ; expect = '2013-07-17' }
            @{ year = 2013; month = 8 ; weekday = 'Wednesday'; schedule = 'third' ; expect = '2013-08-21' }
            @{ year = 2013; month = 7 ; weekday = 'Wednesday'; schedule = 'fourth'; expect = '2013-07-24' }
            @{ year = 2013; month = 8 ; weekday = 'Wednesday'; schedule = 'fourth'; expect = '2013-08-28' }
            @{ year = 2013; month = 7 ; weekday = 'Wednesday'; schedule = 'last'  ; expect = '2013-07-31' }
            @{ year = 2013; month = 8 ; weekday = 'Wednesday'; schedule = 'last'  ; expect = '2013-08-28' }
            @{ year = 2012; month = 2 ; weekday = 'Wednesday'; schedule = 'last'  ; expect = '2012-02-29' }
            @{ year = 2014; month = 12; weekday = 'Wednesday'; schedule = 'last'  ; expect = '2014-12-31' }

        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Thursday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 5 ; weekday = 'Thursday'; schedule = 'teenth'; expect = '2013-05-16' }
            @{ year = 2013; month = 6 ; weekday = 'Thursday'; schedule = 'teenth'; expect = '2013-06-13' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'teenth'; expect = '2013-09-19' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'first' ; expect = '2013-09-05' }
            @{ year = 2013; month = 10; weekday = 'Thursday'; schedule = 'first' ; expect = '2013-10-03' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'second'; expect = '2013-09-12' }
            @{ year = 2013; month = 10; weekday = 'Thursday'; schedule = 'second'; expect = '2013-10-10' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'third' ; expect = '2013-09-19' }
            @{ year = 2013; month = 10; weekday = 'Thursday'; schedule = 'third' ; expect = '2013-10-17' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'fourth'; expect = '2013-09-26' }
            @{ year = 2013; month = 10; weekday = 'Thursday'; schedule = 'fourth'; expect = '2013-10-24' }
            @{ year = 2013; month = 9 ; weekday = 'Thursday'; schedule = 'last'  ; expect = '2013-09-26' }
            @{ year = 2013; month = 10; weekday = 'Thursday'; schedule = 'last'  ; expect = '2013-10-31' }
        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Friday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 4 ; weekday = 'Friday'; schedule = 'teenth'; expect = '2013-04-19' }
            @{ year = 2013; month = 8 ; weekday = 'Friday'; schedule = 'teenth'; expect = '2013-08-16' }
            @{ year = 2013; month = 9 ; weekday = 'Friday'; schedule = 'teenth'; expect = '2013-09-13' }
            @{ year = 2013; month = 11; weekday = 'Friday'; schedule = 'first' ; expect = '2013-11-01' }
            @{ year = 2013; month = 12; weekday = 'Friday'; schedule = 'first' ; expect = '2013-12-06' }
            @{ year = 2012; month = 12; weekday = 'Friday'; schedule = 'first' ; expect = '2012-12-07' }
            @{ year = 2013; month = 11; weekday = 'Friday'; schedule = 'second'; expect = '2013-11-08' }
            @{ year = 2013; month = 12; weekday = 'Friday'; schedule = 'second'; expect = '2013-12-13' }
            @{ year = 2013; month = 11; weekday = 'Friday'; schedule = 'third' ; expect = '2013-11-15' }
            @{ year = 2013; month = 12; weekday = 'Friday'; schedule = 'third' ; expect = '2013-12-20' }
            @{ year = 2013; month = 11; weekday = 'Friday'; schedule = 'fourth'; expect = '2013-11-22' }
            @{ year = 2013; month = 12; weekday = 'Friday'; schedule = 'fourth'; expect = '2013-12-27' }
            @{ year = 2013; month = 11; weekday = 'Friday'; schedule = 'last'  ; expect = '2013-11-29' }
            @{ year = 2013; month = 12; weekday = 'Friday'; schedule = 'last'  ; expect = '2013-12-27' }
        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Saturday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'teenth'; expect = '2013-02-16' }
            @{ year = 2013; month = 4 ; weekday = 'Saturday'; schedule = 'teenth'; expect = '2013-04-13' }
            @{ year = 2013; month = 10; weekday = 'Saturday'; schedule = 'teenth'; expect = '2013-10-19' }
            @{ year = 2013; month = 1 ; weekday = 'Saturday'; schedule = 'first' ; expect = '2013-01-05' }
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'first' ; expect = '2013-02-02' }
            @{ year = 2013; month = 1 ; weekday = 'Saturday'; schedule = 'second'; expect = '2013-01-12' }
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'second'; expect = '2013-02-09' }
            @{ year = 2013; month = 1 ; weekday = 'Saturday'; schedule = 'third' ; expect = '2013-01-19' }
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'third' ; expect = '2013-02-16' }
            @{ year = 2013; month = 1 ; weekday = 'Saturday'; schedule = 'fourth'; expect = '2013-01-26' }
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'fourth'; expect = '2013-02-23' }
            @{ year = 2013; month = 1 ; weekday = 'Saturday'; schedule = 'last'  ; expect = '2013-01-26' }
            @{ year = 2013; month = 2 ; weekday = 'Saturday'; schedule = 'last'  ; expect = '2013-02-23' }
        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }

    Context "Sunday tests" {
        It "The <schedule> <weekday> of month <month> in <year>" -ForEach @(
            @{ year = 2013; month = 5 ; weekday = 'Sunday'; schedule = 'teenth'; expect = '2013-05-19' }
            @{ year = 2013; month = 6 ; weekday = 'Sunday'; schedule = 'teenth'; expect = '2013-06-16' }
            @{ year = 2013; month = 10; weekday = 'Sunday'; schedule = 'teenth'; expect = '2013-10-13' }
            @{ year = 2013; month = 3 ; weekday = 'Sunday'; schedule = 'first' ; expect = '2013-03-03' }
            @{ year = 2013; month = 4 ; weekday = 'Sunday'; schedule = 'first' ; expect = '2013-04-07' }
            @{ year = 2013; month = 3 ; weekday = 'Sunday'; schedule = 'second'; expect = '2013-03-10' }
            @{ year = 2013; month = 4 ; weekday = 'Sunday'; schedule = 'second'; expect = '2013-04-14' }
            @{ year = 2013; month = 3 ; weekday = 'Sunday'; schedule = 'third' ; expect = '2013-03-17' }
            @{ year = 2013; month = 4 ; weekday = 'Sunday'; schedule = 'third' ; expect = '2013-04-21' }
            @{ year = 2013; month = 3 ; weekday = 'Sunday'; schedule = 'fourth'; expect = '2013-03-24' }
            @{ year = 2013; month = 4 ; weekday = 'Sunday'; schedule = 'fourth'; expect = '2013-04-28' }
            @{ year = 2013; month = 3 ; weekday = 'Sunday'; schedule = 'last'  ; expect = '2013-03-31' }
            @{ year = 2013; month = 4 ; weekday = 'Sunday'; schedule = 'last'  ; expect = '2013-04-28' }
            @{ year = 2015; month = 2 ; weekday = 'Sunday'; schedule = 'last'  ; expect = '2015-02-22' }
        ) {
            $got  = Get-MeetUp -Year $year -Month $month -Weekday $weekday -Schedule $schedule
            $want = Get-Date $expect

            $got.Date | Should -BeExactly $want.Date
        }
    }
}