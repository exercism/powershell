BeforeAll {
    . "./PalindromeProducts.ps1"
}

Describe "PalindromeProducts test cases" {
    Context "find the smallest palindrome" {
        It "from single digit factors" {
            $got  = Get-Products -Min 1 -Max 9
            $want = @{ Value = 1; Products = @(,@(1, 1))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }

        It "from double digit factors" {
            $got  = Get-Products -Min 10 -Max 99
            $want = @{ Value = 121; Products = @(,@(11, 11))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }

        It "from triple digit factors" {
            $got  = Get-Products -Min 100 -Max 999
            $want = @{ Value = 10201; Products = @(,@(101, 101))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }

        It "from four digit factors" {
            $got  = Get-Products -Min 1000 -Max 9999
            $want = @{ Value = 1002001; Products = @(,@(1001, 1001))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }

        It "empty result for smallest if no palindrome in the range" {
            $got  = Get-Products -Min 1002 -Max 1003

            $got.Value    | Should -BeNullOrEmpty
            $got.Products | Should -BeNullOrEmpty
        }

        It "smallest product does not use the smallest factor" {
            $got  = Get-Products -Min 3215 -Max 4000
            $want = @{ Value = 10988901; Products = @(,@(3297, 3333))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }
    }
    
    Context "find thea largest palindrome" {
        It "from single digit factors" {
            $got  = Get-Products -Min 1 -Max 9 -Largest
            $want = @{ Value = 9; Products = @(@(1, 9), @(3, 3))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }
    
        It "from double digit factors" {
            $got  = Get-Products -Min 10 -Max 99 -Largest
            $want = @{ Value = 9009; Products = @(,@(91, 99))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }
    
        It "from triple digit factors" {
            $got  = Get-Products -Min 100 -Max 999 -Largest
            $want = @{ Value = 906609; Products = @(,@(913, 993))}

            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }
    
        It "from four digit factors" {
            $got  = Get-Products -Min 1000 -Max 9999 -Largest
            $want = @{ Value = 99000099; Products = @(,@(9901, 9999))}
            $got.Value    | Should -BeExactly $want.Value
            $got.Products | Should -BeExactly $want.Products
        }

        It "empty result for largest if no palindrome in the range" {
            $got  = Get-Products -Min 15 -Max 15 -Largest

            $got.Value    | Should -BeNullOrEmpty
            $got.Products | Should -BeNullOrEmpty
        }
    }

    Context "invalid inputs" {
        It "error result for smallest if min is more than max" {
            {Get-Products -Min 10 -Max 9} | Should -Throw "*Cannot validate argument on parameter 'Max'*"
        }
    
        It "error result for largest if min is more than max" {
            {Get-Products -Min 10 -Max 9 -Largest} | Should -Throw "*Cannot validate argument on parameter 'Max'*"
        }
    }
}
