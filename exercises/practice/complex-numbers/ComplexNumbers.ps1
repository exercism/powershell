<#
.SYNOPSIS
    Implement a class represent a complex number.
.DESCRIPTION
    A complex number is a number in the form 'a + b * i' where 'a' and 'b' are real and 'i' satisfies 'i^2 = -1'.
    Please Implement the following operations:
    - addition, subtraction, multiplication and division of two complex numbers,
    - conjugate, absolute value, exponent of a given complex number.
    
.EXAMPLE
    $comp = [ComplexNumber]::new(-1,2)
    $comp2 = [ComplexNumber]::new(3,-4)
    $sum = $comp + $comp2
    $sum.real
    Return: 2
    $sum.imaginary
    Return: -2
    $comp2.Abs()
    Return: 5
#>
class ComplexNumber {
    [double]$real
    [double]$imaginary

    ComplexNumber() {
        Throw "Please implement this class"
    }

    [bool] Equals() {
        Throw "Please implement this function"
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

    Conjugate() {
        Throw "Please implement this function"
    }

    Abs() {
        Throw "Please implement this function"
    }

    Exp() {
        Throw "Please implement this function"
    }
}