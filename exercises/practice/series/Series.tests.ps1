BeforeAll {
    . "./Series.ps1"
}

Describe "Test Get-Slices" {
    Context "Passing Tests" {
        It "slices of one from one" {
            $got = Get-Slices -Series "1" -SliceLength 1
            $want = @("1")

            $got | Should -BeExactly $want
        }

        It "slices of one from two" {
            $got = Get-Slices -Series "12" -SliceLength 1
            $want = @("1", "2")

            $got | Should -BeExactly $want
        }

        It "slices of two" {
            $got = Get-Slices -Series "35" -SliceLength 2
            $want = @("35")

            $got | Should -BeExactly $want
        }

        It "slices of two overlapping" {
            $got = Get-Slices -Series "9142" -SliceLength 2
            $want = @("91", "14", "42")

            $got | Should -BeExactly $want
        }

        It "slices can include duplicates" {
            $got = Get-Slices -Series "777777" -SliceLength 3
            $want = @("777", "777", "777", "777")

            $got | Should -BeExactly $want
        }

        It "slices of long series" {
            $got = Get-Slices -Series "918493904243" -SliceLength 5
            $want = @("91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243")

            $got | Should -BeExactly $want
        }
    }

    Context "Invalid Inputs" {
        It "slice length is too large" {
            { Get-Slices -Series "12345" -SliceLength 6 } | Should -Throw "Slice length cannot be greater than series length."
        }

        It "slice length is way too large" {
            { Get-Slices -Series "12345" -SliceLength 42 } | Should -Throw "Slice length cannot be greater than series length."
        }

        It "slice length cannot be zero" {
            { Get-Slices -Series "12345" -SliceLength 0 } | Should -Throw "Slice length cannot be zero."
        }

        It "slice length cannot be negative" {
            { Get-Slices -Series "123" -SliceLength -1 } | Should -Throw "Slice length cannot be negative."
        }

        It "empty series is invalid" {
            { Get-Slices -Series "" -SliceLength 1 } | Should -Throw "Series cannot be empty."
        }
    }
}
