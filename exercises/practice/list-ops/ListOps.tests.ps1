BeforeAll {
    . "./ListOps.ps1"
}

Describe "ListOps test cases" {
    Context "append method" {
        It "empty lists" {
            $want = Invoke-Append -List1 @() -List2 @()
            $got  = @()

            $got | Should -BeExactly $want
        }
    
        It "list to empty list" {
            $want = Invoke-Append -List1 @() -List2 @(1, 2, 3, 4)
            $got  = @(1, 2, 3, 4)

            $got | Should -BeExactly $want
        }
    
        It "empty list to list" {
            $want = Invoke-Append -List1 @(1, 2, 3, 4) -List2 @()
            $got  = @(1, 2, 3, 4)

            $got | Should -BeExactly $want
        }
    
        It "non-empty lists" {
            $want = Invoke-Append -List1 @(1, 2) -List2 @(2, 3, 4, 5)
            $got  = @(1, 2, 2, 3, 4, 5)

            $got | Should -BeExactly $want
        }
    }

    Context "concatenate method" {
        It "empty list" {
            $got   = Invoke-Concatenate -Lists @()
            $want  = @()

            $got | Should -BeExactly $want
        }
    
        It "list of lists" {
            $got    = Invoke-Concatenate -Lists @( @(1,2), @(3), @(), @(4,5,6))
            $want   = @(1, 2, 3, 4, 5, 6)

            $got | Should -BeExactly $want
        }
    
        It "list of nested lists" {
            $got   = Invoke-Concatenate -Lists @( @(@(1), @(2)), @(,@(3)), @(,@()), @(,@(4, 5, 6)))
            $want  = @( @(1), @(2), @(3), @(), @(4, 5, 6))

            $got | Should -BeExactly $want
        }
    }
    
    Context "filter method" {
        It "empty list" {
            $isOdd  = {param($x) $x % 2 -eq 1}
            $got    = Invoke-Filter -List @() -Predicate $isOdd
            $want   = @()

            $got | Should -BeExactly $want
        }
    
        It "non-empty list" {
            $isOdd  = {param($x) $x % 2 -eq 1}
            $got    = Invoke-Filter -List @(1, 2, 3, 5) -Predicate $isOdd
            $want   = @(1, 3, 5)

            $got | Should -BeExactly $want
        }
    }

    Context "length method" {
        It "empty list" {
            $got    = Get-Length -List @()
            $want   = 0

            $got | Should -BeExactly $want
        }
    
        It "non-empty list" {
            $got    = Get-Length -List @(1, 2, 3, 4)
            $want   = 4

            $got | Should -BeExactly $want
        }
    }

    Context "map method" {
        It "empty list" {
            $func   = {param($x) $x * 2}
            $got    = Invoke-Map -List @() -Function $func
            $want   = @()

            $got | Should -BeExactly $want
        }
    
        It "non-empty list" {
            $func   = {param($x) $x * 2}
            $got    = Invoke-Map -List @(1, 2, 3, 4) -Function $func
            $want   = @(2, 4, 6, 8)

            $got | Should -BeExactly $want
        }
    }

    Context "fold left method" {
        It "empty list" {
            $func = {param($acc, $e) $e * $acc}
            $got  = Invoke-Foldl -Function $func -List @() -Accumulator 2
            $want = 2

            $got | Should -BeExactly $want
        }
    
        It "direction independent function applied to non-empty list" {
            $func = {param($acc, $e) $e + $acc}
            $got  = Invoke-Foldl -Function $func -List @(1, 2, 3, 4) -Accumulator 5
            $want = 15

            $got | Should -BeExactly $want
        }
    
        It "direction dependent function applied to non-empty list" {
            $func = {param($acc, $e) $e / $acc}
            $got  = Invoke-Foldl -Function $func -List @(1, 2, 3, 4) -Accumulator 24
            $want = 64

            $got | Should -BeExactly $want
        }
    }
    
    Context "fold right method" {
        It "empty list" {
            $func = {param($acc, $e) $e * $acc}
            $got  = Invoke-Foldr -Function $func -List @() -Accumulator 2
            $want = 2

            $got | Should -BeExactly $want
        }
    
        It "direction independent function applied to non-empty list" {
            $func = {param($acc, $e) $e + $acc}
            $got  = Invoke-Foldr -Function $func -List @(1, 2, 3, 4) -Accumulator 5
            $want = 15

            $got | Should -BeExactly $want
        }
    
        It "direction dependent function applied to non-empty list" {
            $func = {param($acc, $e) $e / $acc}
            $got  = Invoke-Foldr -Function $func -List @(1, 2, 3, 4) -Accumulator 24
            $want = 9

            $got | Should -BeExactly $want
        }

        It "add string" {
            $func = {param($acc, $e) $e + $acc}
            $got  = Invoke-Foldr -Function $func -List @("e", "x", "e", "r", "c", "i", "s", "m") -Accumulator "!"
            $want = "exercism!"

            $got | Should -BeExactly $want
        }
    }

    Context "reverse method" {
        It "empty list" {
            $got  = Invoke-Reverse -List @()
            $want = @()

            $got | Should -BeExactly $want
        }
    
        It "non-empty list" {
            $got  = Invoke-Reverse -List @(2, 4, 6, 8, 10)
            $want = @(10, 8, 6, 4, 2)

            $got | Should -BeExactly $want
        }
    
        It "list of lists is not flattened" {
            $got  = Invoke-Reverse -List @( @(1, 2), @(3), @(), @(4, 5, 6))
            $want = @(@(4, 5, 6), @(),  @(3), @(1, 2))

            $got | Should -BeExactly $want
        }

        It "reverse mixed types" {
            $got  = Invoke-Reverse -List @("abc", 3.14, '@', 42)
            $want = @(42, '@', 3.14, "abc")

            $got | Should -BeExactly $want
        }
    }
    
}
