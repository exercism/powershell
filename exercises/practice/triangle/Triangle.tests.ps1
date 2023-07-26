BeforeAll {
    . "./Triangle.ps1"
}

Describe "Test Get-Triangle" {
    Context "Passing Tests" {
        It "equilateral all sides are equal" {
            $got = Get-Triangle -Sides @(2, 2, 2)
            $want = [Triangle]::EQUILATERAL

            $got | Should -BeExactly $want
        }

        It "equilateral all sides are equal and float" {
            $got = Get-Triangle -Sides @(0.5, 0.5, 0.5)
            $want = [Triangle]::EQUILATERAL

            $got | Should -BeExactly $want
        }

        It "isosceles first and last sides are equal" {
            $got = Get-Triangle -Sides @(3, 4, 3)
            $want = [Triangle]::ISOSCELES

            $got | Should -BeExactly $want
        }

        It "isosceles first two sides are equal" {
            $got = Get-Triangle -Sides @(4, 4, 3)
            $want = [Triangle]::ISOSCELES

            $got | Should -BeExactly $want
        }

        It "isosceles last two sides are equal" {
            $got = Get-Triangle -Sides @(3, 4, 4)
            $want = [Triangle]::ISOSCELES

            $got | Should -BeExactly $want
        }

        It "isosceles two sides are equal and float" {
            $got = Get-Triangle -Sides @(0.5, 0.5, 0.4)
            $want = [Triangle]::ISOSCELES

            $got | Should -BeExactly $want
        }

        It "isosceles two big equal sides" {
            $got = Get-Triangle -Sides @(10, 10, 2)
            $want = [Triangle]::ISOSCELES

            $got | Should -BeExactly $want
        }

        It "scalene no sides are equal descending order" {
            $got = Get-Triangle -Sides @(5, 4, 3)
            $want = [Triangle]::SCALENE

            $got | Should -BeExactly $want
        }

        It "scalene no sides are equal ascending order" {
            $got = Get-Triangle -Sides @(4, 7, 11)
            $want = [Triangle]::SCALENE

            $got | Should -BeExactly $want
        }

        It "scalene sides are float" {
            $got = Get-Triangle -Sides @(0.4, 0.3, 0.6)
            $want = [Triangle]::SCALENE

            $got | Should -BeExactly $want
        }
    }

    Context "Invalid Inputs" {
        It "all zero sides is not a triangle" {
            { Get-Triangle -Sides @(0, 0, 0)} | Should -Throw "All side lengths must be positive."
        }

        It "negative sides are illegal" {
            { Get-Triangle -Sides @(3, 4, -5)} | Should -Throw "All side lengths must be positive."
        }

        It "first isosceles triangle inequality violation" {
            { Get-Triangle -Sides @(1, 1, 3)} | Should -Throw "Side lengths violate triangle inequality."
        }

        It "second isosceles triangle inequality violation" {
            { Get-Triangle -Sides @(1, 3, 1)} | Should -Throw "Side lengths violate triangle inequality."
        }

        It "third isosceles triangle inequality violation" {
            { Get-Triangle -Sides @(3, 1, 1)} | Should -Throw "Side lengths violate triangle inequality."
        }

        It "SCALENE triangle inequality violation" {
            { Get-Triangle -Sides @(7, 3, 2)} | Should -Throw "Side lengths violate triangle inequality."
        }
    }
}