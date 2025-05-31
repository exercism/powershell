BeforeAll {
    . "./BafflingBirthdays.ps1"
}

Describe "BafflingBirthdays test cases" {
    Context "shared birthday" {
        It "one birthdate" {
            $birthdates = @(
                [datetime]::New(2000, 01, 01)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeFalse
        }
    
        It "two birthdates with same year, month, and day" {
            $birthdates = @(
                [datetime]::New(2000, 01, 01)
                [datetime]::New(2000, 01, 01)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeTrue
        }
    
        It "two birthdates with same year and month, but different day" {
            $birthdates = @(
                [datetime]::New(2012, 05, 09)
                [datetime]::New(2012, 05, 17)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeFalse
        }
    
        It "two birthdates with same month and day, but different year" {
            $birthdates = @(
                [datetime]::New(1999, 10, 23)
                [datetime]::New(1998, 10, 23)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeTrue
        }
    
        It "two birthdates with same year, but different month and day" {
            $birthdates = @(
                [datetime]::New(2007, 12, 19)
                [datetime]::New(2007, 04, 27)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeFalse
        }
    
        It "two birthdates with different year, month, and day" {
            $birthdates = @(
                [datetime]::New(1997, 08, 04)
                [datetime]::New(1963, 11, 23)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeFalse
        }
    
        It "multiple birthdates without shared birthday" {
            $birthdates = @(
                [datetime]::New(1966, 07, 29)
                [datetime]::New(1977, 02, 12)
                [datetime]::New(2001, 12, 25)
                [datetime]::New(1980, 11, 10)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeFalse
        }
    
        It "multiple birthdates with one shared birthday" {
            $birthdates = @(
                [datetime]::New(1966, 07, 29)
                [datetime]::New(1977, 02, 12)
                [datetime]::New(2001, 07, 29)
                [datetime]::New(1980, 11, 10)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeTrue
        }
    
        It "multiple birthdates with more than one shared birthday" {
            $birthdates = @(
                [datetime]::New(1966, 07, 29)
                [datetime]::New(1977, 02, 12)
                [datetime]::New(2001, 12, 25)
                [datetime]::New(1980, 07, 29)
                [datetime]::New(2019, 02, 12)
            )
            $got = Test-SharedBirthday -BirthDates $birthdates

            $got | Should -BeTrue
        }
    }
    
    Context "random birthdates tests" {
        BeforeAll {
            $groupSize = 300
            $birthDates = Get-RandomBirthdates -People $groupSize
        }

        It "generate requested number of birthdates" {
            $birthDates.Count | Should -Be $groupSize
        }

        It "years are fixed per batch" {
            $years = $birthDates | Group-Object -Property Year | Measure-Object
            $years.Count | Should -Be 1
        }
    
        It "years are not leap years" {
            $leapYears = $birthDates | Where-Object {[datetime]::IsLeapYear($_.Year)}
            $leapYears.Count | Should -Be 0
        }
    
        It "months are random" {
            $months = $birthDates | Group-Object -Property Month | Measure-Object
            $months.Count | Should -Be 12
        }
    
        It "days are random" {
            $days = $birthDates | Group-Object -Property Day | Measure-Object
            $days.Count | Should -Be 31
        }

        It "years are different between batches" {
            $yearsInBatches = 1..5 | ForEach-Object  {Get-RandomBirthdates -People 1} | Group-Object -Property Year | Measure-Object
            $yearsInBatches.Count | Should -BeGreaterThan 1
        }
    }

    Context "estimated probability" {
        BeforeAll {
            $tolerance = 2
            function Test-Probability($Probability, $Expected, $Tolerance) {
                ($Probability -ge $Expected - $Tolerance) -and ($Probability -le $Expected + $Tolerance)
            }
        }

        It "of at least one for one person" {
            $expected = 0
            $probability = Invoke-BafflingBirthdays -People 1

            $got = Test-Probability $probability $expected $tolerance
            $got | Should -BeTrue
        }
    
        It "of at least one among ten people" {
            $expected = 11.694818
            $probability = Invoke-BafflingBirthdays -People 10
            
            $got = Test-Probability $probability $expected $tolerance
            $got | Should -BeTrue
        }
    
        It "of at least one among twenty-three people" {
            $expected = 50.729723
            $probability = Invoke-BafflingBirthdays -People 23
            
            $got = Test-Probability $probability $expected $tolerance
            $got | Should -BeTrue
        }
    
        It "of at least one among seventy people" {
            $expected = 99.915958
            $probability = Invoke-BafflingBirthdays -People 70
            
            $got = Test-Probability $probability $expected $tolerance
            $got | Should -BeTrue
        }
    }
}
