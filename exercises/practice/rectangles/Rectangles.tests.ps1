BeforeAll {
    . "./Rectangles.ps1"
}

Describe "Rectangles test cases" {
    It "no rows" {
        $strings = @()
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 0

    }

    It "no columns" {
        $strings = 
        @(
            ""
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 0
    }

    It "no rectangles" {
        $strings = 
        @(
            " "
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 0
    }

    It "one rectangle" {
        $strings = 
        @(
            "+-+",
            "| |",
            "+-+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 1
    }

    It "two rectangles without shared parts" {
        $strings = 
        @(
            "  +-+",
            "  | |",
            "+-+-+",
            "| |  ",
            "+-+  "
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 2
    }

    It "five rectangles with shared parts" {
        $strings = 
        @(
            "  +-+",
            "  | |",
            "+-+-+",
            "| | |",
            "+-+-+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 5
    }

    It "rectangle of height 1 is counted" {
        $strings = 
        @(
            "+--+",
            "+--+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 1
    }

    It "rectangle of width 1 is counted" {
        $strings =
        @(
            "++",
            "||",
            "++"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 1
    }

    It "1x1 square is counted" {
        $strings = 
        @(
            "++",
            "++"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 1
    }

    It "only complete rectangles are counted" {
        $strings = 
        @(
            "  +-+",
            "    |",
            "+-+-+",
            "| | -",
            "+-+-+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 1
    }

    It "rectangles can be of different sizes" {
        $strings = 
        @(
            "+------+----+",
            "|      |    |",
            "+---+--+    |",
            "|   |       |",
            "+---+-------+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 3
    }

    It "corner is required for a rectangle to be complete" {
        $strings = 
        @(
            "+------+----+",
            "|      |    |",
            "+------+    |",
            "|   |       |",
            "+---+-------+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 2
    }

    It "large input with many rectangles" {
        $strings = 
        @(
            "+---+--+----+",
            "|   +--+----+",
            "+---+--+    |",
            "|   +--+----+",
            "+---+--+--+-+",
            "+---+--+--+-+",
            "+------+  | |",
            "          +-+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 60
    }

    It "rectangles must have four sides" {
        $strings = 
        @(
            "+-+ +-+",
            "| | | |",
            "+-+-+-+",
            "  | |  ",
            "+-+-+-+",
            "| | | |",
            "+-+ +-+"
        )
        $got  = Get-Rectangles -Strings $strings
        $got | Should -BeExactly 5
    }

}
