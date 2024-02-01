BeforeAll {
    . "./GoCounting.ps1"
}

Describe "GoCounting test cases" {
    Context "get territory 5 x 5 board" {
        BeforeEach {
            $strings = @(
                "  B  ",
                " B B ",
                "B W B",
                " W W ",
                "  W  "
            )
            $board = [Board]::new($strings)
        }

        It "Black corner territory on 5x5 board" {
            $coordinate = @(0, 1)
            $got = $board.Territory($coordinate)
            $want = [PSCustomObject]@{
                Owner = [Owner]::BLACK
                Coordinates = @(@(0, 0), @(0, 1), @(1, 0))
            }

            $got.Owner | Should -BeExactly $want.Owner
            $got.Coordinates | Should -Be $want.Coordinates
        }
    
        It "White center territory on 5x5 board" {
            $coordinate = @(2, 3)
            $got = $board.Territory($coordinate)
            $want = [PSCustomObject]@{
                Owner = [Owner]::WHITE
                Coordinates = @(,@(2, 3))
            }

            $got.Owner | Should -BeExactly $want.Owner
            $got.Coordinates | Should -Be $want.Coordinates
        }
    
        It "Open corner territory on 5x5 board" {
            $coordinate = @(1, 4)
            $got = $board.Territory($coordinate)
            $want = [PSCustomObject]@{
                Owner = [Owner]::NONE
                Coordinates = @(@(0, 3), @(0, 4), @(1, 4))
            }

            $got.Owner | Should -BeExactly $want.Owner
            $got.Coordinates | Should -Be $want.Coordinates
        }
    
        It "A stone and not a territory on 5x5 board" {
            $coordinate = @(1, 1)
            $got = $board.Territory($coordinate)
            $want = [PSCustomObject]@{
                Owner = [Owner]::NONE
                Coordinates = @()
            }

            $got.Owner | Should -BeExactly $want.Owner
            $got.Coordinates | Should -Be $want.Coordinates
        }
    }

    Context "get territories of a whole board" {
        It "One territory is the whole board" {
            $strings = @(" ")
            $board = [Board]::new($strings)
            $got = $board.Territories()

            $got.BLACK | Should -BeNullOrEmpty
            $got.WHITE | Should -BeNullOrEmpty
            $got.NONE  | Should -BeExactly @(,@(0,0))
        }
    
        It "Two territory rectangular board" {
            $strings = @(
                " BW ",
                " BW "
            )
            $board = [Board]::new($strings)
            $got = $board.Territories()

            $got.BLACK | Should -BeExactly @(@(0,0), @(0,1))
            $got.WHITE | Should -BeExactly @(@(3,0), @(3,1))
            $got.NONE  | Should -BeNullOrEmpty
        }
    
        It "Two region rectangular board" {
            $strings = @(" B ")
            $board = [Board]::new($strings)
            $got = $board.Territories()

            $got.BLACK | Should -BeExactly @(@(0,0), @(2,0))
            $got.WHITE | Should -BeNullOrEmpty
            $got.NONE  | Should -BeNullOrEmpty
        }
    }

    Context "invalid input" {
        BeforeEach {
            $strings = @(
                "  B  ",
                " B B ",
                "B W B",
                " W W ",
                "  W  "
            )
            $board = [Board]::new($strings)
        }

        It "Invalid because X is too low for 5x5 board" {
            $coordinate = @(-1, 1)
            { $board.Territory($coordinate) } | Should -Throw "*Invalid coordinate*"
        }
    
        It "Invalid because X is too high for 5x5 board" {
            $coordinate = @(5, 1)
            { $board.Territory($coordinate) } | Should -Throw "*Invalid coordinate*"
        }
    
        It "Invalid because Y is too low for 5x5 board" {
            $coordinate = @(1, -1)
            { $board.Territory($coordinate) } | Should -Throw "*Invalid coordinate*"
        }
    
        It "Invalid because Y is too high for 5x5 board" {
            $coordinate = @(1, 5)
            { $board.Territory($coordinate) } | Should -Throw "*Invalid coordinate*"
        }
    }
}
