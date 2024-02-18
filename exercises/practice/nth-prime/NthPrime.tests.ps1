BeforeAll {
    . ".\NthPrime.ps1"
}

Describe "NthPrime Tests" {
    Context "Passing Tests" {
        It "first prime" {
            $got = Get-NthPrime -Number 1
            $want = 2
            
            $got | Should -Be $want
        }

        It "second prime" {
            $got = Get-NthPrime -Number 2
            $want = 3
            
            $got | Should -Be $want
        }

        It "sixth prime" {
            $got = Get-NthPrime -Number 6
            $want = 13
            
            $got | Should -Be $want
        }

        It "big prime" {
            $got = Get-NthPrime -Number 10001
            $want = 104743
            
            $got | Should -Be $want
        }
    }

    Context "Invalid Inputs" {
        It "there is no zeroth prime" {
            { Get-NthPrime -Number 0 } | Should -Throw "*error: there is no zeroth prime*"
        }
    }
}
