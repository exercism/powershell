BeforeAll {
    . "./PrimeFactors.ps1"
}

Describe "Test Invoke-PrimeFactors.ps1" {
    It "no factors" {
        $got = Invoke-PrimeFactors -Number 1
        $want = @()

        $got | Should -BeExactly $want
    }

    It "prime number" {
        $got = Invoke-PrimeFactors -Number 2
        $want = @(2)

        $got | Should -BeExactly $want
    }

    It "another prime number" {
        $got = Invoke-PrimeFactors -Number 3
        $want = @(3)

        $got | Should -BeExactly $want
    }

    It "square of a prime" {
        $got = Invoke-PrimeFactors -Number 9
        $want = @(3, 3)

        $got | Should -BeExactly $want
    }

    It "product of the first prime" {
        $got = Invoke-PrimeFactors -Number 4
        $want = @(2, 2)

        $got | Should -BeExactly $want
    }

    It "cube of a prime" {
        $got = Invoke-PrimeFactors -Number 8
        $want = @(2, 2, 2)

        $got | Should -BeExactly $want
    }

    It "product of second prime" {
        $got = Invoke-PrimeFactors -Number 27
        $want = @(3, 3, 3)

        $got | Should -BeExactly $want
    }

    It "product of third prime" {
        $got = Invoke-PrimeFactors -Number 625
        $want = @(5, 5, 5, 5)

        $got | Should -BeExactly $want
    }

    It "product of first and second prime" {
        $got = Invoke-PrimeFactors -Number 6
        $want = @(2,3)

        $got | Should -BeExactly $want
    }

    It "product of primes and non-primes" {
        $got = Invoke-PrimeFactors -Number 12
        $want = @(2, 2, 3)

        $got | Should -BeExactly $want
    }

    It "product of primes" {
        $got = Invoke-PrimeFactors -Number 901255
        $want = @(5, 17, 23, 461)

        $got | Should -BeExactly $want
    }

    It "factors include a large prime" {
        $got = Invoke-PrimeFactors -Number 93819012551
        $want = @(11, 9539, 894119)

        $got | Should -BeExactly $want
    }
}
