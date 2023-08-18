BeforeAll {
    . ".\Tournament.ps1"
}
Describe "Tournament test cases" {
    It "just the header if no input" {
        $result = @()

        $got    = Invoke-Tournament -Results $result
        $want   = "Team                           | MP |  W |  D |  L |  P"

        $got | Should -BeExactly $want
    }

    It "a win is three points, a loss is zero points" {
        $result = @("Allegoric Alaskans;Blithering Badgers;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3",
                    "Blithering Badgers             |  1 |  0 |  0 |  1 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "a win can also be expressed as a loss" {
        $result = @("Blithering Badgers;Allegoric Alaskans;loss")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3",
                    "Blithering Badgers             |  1 |  0 |  0 |  1 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "a different team can win" {
        $result = @("Blithering Badgers;Allegoric Alaskans;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Blithering Badgers             |  1 |  1 |  0 |  0 |  3",
                    "Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "a draw is one point each" {
        $result = @("Allegoric Alaskans;Blithering Badgers;draw")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1",
                    "Blithering Badgers             |  1 |  0 |  1 |  0 |  1") -join "`n"

        $got | Should -BeExactly $want
    }

    It "There can be more than one match" {
        $result = @("Allegoric Alaskans;Blithering Badgers;win",
                    "Allegoric Alaskans;Blithering Badgers;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6",
                    "Blithering Badgers             |  2 |  0 |  0 |  2 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "There can be more than one winner" {
        $result = @("Allegoric Alaskans;Blithering Badgers;loss",
                    "Allegoric Alaskans;Blithering Badgers;win")
                    
        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3",
                    "Blithering Badgers             |  2 |  1 |  0 |  1 |  3") -join "`n"

        $got | Should -BeExactly $want
    }

    It "There can be more than two teams" {
        $result = @("Allegoric Alaskans;Blithering Badgers;win",
                    "Blithering Badgers;Courageous Californians;win",
                    "Courageous Californians;Allegoric Alaskans;loss")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6",
                    "Blithering Badgers             |  2 |  1 |  0 |  1 |  3",
                    "Courageous Californians        |  2 |  0 |  0 |  2 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "typical input" {
        $result = @("Allegoric Alaskans;Blithering Badgers;win",
                    "Devastating Donkeys;Courageous Californians;draw",
                    "Devastating Donkeys;Allegoric Alaskans;win",
                    "Courageous Californians;Blithering Badgers;loss",
                    "Blithering Badgers;Devastating Donkeys;loss",
                    "Allegoric Alaskans;Courageous Californians;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Devastating Donkeys            |  3 |  2 |  1 |  0 |  7",
                    "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6",
                    "Blithering Badgers             |  3 |  1 |  0 |  2 |  3",
                    "Courageous Californians        |  3 |  0 |  1 |  2 |  1") -join "`n"

        $got | Should -BeExactly $want
    }

    It "incomplete competition (not all pairs have played)" {
        $result = @("Allegoric Alaskans;Blithering Badgers;loss",
                    "Devastating Donkeys;Allegoric Alaskans;loss",
                    "Courageous Californians;Blithering Badgers;draw",
                    "Allegoric Alaskans;Courageous Californians;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6",
                    "Blithering Badgers             |  2 |  1 |  1 |  0 |  4",
                    "Courageous Californians        |  2 |  0 |  1 |  1 |  1",
                    "Devastating Donkeys            |  1 |  0 |  0 |  1 |  0") -join "`n"

        $got | Should -BeExactly $want
    }

    It "ties broken alphabetically" {
        $result = @("Courageous Californians;Devastating Donkeys;win",
                    "Allegoric Alaskans;Blithering Badgers;win",
                    "Devastating Donkeys;Allegoric Alaskans;loss",
                    "Courageous Californians;Blithering Badgers;win",
                    "Blithering Badgers;Devastating Donkeys;draw",
                    "Allegoric Alaskans;Courageous Californians;draw")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7",
                    "Courageous Californians        |  3 |  2 |  1 |  0 |  7",
                    "Blithering Badgers             |  3 |  0 |  1 |  2 |  1",
                    "Devastating Donkeys            |  3 |  0 |  1 |  2 |  1") -join "`n"

        $got | Should -BeExactly $want
    }

    It "ensure points sorted numerically" {
        $result = @("Devastating Donkeys;Blithering Badgers;win",
                    "Devastating Donkeys;Blithering Badgers;win",
                    "Devastating Donkeys;Blithering Badgers;win",
                    "Devastating Donkeys;Blithering Badgers;win",
                    "Blithering Badgers;Devastating Donkeys;win")

        $got    = Invoke-Tournament -Results $result
        $want   = ( "Team                           | MP |  W |  D |  L |  P",
                    "Devastating Donkeys            |  5 |  4 |  0 |  1 | 12",
                    "Blithering Badgers             |  5 |  1 |  0 |  4 |  3") -join "`n"

        $got | Should -BeExactly $want
    }
}
