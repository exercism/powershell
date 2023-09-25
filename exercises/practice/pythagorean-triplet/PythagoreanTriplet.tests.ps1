BeforeAll {
    . "./PythagoreanTriplet.ps1"
}

Describe "PythagoreanTriplet test cases" {
    It "triplets whose sum is 12" {
        $got  = Get-PythagoreanTriplet -Sum 12
        $want = @( ,@(3, 4, 5))

        ,$got | Should -BeExactly $want
    }

    It "triplets whose sum is 108" {
        $got  = Get-PythagoreanTriplet -Sum 108
        $want = @( ,@(27, 36, 45))

        ,$got | Should -BeExactly $want
    }

    It "triplets whose sum is 1000" {
        $got  = Get-PythagoreanTriplet -Sum 1000
        $want = @( ,@(200, 375, 425))

        ,$got | Should -BeExactly $want
    }

    It "no matching triplets for 1001" {
        $got  = Get-PythagoreanTriplet -Sum 1001

        $got | Should -BeNullOrEmpty
    }

    It "returns all matching triplets" {
        $got  = Get-PythagoreanTriplet -Sum 90
        $want = @( @(9, 40, 41), @(15, 36, 39))

        $got | Should -BeExactly $want
    }

    It "several matching triplets" {
        $got  = Get-PythagoreanTriplet -Sum 840
        $want = @(
            @(40, 399, 401),
            @(56, 390, 394),
            @(105, 360, 375),
            @(120, 350, 370),
            @(140, 336, 364),
            @(168, 315, 357),
            @(210, 280, 350),
            @(240, 252, 348)
        )

        $got | Should -BeExactly $want
    }

    It "triplets for large number" {
        $got  = Get-PythagoreanTriplet -Sum 30000
        $want = @(
            @(1200, 14375, 14425),
            @(1875, 14000, 14125),
            @(5000, 12000, 13000),
            @(6000, 11250, 12750),
            @(7500, 10000, 12500)
        )

        $got | Should -BeExactly $want
    }
}
