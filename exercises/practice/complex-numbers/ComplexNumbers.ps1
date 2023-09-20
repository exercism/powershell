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

    ComplexNumber([double]$real, [double]$imaginary) {
        $this.real = $real
        $this.imaginary = $imaginary
    }

    [bool] Equals($other) {
        return ($this.real -eq $other.real) -and ($this.imaginary -eq $other.imaginary)
    }

    static [ComplexNumber] op_Addition($first, $second) {
        if ($first -is [ComplexNumber] -and $second -is [ComplexNumber]) {
            $newReal = $first.real + $second.real
            $newImg  = $first.imaginary + $second.imaginary
            return [ComplexNumber]::new($newReal , $newImg)
        }elseif ($first -is [ComplexNumber]) {
            $newReal = $first.real + $second
            return [ComplexNumber]::new($newReal , $first.imaginary)
        }else {
            $newReal = $first + $second.real
            return [ComplexNumber]::new($newReal , $second.imaginary)
        }
    }

    static [ComplexNumber] op_Subtraction($first, $second) {
        if ($first -is [ComplexNumber] -and $second -is [ComplexNumber]) {
            $newReal = $first.real - $second.real
            $newImg  = $first.imaginary - $second.imaginary
            return [ComplexNumber]::new($newReal , $newImg)
        }elseif ($first -is [ComplexNumber]) {
            $newReal = $first.real - $second
            return [ComplexNumber]::new($newReal , $first.imaginary)
        }else {
            $newReal = $first - $second.real
            $newImg  = $newReal -lt 0 ? $second.imaginary * -1 : $second.imaginary
            return [ComplexNumber]::new($newReal , $newImg)
        }
    }

    static [ComplexNumber] op_Multiply($first, $second) {
        if ($first -is [ComplexNumber] -and $second -is [ComplexNumber]) {
            $newReal = ($first.real * $second.real) - ($first.imaginary * $second.imaginary)
            $newImg  = ($first.imaginary * $second.real) + ($first.real * $second.imaginary)
            return [ComplexNumber]::new($newReal , $newImg)
        }elseif ($first -is [ComplexNumber]) {
            $newReal = $first.real * $second
            $newImg  = $first.imaginary * $second
            return [ComplexNumber]::new($newReal , $newImg)
        }else {
            $newReal = $first * $second.real
            $newImg  = $first * $second.imaginary
            return [ComplexNumber]::new($newReal , $newImg)
        }
    }

    static [ComplexNumber] op_Division($first, $second) {
        if ($first -is [ComplexNumber] -and $second -is [ComplexNumber]) {
            $newReal = ($first.real * $second.real + $first.imaginary * $second.imaginary) /
                    ([Math]::Pow($second.real, 2) + [Math]::Pow($second.imaginary, 2))
            $newImg  = ($first.imaginary * $second.real - $first.real * $second.imaginary) /
                    ([Math]::Pow($second.real, 2) + [Math]::Pow($second.imaginary, 2))
            return [ComplexNumber]::new($newReal , $newImg)
        }elseif ($first -is [ComplexNumber]) {
            $newReal = $first.real / $second
            $newImg  = $first.imaginary / $second
            return [ComplexNumber]::new($newReal , $newImg)
        }else {
            $conj = $second.Conjugate()
            $newReal = ($first * $conj.real) / ($second * $conj).real
            $newImg = ($first * $conj.imaginary) / ($second * $conj).real
            return [ComplexNumber]::new($newReal , $newImg)
        }
    }

    [ComplexNumber] Conjugate() {
        return [ComplexNumber]::new($this.real, -$this.imaginary)
    }

    [double] Abs() {
        $sum = [Math]::Pow($this.real, 2) + [Math]::Pow($this.imaginary, 2)
        return [Math]::Sqrt($sum)
    }

    [ComplexNumber] Exp() {
        $newReal = [Math]::Exp($this.real) * [Math]::Cos($this.imaginary)
        $newImg  = [Math]::Exp($this.real) * [Math]::Sin($this.imaginary)
        return [ComplexNumber]::new($newReal, [math]::Round($newImg,2))
    }

    [string] ToString() {
        return "$($this.real) + $($this.imaginary)i"
    }
}