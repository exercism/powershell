BeforeAll {
    . "./Knapsack.ps1"
}

Describe "Knapsack test cases" {
    It "no items" {
        $items = @()
        $got  = Get-MaximumValue -MaxWeight 100 -Items $items
        $want = 0

        $got | Should -BeExactly $want
    }

    It "one item, too heavy" {
        $items = @(
            [PSCustomObject]@{Weight = 100; Value = 1}
        )
        $got  = Get-MaximumValue -MaxWeight 10 -Items $items
        $want = 0

        $got | Should -BeExactly $want
    }

    It "five items (cannot be greedy by weight)" {
        $items = @(
            [PSCustomObject]@{Weight = 2; Value = 5}
            [PSCustomObject]@{Weight = 2; Value = 5}
            [PSCustomObject]@{Weight = 2; Value = 5}
            [PSCustomObject]@{Weight = 2; Value = 5}
            [PSCustomObject]@{Weight = 10; Value = 21}
        )
        $got  = Get-MaximumValue -MaxWeight 10 -Items $items
        $want = 21

        $got | Should -BeExactly $want
    }

    It "five items (cannot be greedy by value)" {
        $items = @(
            [PSCustomObject]@{Weight = 2; Value = 20}
            [PSCustomObject]@{Weight = 2; Value = 20}
            [PSCustomObject]@{Weight = 2; Value = 20}
            [PSCustomObject]@{Weight = 2; Value = 20}
            [PSCustomObject]@{Weight = 10; Value = 50}
        )
        $got  = Get-MaximumValue -MaxWeight 10 -Items $items
        $want = 80

        $got | Should -BeExactly $want
    }

    It "example knapsack" {
        $items = @(
            [PSCustomObject]@{Weight = 5; Value = 10}
            [PSCustomObject]@{Weight = 4; Value = 40}
            [PSCustomObject]@{Weight = 6; Value = 30}
            [PSCustomObject]@{Weight = 4; Value = 50}
        )
        $got  = Get-MaximumValue -MaxWeight 10 -Items $items
        $want = 90

        $got | Should -BeExactly $want
    }

    It "8 items" {
        $items = @(
            [PSCustomObject]@{Weight = 25; Value = 350}
            [PSCustomObject]@{Weight = 35; Value = 400}
            [PSCustomObject]@{Weight = 45; Value = 450}
            [PSCustomObject]@{Weight = 5; Value = 20}
            [PSCustomObject]@{Weight = 25; Value = 70}
            [PSCustomObject]@{Weight = 3; Value = 8}
            [PSCustomObject]@{Weight = 2; Value = 5}
            [PSCustomObject]@{Weight = 2; Value = 5}
        )
        $got  = Get-MaximumValue -MaxWeight 104 -Items $items
        $want = 900

        $got | Should -BeExactly $want
    }

    It "15 items" {
        $items = @(
            [PSCustomObject]@{Weight = 70; Value = 135}
            [PSCustomObject]@{Weight = 73; Value = 139}
            [PSCustomObject]@{Weight = 77; Value = 149}
            [PSCustomObject]@{Weight = 80; Value = 150}
            [PSCustomObject]@{Weight = 82; Value = 156}
            [PSCustomObject]@{Weight = 87; Value = 163}
            [PSCustomObject]@{Weight = 90; Value = 173}
            [PSCustomObject]@{Weight = 94; Value = 184}
            [PSCustomObject]@{Weight = 98; Value = 192}
            [PSCustomObject]@{Weight = 106; Value = 201}
            [PSCustomObject]@{Weight = 110; Value = 210}
            [PSCustomObject]@{Weight = 113; Value = 214}
            [PSCustomObject]@{Weight = 115; Value = 221}
            [PSCustomObject]@{Weight = 118; Value = 229}
            [PSCustomObject]@{Weight = 120; Value = 240}
        )
        $got  = Get-MaximumValue -MaxWeight 750 -Items $items
        $want = 1458

        $got | Should -BeExactly $want
    }

}
