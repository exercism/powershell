BeforeAll {
    . "./ArmstrongNumbers.ps1"
}

Describe "Test Invoke-ArmstrongNumbers.ps1" {
    It "Zero is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 0

        $got | Should -BeTrue
    }

    It "Single-digit numbers are Armstrong numbers" {
        $got = Invoke-ArmstrongNumbers -Number 5

        $got | Should -BeTrue
    }

    It "There are no two-digit Armstrong numbers" {
        $got = Invoke-ArmstrongNumbers -Number 10

        $got | Should -BeFalse
    }
    
    It "Three-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 153

        $got | Should -BeTrue
    }

    It "Three-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 100

        $got | Should -BeFalse
    }

    It "Four-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9474

        $got | Should -BeTrue
    }

    It "Four-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9475

        $got | Should -BeFalse
    }

    It "Seven-digit number that is an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9926315

        $got | Should -BeTrue
    }

    It "Seven-digit number that is not an Armstrong number" {
        $got = Invoke-ArmstrongNumbers -Number 9926314

        $got | Should -BeFalse
    }
}
