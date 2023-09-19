<#
.SYNOPSIS
    Implement a class represent a rational number.

.DESCRIPTION
    A rational number is defined as the quotient of two integers 'a' (numerator) and 'b' (denominator) where 'b != 0'.
    Please implement the following operations:
    - addition, subtraction, multiplication and division of two rational numbers,
    - absolute value, exponentiation of a given rational number to an integer power, exponentiation of a given rational number to a real (floating-point) power, exponentiation of a real number to a rational number.
    Your implementation of rational numbers should always be reduced to lowest terms.
    For example, `4/4` should reduce to `1/1`, `30/60` should reduce to `1/2`, `12/8` should reduce to `3/2`, etc.
    
.EXAMPLE
    $r1 = [Rational]::new(3,4)
    $r2 = [Rational]::new(5,6)

    $add = $r1 + $r2
    $add.ToString()
    Return: 19/12

    $sub = $r1 - $r2
    $sub.ToString()
    Return: -1/12

    $exp = $r1.Power(2)
    $exp.ToString()
    Return: 9/16
#>

Class Rational {
    [int] $Numer
    [int] $Denom

    Rational() {
        Throw "Please implement this class"
    }

    [bool] Equals($other) {
        return ($this.Numer -eq $other.Numer) -and ($this.Denom -eq $other.Denom)
    }

    [string] ToString() {
        return "$($this.Numer)/$($this.Denom)"
    }

    op_Addition() {
        Throw "Please implement this function"
    }

    op_Subtraction() {
        Throw "Please implement this function"
    }

    op_Multiply() {
        Throw "Please implement this function"
    }

    op_Division() {
        Throw "Please implement this function"
    }

    Abs() {
        Throw "Please implement this function"
    }

    Power() {
        Throw "Please implement this function"
    }

    ReversePower() {
        Throw "Please implement this function"
    }
}