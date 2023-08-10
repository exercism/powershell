BeforeAll {
    . "./Diamond.ps1"
}

Describe "Diamond test cases" {
    It "single 'A' row" {
        $got  = Invoke-Diamond -Letter 'A'
        $want = "A`n"

        $got | Should -BeExactly $want
    }

    It "no row containing 3 distinct groups of spaces" {
        $got  = Invoke-Diamond -Letter 'B'
        $want = (" A ", 
                 "B B",
                 " A ") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "no row containing 3 distinct groups of spaces case-insensitive" {
        $got  = Invoke-Diamond -Letter 'b'
        $want = (" A ", 
                 "B B",
                 " A ") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "odd diamond side length" {
        $got  = Invoke-Diamond -Letter 'C'
        $want = ("  A  ", 
                 " B B ",
                 "C   C",
                 " B B ",
                 "  A  ") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "even diamond side length" {
        $got  = Invoke-Diamond -Letter 'D'
        $want = ( "   A   ",
                  "  B B  ",
                  " C   C ",
                  "D     D",
                  " C   C ",
                  "  B B  ",
                  "   A   ") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "largest possible diamond" {
        $got = Invoke-Diamond -Letter 'Z'
        $want = ( "                         A                         ",
                  "                        B B                        ",
                  "                       C   C                       ",
                  "                      D     D                      ",
                  "                     E       E                     ",
                  "                    F         F                    ",
                  "                   G           G                   ",
                  "                  H             H                  ",
                  "                 I               I                 ",
                  "                J                 J                ",
                  "               K                   K               ",
                  "              L                     L              ",
                  "             M                       M             ",
                  "            N                         N            ",
                  "           O                           O           ",
                  "          P                             P          ",
                  "         Q                               Q         ",
                  "        R                                 R        ",
                  "       S                                   S       ",
                  "      T                                     T      ",
                  "     U                                       U     ",
                  "    V                                         V    ",
                  "   W                                           W   ",
                  "  X                                             X  ",
                  " Y                                               Y ",
                  "Z                                                 Z",
                  " Y                                               Y ",
                  "  X                                             X  ",
                  "   W                                           W   ",
                  "    V                                         V    ",
                  "     U                                       U     ",
                  "      T                                     T      ",
                  "       S                                   S       ",
                  "        R                                 R        ",
                  "         Q                               Q         ",
                  "          P                             P          ",
                  "           O                           O           ",
                  "            N                         N            ",
                  "             M                       M             ",
                  "              L                     L              ",
                  "               K                   K               ",
                  "                J                 J                ",
                  "                 I               I                 ",
                  "                  H             H                  ",
                  "                   G           G                   ",
                  "                    F         F                    ",
                  "                     E       E                     ",
                  "                      D     D                      ",
                  "                       C   C                       ",
                  "                        B B                        ",
                  "                         A                         ") -join "`r`n"

        $got | Should -BeExactly $want
    }
}