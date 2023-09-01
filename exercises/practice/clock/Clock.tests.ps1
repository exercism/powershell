BeforeAll {
    . "./Clock.ps1"
}

Describe "Clock test cases" {
    Context "create clock" {
        It "on the hour" {
            $clock  = [Clock]::new(9, 0)
            $got    = $clock.ToString()
            $want   = '09:00'

            $got | Should -BeExactly $want
        }

        It "past the hour" {
            $clock  = [Clock]::new(10, 23)
            $got    = $clock.ToString()
            $want   = '10:23'

            $got | Should -BeExactly $want
        }

        It "midnight is zero hours" {
            $clock  = [Clock]::new(24, 0)
            $got    = $clock.ToString()
            $want   = '00:00'

            $got | Should -BeExactly $want
        }

        It "hour rolls over" {
            $clock  = [Clock]::new(25, 0)
            $got    = $clock.ToString()
            $want   = '01:00'

            $got | Should -BeExactly $want
        }

        It "hour rolls over continuously" {
            $clock  = [Clock]::new(100, 0)
            $got    = $clock.ToString()
            $want   = '04:00'

            $got | Should -BeExactly $want
        }

        It "sixty minutes is next hour" {
            $clock  = [Clock]::new(2, 60)
            $got    = $clock.ToString()
            $want   = '03:00'

            $got | Should -BeExactly $want
        }

        It "minutes roll over" {
            $clock  = [Clock]::new(0, 175)
            $got    = $clock.ToString()
            $want   = '02:55'

            $got | Should -BeExactly $want
        }

        It "minutes roll over continuously" {
            $clock  = [Clock]::new(0, 1723)
            $got    = $clock.ToString()
            $want   = '04:43'

            $got | Should -BeExactly $want
        }

        It "hour and minutes roll over" {
            $clock  = [Clock]::new(25, 160)
            $got    = $clock.ToString()
            $want   = '03:40'

            $got | Should -BeExactly $want
        }

        It "hour and minutes roll over continuously" {
            $clock  = [Clock]::new(200, 3015)
            $got    = $clock.ToString()
            $want   = '10:15'

            $got | Should -BeExactly $want
        }

        It "hour and minutes roll over to exactly midnight" {
            $clock  = [Clock]::new(96, 10080)
            $got    = $clock.ToString()
            $want   = '00:00'

            $got | Should -BeExactly $want
        }

        It "negative hour" {
            $clock  = [Clock]::new(-2,25)
            $got    = $clock.ToString()
            $want   = '22:25'

            $got | Should -BeExactly $want
        }

        It "negative hour rolls over" {
            $clock  = [Clock]::new(-27, 0)
            $got    = $clock.ToString()
            $want   = '21:00'

            $got | Should -BeExactly $want
        }

        It "negative hour rolls over continuously" {
            $clock  = [Clock]::new(-91, 0)
            $got    = $clock.ToString()
            $want   = '05:00'

            $got | Should -BeExactly $want
        }

        It "negative minutes" {
            $clock  = [Clock]::new(5, -35)
            $got    = $clock.ToString()
            $want   = '04:25'

            $got | Should -BeExactly $want
        }

        It "negative minutes roll over" {
            $clock  = [Clock]::new(2, -160)
            $got    = $clock.ToString()
            $want   = '23:20'

            $got | Should -BeExactly $want
        }

        It "negative minutes roll over continuously" {
            $clock  = [Clock]::new(1, -4820)
            $got    = $clock.ToString()
            $want   = '16:40'

            $got | Should -BeExactly $want
        }

        It "negative sixty minutes is previous hour" {
            $clock  = [Clock]::new(14, -60)
            $got    = $clock.ToString()
            $want   = '13:00'

            $got | Should -BeExactly $want
        }

        It "negative hour and minutes roll over" {
            $clock  = [Clock]::new(-25, -160)
            $got    = $clock.ToString()
            $want   = '20:20'

            $got | Should -BeExactly $want
        }

        It "negative hour and minutes roll over continuously" {
            $clock  = [Clock]::new(-121, -5810)
            $got    = $clock.ToString()
            $want   = '22:10'

            $got | Should -BeExactly $want
        }
    }

    Context "add and subtract" {
        It "add minutes" {
            $clock  = [Clock]::new(11, 0)
            $got    = $clock.Add(8).ToString()
            $want   = '11:08'

            $got | Should -BeExactly $want
        }

        It "add no minutes" {
            $clock  = [Clock]::new(12, 34)
            $got    = $clock.Add(0).ToString()
            $want   = '12:34'

            $got | Should -BeExactly $want
        }

        It "add to next hour" {
            $clock  = [Clock]::new(12, 45)
            $got    = $clock.Add(37).ToString()
            $want   = '13:22'

            $got | Should -BeExactly $want
        }

        It "add more than one hour" {
            $clock  = [Clock]::new(7, 0)
            $got    = $clock.Add(75).ToString()
            $want   = '08:15'

            $got | Should -BeExactly $want
        }

        It "add more than two hours with carry" {
            $clock  = [Clock]::new(0, 50)
            $got    = $clock.Add(170).ToString()
            $want   = '03:40'

            $got | Should -BeExactly $want
        }

        It "add across midnight" {
            $clock  = [Clock]::new(23, 57)
            $got    = $clock.Add(10).ToString()
            $want   = '00:07'

            $got | Should -BeExactly $want
        }

        It "add more than one day (1500 min = 25 hrs)" {
            $clock  = [Clock]::new(6, 48)
            $got    = $clock.Add(1500).ToString()
            $want   = '07:48'

            $got | Should -BeExactly $want
        }

        It "add more than two days" {
            $clock  = [Clock]::new(2, 3)
            $got    = $clock.Add(3500).ToString()
            $want   = '12:23'

            $got | Should -BeExactly $want
        }

        It "subtract minutes" {
            $clock  = [Clock]::new(8, 45)
            $got    = $clock.Add(-5).ToString()
            $want   = '08:40'

            $got | Should -BeExactly $want
        }

        It "subtract to previous hour" {
            $clock  = [Clock]::new(11, 12)
            $got    = $clock.Add(-25).ToString()
            $want   = '10:47'

            $got | Should -BeExactly $want
        }

        It "subtract more than an hour" {
            $clock  = [Clock]::new(12, 20)
            $got    = $clock.Add(-70).ToString()
            $want   = '11:10'

            $got | Should -BeExactly $want
        }

        It "subtract across midnight" {
            $clock  = [Clock]::new(0, 7)
            $got    = $clock.Add(-9).ToString()
            $want   = '23:58'

            $got | Should -BeExactly $want
        }

        It "subtract more than two hours" {
            $clock  = [Clock]::new(0, 0)
            $got    = $clock.Add(-150).ToString()
            $want   = '21:30'

            $got | Should -BeExactly $want
        }

        It "subtract more than two hours with borrow" {
            $clock  = [Clock]::new(6, 15)
            $got    = $clock.Add(-160).ToString()
            $want   = '03:35'

            $got | Should -BeExactly $want
        }

        It "subtract more than one day (1500 min = 25 hrs)" {
            $clock  = [Clock]::new(3, 30)
            $got    = $clock.Add(-1500).ToString()
            $want   = '02:30'

            $got | Should -BeExactly $want
        }

        It "subtract more than two days" {
            $clock  = [Clock]::new(7, 49)
            $got    = $clock.Add(-3000).ToString()
            $want   = '05:49'

            $got | Should -BeExactly $want
        }
    }

    Context "equality test" {
        It "clocks with same time" {
            $got    = [Clock]::new(12, 34) -eq [Clock]::new(12, 34)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks a minute apart" {
            $got    = [Clock]::new(12, 34) -eq [Clock]::new(12, 35)
            $want   = $false
            
            $got | Should -BeExactly $want
        }

        It "clocks an hour apart" {
            $got    = [Clock]::new(12, 34) -eq [Clock]::new(11, 34)
            $want   = $false
            
            $got | Should -BeExactly $want
        }

        It "clocks with hour overflow" {
            $got    = [Clock]::new(11, 26) -eq [Clock]::new(35, 26)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with hour overflow by several days" {
            $got    = [Clock]::new(3, 15) -eq [Clock]::new(99, 15)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative hour" {
            $got    = [Clock]::new(21, 40) -eq [Clock]::new(-3, 40)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative hour that wraps" {
            $got    = [Clock]::new(17, 3) -eq [Clock]::new(-31, 3)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative hour that wraps multiple times" {
            $got    = [Clock]::new(13, 49) -eq [Clock]::new(-83, 49)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with minute overflow" {
            $got    = [Clock]::new(0, 11) -eq [Clock]::new(0, 1451)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with minute overflow by several days" {
            $got    = [Clock]::new(2, 2) -eq [Clock]::new(2, 4322)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative minute" {
            $got    = [Clock]::new(5, 30) -eq [Clock]::new(6, -30)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative minute that wraps" {
            $got    = [Clock]::new(4, 10) -eq [Clock]::new(5, -1490)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative minute that wraps multiple times" {
            $got    = [Clock]::new(6, 15) -eq [Clock]::new(6, -4305)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative hours and minutes" {
            $got    = [Clock]::new(4, 10) -eq [Clock]::new(5, -1490)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "clocks with negative hours and minutes that wrap" {
            $got    = [Clock]::new(7, 32) -eq [Clock]::new(-12, -268)
            $want   = $true
            
            $got | Should -BeExactly $want
        }

        It "full clock and zeroed clock" {
            $got    = [Clock]::new(18, 7) -eq [Clock]::new(-54, -11513)
            $want   = $true
            
            $got | Should -BeExactly $want
        }
    }
}