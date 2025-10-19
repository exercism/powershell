BeforeAll {
    . "./PiecingItTogether.ps1"
}

Describe "PiecingItTogether test cases" {
    BeforeEach {
        $puzzle = [JigsawPuzzle]::new()
    }
    It "1000 pieces puzzle with 1.6 aspect ratio" {
        $partialData = [PSCustomObject]@{
            Pieces = 1000
            AspectRatio = 1.6
        }
        $puzzle.GetData($partialData)

        $puzzle.Pieces      | Should -Be 1000
        $puzzle.Border      | Should -Be 126
        $puzzle.Inside      | Should -Be 874
        $puzzle.Rows        | Should -Be 25
        $puzzle.Columns     | Should -Be 40
        $puzzle.AspectRatio | Should -Be 1.6
        $puzzle.Format      | Should -Be ([Format]::Landscape)
    }

    It "square puzzle with 32 rows" {
        $partialData = [PSCustomObject]@{
            Rows = 32
            Format = [Format]::Square
        }
        $puzzle.GetData($partialData)

        $puzzle.Pieces      | Should -Be 1024
        $puzzle.Border      | Should -Be 124
        $puzzle.Inside      | Should -Be 900
        $puzzle.Rows        | Should -Be 32
        $puzzle.Columns     | Should -Be 32
        $puzzle.AspectRatio | Should -Be 1.0
        $puzzle.Format      | Should -Be ([Format]::Square)
    }

    It "400 pieces square puzzle with only inside pieces and aspect ratio" {
        $partialData = [PSCustomObject]@{
            Inside = 324
            AspectRatio = 1.0
        }
        $puzzle.GetData($partialData)

        $puzzle.Pieces      | Should -Be 400
        $puzzle.Border      | Should -Be 76
        $puzzle.Inside      | Should -Be 324
        $puzzle.Rows        | Should -Be 20
        $puzzle.Columns     | Should -Be 20
        $puzzle.AspectRatio | Should -Be 1.0
        $puzzle.Format      | Should -Be ([Format]::Square)
    }

    It "1500 pieces landscape puzzle with 30 rows and 1.6 aspect ratio" {
        $partialData = [PSCustomObject]@{
            Rows = 30
            AspectRatio = 1.6666666666666667
        }
        $puzzle.GetData($partialData)

        $puzzle.Pieces      | Should -Be 1500
        $puzzle.Border      | Should -Be 156
        $puzzle.Inside      | Should -Be 1344
        $puzzle.Rows        | Should -Be 30
        $puzzle.Columns     | Should -Be 50
        $puzzle.AspectRatio | Should -Be 1.6666666666666667
        $puzzle.Format      | Should -Be ([Format]::Landscape)
    }

    It "300 pieces portrait puzzle with 70 border pieces" {
        $partialData = [PSCustomObject]@{
            Pieces = 300
            Border = 70
            Format = [Format]::Portrait
        }
        $puzzle.GetData($partialData)

        $puzzle.Pieces      | Should -Be 300
        $puzzle.Border      | Should -Be 70
        $puzzle.Inside      | Should -Be 230
        $puzzle.Rows        | Should -Be 25
        $puzzle.Columns     | Should -Be 12
        $puzzle.AspectRatio | Should -Be 0.48
        $puzzle.Format      | Should -Be ([Format]::Portrait)
    }

    It "puzzle with insufficient data" {
        $partialData = [PSCustomObject]@{
            Pieces = 1500
            Format = [Format]::Landscape
        }
        { $puzzle.GetData($partialData) } | Should -Throw "*insufficient data*"
    }

    It "puzzle with contradictory data" {
        $partialData = [PSCustomObject]@{
            Rows = 100
            Columns = 1000
            Format = [Format]::Square
        }
        { $puzzle.GetData($partialData) } | Should -Throw "*contradictory data*"
    }

}
