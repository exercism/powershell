BeforeAll {
    . "./ArmstrongNumbers.ps1"
}

Describe "Test Invoke-ArmstrongNumbers.ps1" {
    It "Zero is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 0
        $want = $True

        $got | Should -Be $want
    }

    It "Single-digit numbers are Armstrong numbers" {
        $got = Invoke-ArmstrongNumbers -Number 5
        $want = $True

        $got | Should -BeExactly $want
    }

    It "There are no two-digit Armstrong numbers" {
        $got = Invoke-ArmstrongNumbers -Number 10
        $want = $False

        $got | Should -BeExactly $want
    }
    
    It "Three-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 153
        $want = $True

        $got | Should -BeExactly $want
    }

    It "Three-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 100
        $want = $False

        $got | Should -BeExactly $want
    }

    It "Four-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9474
        $want = $True

        $got | Should -BeExactly $want
    }

    It "Four-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9475
        $want = $False

        $got | Should -BeExactly $want
    }

    It "Seven-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9926315
        $want = $True

        $got | Should -BeExactly $want
    }

    It "Seven-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9926314
        $want = $False

        $got | Should -BeExactly $want
    }
}
