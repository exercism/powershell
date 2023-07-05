BeforeAll {
    . "./Darts.ps1"
}

Describe "Test Invoke-Darts.ps1" {
    It "Missed target" {
        $got = Invoke-Darts -X -9 -Y 9
        $want = 0

        $got | Should -BeExactly $want
    }

    It "On the outer circle" {
        $got = Invoke-Darts -X 0 -Y 10
        $want = 1

        $got | Should -BeExactly $want
    }

    It "On the middle circle" {
        $got = Invoke-Darts -X -5 -Y 0
        $want = 5

        $got | Should -BeExactly $want
    }

    It "On the inner circle" {
        $got = Invoke-Darts -X 0 -Y -1
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Exactly on centre" {
        $got = Invoke-Darts -X 0 -Y 0
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Near the centre" {
        $got = Invoke-Darts -X -0.1 -Y -0.1
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Just within the inner circle" {
        $got = Invoke-Darts -X 0.7 -Y 0.7
        $want = 10

        $got | Should -BeExactly $want
    }

    It "Just outside the inner circle" {
        $got = Invoke-Darts -X 0.8 -Y -0.8
        $want = 5

        $got | Should -BeExactly $want
    }

    It "Just within the middle circle" {
        $got = Invoke-Darts -X -3.5 -Y 3.5
        $want = 5

        $got | Should -BeExactly $want
    }

    It "Just outside the middle circle" {
        $got = Invoke-Darts -X -3.6 -Y -3.6
        $want = 1

        $got | Should -BeExactly $want
    }

    It "Just within the outer circle" {
        $got = Invoke-Darts -X -7.0 -Y 7.0
        $want = 1

        $got | Should -BeExactly $want
    }

    It "Just outside the outer circle" {
        $got = Invoke-Darts -X 7.1 -Y -7.1
        $want = 0

        $got | Should -BeExactly $want
    }

    It "Asymmetric position between the inner and middle circles" {
        $got = Invoke-Darts -X 0.5 -Y -4
        $want = 5

        $got | Should -BeExactly $want
    }
}
