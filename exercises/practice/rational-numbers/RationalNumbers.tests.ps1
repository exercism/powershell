BeforeAll {
    . "./RationalNumbers.ps1"
}

Describe "RationalNumbers test cases" {
    Context "Addition operations" {
        It "Add two positive rational numbers" {
            $got  = [Rational]::new(1, 2) + [Rational]::new(2, 3)
            $want = [Rational]::new(7, 6)

            $got | Should -BeExactly $want
        }
    
        It "Add a positive rational number and a negative rational number" {
            $got  = [Rational]::new(1, 2) + [Rational]::new(-2, 3)
            $want = [Rational]::new(-1, 6)

            $got | Should -BeExactly $want
        }
    
        It "Add two negative rational numbers" {
            $got  = [Rational]::new(-1, 2) + [Rational]::new(-2, 3)
            $want = [Rational]::new(-7, 6)

            $got | Should -BeExactly $want
        }
    
        It "Add a rational number to its additive inverse" {
            $got  = [Rational]::new(1, 2) + [Rational]::new(-1, 2)
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    }

    Context "Subtraction operation" {
        It "Subtract two positive rational numbers" {
            $got  = [Rational]::new(1, 2) - [Rational]::new(2, 3)
            $want = [Rational]::new(-1, 6)

            $got | Should -BeExactly $want
        }
    
        It "Subtract a positive rational number and a negative rational number" {
            $got  = [Rational]::new(1, 2) - [Rational]::new(-2, 3)
            $want = [Rational]::new(7, 6)

            $got | Should -BeExactly $want
        }
    
        It "Subtract two negative rational numbers" {
            $got  = [Rational]::new(-1, 2) - [Rational]::new(-2, 3)
            $want = [Rational]::new(1, 6)

            $got | Should -BeExactly $want
        }
    
        It "Subtract a rational number from itself" {
            $got  = [Rational]::new(1, 2) - [Rational]::new(1, 2)
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    }
    
    Context "Multiplication operation" {
        It "Multiply two positive rational numbers" {
            $got  = [Rational]::new(1, 2) * [Rational]::new(2, 3)
            $want = [Rational]::new(1, 3)

            $got | Should -BeExactly $want
        }
    
        It "Multiply a negative rational number by a positive rational number" {
            $got  = [Rational]::new(-1, 2) * [Rational]::new(2, 3)
            $want = [Rational]::new(-1, 3)

            $got | Should -BeExactly $want
        }
    
        It "Multiply two negative rational numbers" {
            $got  = [Rational]::new(-1, 2) * [Rational]::new(-2, 3)
            $want = [Rational]::new(1, 3)

            $got | Should -BeExactly $want
        }
    
        It "Multiply a rational number by its reciprocal" {
            $got  = [Rational]::new(1, 2) * [Rational]::new(2, 1)
            $want = [Rational]::new(1, 1)

            $got | Should -BeExactly $want
        }
    
        It "Multiply a rational number by 1" {
            $got  = [Rational]::new(1, 2) * [Rational]::new(1, 1)
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Multiply a rational number by 0" {
            $got  = [Rational]::new(1, 2) * [Rational]::new(0, 1)
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    }
    
    Context "Division operation" {
        It "Divide two positive rational numbers" {
            $got  = [Rational]::new(1, 2) / [Rational]::new(2, 3)
            $want = [Rational]::new(3, 4)

            $got | Should -BeExactly $want
        }
    
        It "Divide a positive rational number by a negative rational number" {
            $got  = [Rational]::new(1, 2) / [Rational]::new(-2, 3)
            $want = [Rational]::new(-3, 4)

            $got | Should -BeExactly $want
        }
    
        It "Divide two negative rational numbers" {
            $got  = [Rational]::new(-1, 2) / [Rational]::new(-2, 3)
            $want = [Rational]::new(3, 4)

            $got | Should -BeExactly $want
        }
    
        It "Divide a rational number by 1" {
            $got  = [Rational]::new(1, 2) / [Rational]::new(1, 1)
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    }

    Context "Absolute value" {
        It "Absolute value of a positive rational number" {
            $got  = [Rational]::new(1, 2).Abs()
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Absolute value of a positive rational number with negative numerator and denominator" {
            $got  = [Rational]::new(-1, -2).Abs()
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Absolute value of a negative rational number" {
            $got  = [Rational]::new(-1, 2).Abs()
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Absolute value of a negative rational number with negative denominator" {
            $got  = [Rational]::new(1, -2).Abs()
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Absolute value of zero" {
            $got  = [Rational]::new(0, 1).Abs()
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    
        It "Absolute value of a rational number is reduced to lowest terms" {
            $got  = [Rational]::new(2, 4).Abs()
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    }
    
    Context "Exponentiation of a rational number" {
        It "Raise a positive rational number to a positive integer power" {
            $got  = [Rational]::new(1, 2).Power(3)
            $want = [Rational]::new(1, 8)

            $got | Should -BeExactly $want
        }
    
        It "Raise a negative rational number to a positive integer power" {
            $got  = [Rational]::new(-1, 2).Power(3)
            $want = [Rational]::new(-1, 8)

            $got | Should -BeExactly $want
        }
    
        It "Raise a positive rational number to a negative integer power" {
            $got  = [Rational]::new(3, 5).Power(-2)
            $want = [Rational]::new(25, 9)

            $got | Should -BeExactly $want
        }
    
        It "Raise a negative rational number to an even negative integer power" {
            $got  = [Rational]::new(-3, 5).Power(-2)
            $want = [Rational]::new(25, 9)

            $got | Should -BeExactly $want
        }
    
        It "Raise a negative rational number to an odd negative integer power" {
            $got  = [Rational]::new(-3, 5).Power(-3)
            $want = [Rational]::new(-125, 27)

            $got | Should -BeExactly $want
        }
    
        It "Raise zero to an integer power" {
            $got  = [Rational]::new(0, 1).Power(5)
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    
        It "Raise one to an integer power" {
            $got  = [Rational]::new(1, 1).Power(4)
            $want = [Rational]::new(1, 1)

            $got | Should -BeExactly $want
        }
    
        It "Raise a positive rational number to the power of zero" {
            $got  = [Rational]::new(1, 2).Power(0)
            $want = [Rational]::new(1, 1)

            $got | Should -BeExactly $want
        }
    
        It "Raise a negative rational number to the power of zero" {
            $got  = [Rational]::new(-1, 2).Power(0)
            $want = [Rational]::new(1, 1)

            $got | Should -BeExactly $want
        }
    }

    Context "Exponentiation of a real number to a rational number" {
        It "Raise a real number to a positive rational number" {
            $got  = [Rational]::new(4, 3).ReversePower(8)
            $want = 16.0
            $tolerance = [Math]::Abs($got - $want)

            $tolerance | Should -BeLessOrEqual 0.00000001
        }
    
        It "Raise a real number to a negative rational number" {
            $got  = [Rational]::new(-1, 2).ReversePower(9)
            $want = 0.3333333333333333
            $tolerance = [Math]::Abs($got - $want)

            $tolerance | Should -BeLessOrEqual 0.00000001
        }
    
        It "Raise a real number to a zero rational number" {
            $got  = [Rational]::new(0, 1).ReversePower(2)
            $want = 1.0
            $tolerance = [Math]::Abs($got - $want)

            $tolerance | Should -BeLessOrEqual 0.00000001
        }
    }
    
    Context "Reduction to lowest terms" {
        It "Reduce a positive rational number to lowest terms" {
            $got  = [Rational]::new(2, 4)
            $want = [Rational]::new(1, 2)

            $got | Should -BeExactly $want
        }
    
        It "Reduce places the minus sign on the numerator" {
            $got  = [Rational]::new(3, -4)
            $want = [Rational]::new(-3, 4)

            $got | Should -BeExactly $want
        }
    
        It "Reduce a negative rational number to lowest terms" {
            $got  = [Rational]::new(-4, 6)
            $want = [Rational]::new(-2, 3)

            $got | Should -BeExactly $want
        }
    
        It "Reduce a rational number with a negative denominator to lowest terms" {
            $got  = [Rational]::new(3, -9)
            $want = [Rational]::new(-1, 3)

            $got | Should -BeExactly $want
        }
    
        It "Reduce zero to lowest terms" {
            $got  = [Rational]::new(0, 6)
            $want = [Rational]::new(0, 1)

            $got | Should -BeExactly $want
        }
    
        It "Reduce an integer to lowest terms" {
            $got  = [Rational]::new(-14, 7)
            $want = [Rational]::new(-2, 1)

            $got | Should -BeExactly $want
        }
    
        It "Reduce one to lowest terms" {
            $got  = [Rational]::new(13, 13)
            $want = [Rational]::new(1, 1)

            $got | Should -BeExactly $want
        }
    }
}
