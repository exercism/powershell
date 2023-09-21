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
    [int] hidden $Numer
    [int] hidden $Denom

    Rational([int] $Numer, [int] $Denom) {
        $this.Numer = $Numer
        $this.Denom = $Denom
        $this.Reduce()
    }

    [bool] Equals($other) {
        return ($this.Numer -eq $other.Numer) -and ($this.Denom -eq $other.Denom)
    }

    [string] ToString() {
        return "$($this.Numer)/$($this.Denom)"
    }

    static [Rational] op_Addition([Rational]$self, [Rational]$other) {
        $newNumer = $self.Numer * $other.Denom + $other.Numer * $self.Denom
        $newDenom = $self.Denom * $other.Denom
        return [Rational]::new($newNumer, $newDenom)
    }

    static [Rational] op_Subtraction([Rational]$self, [Rational]$other) {
        $newNumer = $self.Numer * $other.Denom - $other.Numer * $self.Denom
        $newDenom = $self.Denom * $other.Denom
        return [Rational]::new($newNumer, $newDenom)
    }

    static [Rational] op_Multiply([Rational]$self, [Rational]$other) {
        $newNumer = $self.Numer * $other.Numer
        $newDenom = $self.Denom * $other.Denom
        return [Rational]::new($newNumer, $newDenom)
    }

    static [Rational] op_Division([Rational]$self, [Rational]$other) {
        if ($other.Numer -eq 0) {Throw "Can't divide by zero"}
        $newNumer = $self.Numer * $other.Denom 
        $newDenom = $other.Numer * $self.Denom
        return [Rational]::new($newNumer, $newDenom)
    }

    [Rational] Abs() {
        $this.Numer = $this.Numer -lt 0 ? $this.Numer * -1 : $this.Numer
        return [Rational]::new($this.Numer, $this.Denom)
    }

    [object] Power($power) {
        if ($power -is [int]) {
            if ($power -ge 0) {
                $newNumer = [Math]::Pow($this.Numer, $power)
                $newDenom = [Math]::Pow($this.Denom, $power)
                return [Rational]::new($newNumer, $newDenom)
            }else {
                $power *= -1
                $newNumer = [Math]::Pow($this.Denom, $power)
                $newDenom = [Math]::Pow($this.Numer, $power)
                return [Rational]::new($newNumer, $newDenom)
            }
        }elseif ($power -is [double])  {
            return [Math]::Pow($this.Numer, $power) / [Math]::Pow($this.Denom, $power)
        }
        return $this
    }

    [double] ReversePower($base) {
        $tempBase = [Math]::Pow($base, $this.Numer)
        $power = 1 / $this.Denom
        return [Math]::Pow($tempBase, $power)
    }

    [int] hidden GetGCD($a,$b){
        while ($b) {
            $a, $b = $b, ($a % $b)
        }
        return [Math]::Abs($a)
    }

    [void] hidden Reduce() {
        $gcd = $this.GetGCD($this.Numer,$this.Denom)
        if ($this.Denom -lt 0) {
            $this.Numer /= -$gcd
            $this.Denom /= -$gcd
        }else {
            $this.Numer /= $gcd
            $this.Denom /= $gcd
        }
    }
}