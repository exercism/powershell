BeforeAll {
    . "./PerfectNumbers.ps1"
}

Describe "Test Invoke-PerfectNumbers.ps1" {
    Context "Passing Tests" {
        It "Smallest perfect number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 6
            $want = "perfect"

            $got | Should -BeExactly $want
        }

        It "Medium perfect number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 28
            $want = "perfect"

            $got | Should -BeExactly $want
        }

        It "Large perfect number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 33550336
            $want = "perfect"

            $got | Should -BeExactly $want
        }

        It "Smallest abundant number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 12
            $want = "abundant"

            $got | Should -BeExactly $want
        }

        It "Medium abundant number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 30
            $want = "abundant"

            $got | Should -BeExactly $want
        }

        It "Large abundant number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 33550335
            $want = "abundant"

            $got | Should -BeExactly $want
        }

        It "Smallest prime deficient number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 2
            $want = "deficient"

            $got | Should -BeExactly $want
        }

        It "Smallest non-prime deficient number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 4
            $want = "deficient"

            $got | Should -BeExactly $want
        }

        It "Medium deficient number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 32
            $want = "deficient"

            $got | Should -BeExactly $want
        }

        It "Large deficient number is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 33550337
            $want = "deficient"

            $got | Should -BeExactly $want
        }

        It "Edge case (no factors other than itself) is classified correctly" {
            $got = Invoke-PerfectNumbers -Number 1
            $want = "deficient"

            $got | Should -BeExactly $want
        }
    }

    Context "Invalid Inputs" {
        It "Zero is rejected (not a natural number)" {
            { Invoke-PerfectNumbers -Number 0 } | Should -Throw "error: Classification is only possible for positive integers."
        }

        It "Negative integer is rejected (not a natural number)" {
            { Invoke-PerfectNumbers -Number -1 } | Should -Throw "error: Classification is only possible for positive integers."
        }
    }
}
