BeforeAll {
    . "./ZebraPuzzle.ps1"
}

Describe "ZebraPuzzle test cases" {
    It "resident who drinks water" {
        $got  = Get-WaterDrinker
        $want = [Nationality]::Norwegian

        $got | Should -BeExactly $want
    }

    It "resident who owns zebra" {
        $got  = Get-ZebraOwner
        $want = [Nationality]::Japanese

        $got | Should -BeExactly $want
    }
}
