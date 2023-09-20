BeforeAll {
    . "./ComplexNumbers.ps1"
}

Describe "ComplexNumbers test cases" {
    Context "Complex number properties" {
        It "Real part -> Real part of a purely real number" {
            $number = [ComplexNumber]::new(1, 0)

            $number.real | Should -BeExactly 1
        }
    
        It "Real part -> Real part of a purely imaginary number" {
            $number = [ComplexNumber]::new(0, 1)

            $number.real | Should -BeExactly 0
        }
    
        It "Real part -> Real part of a number with real and imaginary part" {
            $number = [ComplexNumber]::new(1, 2)

            $number.real | Should -BeExactly 1
        }
    
        It "Imaginary part -> Imaginary part of a purely real number" {
            $number = [ComplexNumber]::new(1, 0)

            $number.imaginary | Should -BeExactly 0
        }
    
        It "Imaginary part -> Imaginary part of a purely imaginary number" {
            $number = [ComplexNumber]::new(0, 1)

            $number.imaginary | Should -BeExactly 1
        }
    
        It "Imaginary part -> Imaginary part of a number with real and imaginary part" {
            $number = [ComplexNumber]::new(1, 2)

            $number.imaginary | Should -BeExactly 2
        }
    
        It "Imaginary unit" {
            $got  = [ComplexNumber]::new(0, 1) * [ComplexNumber]::new(0, 1)
            $want = [ComplexNumber]::new(-1, 0)

            $got | Should -BeExactly $want
        }
    }
    
    Context "Arithmetic" {
        It "Addition -> Add purely real numbers" {
            $got  = [ComplexNumber]::new(1, 0) + [ComplexNumber]::new(2, 0)
            $want = [ComplexNumber]::new(3, 0)

            $got | Should -BeExactly $want
        }
    
        It "Addition -> Add purely imaginary numbers" {
            $got  = [ComplexNumber]::new(0, 1) + [ComplexNumber]::new(0, 2)
            $want = [ComplexNumber]::new(0, 3)

            $got | Should -BeExactly $want
        }
    
        It "Addition -> Add numbers with real and imaginary part" {
            $got  = [ComplexNumber]::new(1, 2) + [ComplexNumber]::new(3, 4)
            $want = [ComplexNumber]::new(4, 6)

            $got | Should -BeExactly $want
        }
    
        It "Subtraction -> Subtract purely real numbers" {
            $got  = [ComplexNumber]::new(1, 0) - [ComplexNumber]::new(2, 0)
            $want = [ComplexNumber]::new(-1, 0)

            $got | Should -BeExactly $want
        }
    
        It "Subtraction -> Subtract purely imaginary numbers" {
            $got  = [ComplexNumber]::new(0, 1) - [ComplexNumber]::new(0, 2)
            $want = [ComplexNumber]::new(0, -1)

            $got | Should -BeExactly $want
        }
    
        It "Subtraction -> Subtract numbers with real and imaginary part" {
            $got  = [ComplexNumber]::new(1, 2) - [ComplexNumber]::new(3, 4)
            $want = [ComplexNumber]::new(-2, -2)

            $got | Should -BeExactly $want
        }
    
        It "Multiplication -> Multiply purely real numbers" {
            $got  = [ComplexNumber]::new(1, 0) * [ComplexNumber]::new(2, 0)
            $want = [ComplexNumber]::new(2, 0)

            $got | Should -BeExactly $want
        }
    
        It "Multiplication -> Multiply purely imaginary numbers" {
            $got  = [ComplexNumber]::new(0, 1) * [ComplexNumber]::new(0, 2)
            $want = [ComplexNumber]::new(-2, 0)

            $got | Should -BeExactly $want
        }
    
        It "Multiplication -> Multiply numbers with real and imaginary part" {
            $got  = [ComplexNumber]::new(1, 2) * [ComplexNumber]::new(3, 4)
            $want = [ComplexNumber]::new(-5, 10)

            $got | Should -BeExactly $want
        }
    
        It "Division -> Divide purely real numbers" {
            $got  = [ComplexNumber]::new(1, 0) / [ComplexNumber]::new(2, 0)
            $want = [ComplexNumber]::new(0.5, 0)

            $got | Should -BeExactly $want
        }
    
        It "Division -> Divide purely imaginary numbers" {
            $got  = [ComplexNumber]::new(0, 1) / [ComplexNumber]::new(0, 2)
            $want = [ComplexNumber]::new(0.5, 0)

            $got | Should -BeExactly $want
        }
    
        It "Division -> Divide numbers with real and imaginary part" {
            $got  = [ComplexNumber]::new(1, 2) / [ComplexNumber]::new(3, 4)
            $want = [ComplexNumber]::new(0.44, 0.08)

            $got | Should -BeExactly $want
        }
    }

    Context "Absolute value" {
        It "Absolute value of a positive purely real number" {
            $number  = [ComplexNumber]::new(5, 0)

            $number.Abs() | Should -BeExactly 5
        }
    
        It "Absolute value of a negative purely real number" {
            $number  = [ComplexNumber]::new(-5, 0)

            $number.Abs() | Should -BeExactly 5
        }
    
        It "Absolute value of a purely imaginary number with positive imaginary part" {
            $number  = [ComplexNumber]::new(0, 5)

            $number.Abs() | Should -BeExactly 5
        }
    
        It "Absolute value of a purely imaginary number with negative imaginary part" {
            $number  = [ComplexNumber]::new(0, -5)

            $number.Abs() | Should -BeExactly 5
        }
    
        It "Absolute value of a number with real and imaginary part" {
            $number  = [ComplexNumber]::new(3, 4)

            $number.Abs() | Should -BeExactly 5
        }
    }
    
    Context "Complex conjugate" {
        It "Conjugate a purely real number" {
            $got  = [ComplexNumber]::new(5, 0).Conjugate()
            $want = [ComplexNumber]::new(5, 0)
            
            $got | Should -BeExactly $want
        }
    
        It "Conjugate a purely imaginary number" {
            $got  = [ComplexNumber]::new(0, 5).Conjugate()
            $want = [ComplexNumber]::new(0, -5)
            
            $got | Should -BeExactly $want
        }
    
        It "Conjugate a number with real and imaginary part" {
            $got  = [ComplexNumber]::new(1, 1).Conjugate()
            $want = [ComplexNumber]::new(1, -1)
            
            $got | Should -BeExactly $want
        }
    }

    Context "Complex exponential function" {
        It "Euler's identity/formula" {
            $got  = [ComplexNumber]::new(0, [Math]::PI).Exp()
            $want = [ComplexNumber]::new(-1, 0)
            
            $got | Should -BeExactly $want
        }
    
        It "Exponential of 0" {
            $got  = [ComplexNumber]::new(0, 0).Exp()
            $want = [ComplexNumber]::new(1, 0)
            
            $got | Should -BeExactly $want
        }
    
        It "Exponential of a purely real number" {
            $got  = [ComplexNumber]::new(1, 0).Exp()
            $want = [ComplexNumber]::new([Math]::E, 0)
            
            $got | Should -BeExactly $want
        }
    
        It "Exponential of a number with real and imaginary part" {
            $got  = [ComplexNumber]::new([Math]::Log(2), [Math]::PI).Exp()
            $want = [ComplexNumber]::new(-2, 0)
            
            $got | Should -BeExactly $want
        }
    
        It "Exponential resulting in a number with real and imaginary part" {
            $got  = [ComplexNumber]::new([Math]::Log(2) / 2, [Math]::PI / 4).Exp()
            $want = [ComplexNumber]::new(1, 1)
            
            $got | Should -BeExactly $want
        }
    }
    
    Context "Operations between real numbers and complex numbers" {
        It "Add real number to complex number" {
            $got  = [ComplexNumber]::new(1, 2) + 5
            $want = [ComplexNumber]::new(6, 2)

            $got | Should -BeExactly $want
        }
    
        It "Add complex number to real number" {
            $got  = 5 + [ComplexNumber]::new(1, 2)
            $want = [ComplexNumber]::new(6, 2)

            $got | Should -BeExactly $want
        }
    
        It "Subtract real number from complex number" {
            $got  = [ComplexNumber]::new(5, 7) - 4
            $want = [ComplexNumber]::new(1, 7)

            $got | Should -BeExactly $want
        }
    
        It "Subtract complex number from real number" {
            $got  = 4 - [ComplexNumber]::new(5, 7)
            $want = [ComplexNumber]::new(-1, -7)

            $got | Should -BeExactly $want
        }
    
        It "Multiply complex number by real number" {
            $got  = [ComplexNumber]::new(2, 5) * 5
            $want = [ComplexNumber]::new(10, 25)

            $got | Should -BeExactly $want
        }
    
        It "Multiply real number by complex number" {
            $got  = 5 * [ComplexNumber]::new(2, 5)
            $want = [ComplexNumber]::new(10, 25)

            $got | Should -BeExactly $want
        }
    
        It "Divide complex number by real number" {
            $got  = [ComplexNumber]::new(10, 100) / 10
            $want = [ComplexNumber]::new(1, 10)

            $got | Should -BeExactly $want
        }
    
        It "Divide real number by complex number" {
            $got  = 5 / [ComplexNumber]::new(1, 1)
            $want = [ComplexNumber]::new(2.5, -2.5)

            $got | Should -BeExactly $want
        }
    }

    Context "Equality check" {
        It "Equality of complex numbers" {
            $got = [ComplexNumber]::new(1, 2) -eq [ComplexNumber]::new(1, 2)
            
            $got | Should -BeTrue
        }

        It "Inquality of real part" {
            $got = [ComplexNumber]::new(1, 2) -eq [ComplexNumber]::new(2, 2)
            
            $got | Should -BeFalse
        }

        It "Inquality of imaginary part" {
            $got = [ComplexNumber]::new(1, 2) -eq [ComplexNumber]::new(1, 1)
            
            $got | Should -BeFalse
        }
    }
}
