BeforeAll {
    . "./Minesweeper.ps1"
}

Describe "Minesweeper test cases" {
    It "no rows" {
        $got = Get-Annotate -Minefield @()
        
        $got | Should -BeNullOrEmpty
    }

    It "no columns" {
        $got  = Get-Annotate -Minefield @("")
        $want = @("")

        $got | Should -BeExactly $want
    }

    It "no mines" {
        $got  = Get-Annotate -Minefield @(
            "   ",
            "   ",
            "   "
        )
        $want = @(
            "   ",
            "   ",
            "   "
        )

        $got | Should -BeExactly $want
    }

    It "minefield with only mines" {
        $got  = Get-Annotate -Minefield @(
            "***",
            "***",
            "***"
        )
        $want = @(
            "***",
            "***",
            "***"
        )

        $got | Should -BeExactly $want
    }

    It "mine surrounded by spaces" {
        $got  = Get-Annotate -Minefield @(
            "   ",
            " * ",
            "   "
        )
        $want = @(
            "111",
            "1*1",
            "111"
        )

        $got | Should -BeExactly $want
    }

    It "space surrounded by mines" {
        $got  = Get-Annotate -Minefield @(
            "***",
            "* *",
            "***"
        )
        $want = @(
            "***",
            "*8*",
            "***"
        )

        $got | Should -BeExactly $want
    }

    It "horizontal line" {
        $got  = Get-Annotate -Minefield @(" * * ")
        $want = @("1*2*1")

        $got | Should -BeExactly $want
    }

    It "horizontal line, mines at edges" {
        $got  = Get-Annotate -Minefield @("*   *")
        $want = @("*1 1*")

        $got | Should -BeExactly $want
    }

    It "vertical line" {
        $got  = Get-Annotate -Minefield @(
            " ",
            "*",
            " ",
            "*",
            " "
        )
        $want = @(
            "1",
            "*",
            "2",
            "*",
            "1"
        )

        $got | Should -BeExactly $want
    }

    It "vertical line, mines at edges" {
        $got  = Get-Annotate -Minefield @(
            "*",
            " ",
            " ",
            " ",
            "*"
        )
        $want = @(
            "*",
            "1",
            " ",
            "1",
            "*"
        )

        $got | Should -BeExactly $want
    }

    It "cross" {
        $got  = Get-Annotate -Minefield @(
            "  *  ",
            "  *  ",
            "*****",
            "  *  ",
            "  *  "
        )
        $want = @(
            " 2*2 ",
            "25*52",
            "*****",
            "25*52",
            " 2*2 "
        )

        $got | Should -BeExactly $want
    }

    It "large minefield" {
        $got  = Get-Annotate -Minefield @(
            " *  * ",
            "  *   ",
            "    * ",
            "   * *",
            " *  * ",
            "      "
        )
        $want = @(
            "1*22*1",
            "12*322",
            " 123*2",
            "112*4*",
            "1*22*2",
            "111111"
        )

        $got | Should -BeExactly $want
    }

    It "annotate 9" {
        $got  = Get-Annotate -Minefield @(
            "     ", 
            "   * ", 
            "     ", 
            "     ", 
            " *   "
        )
        $want = @(
            "  111", 
            "  1*1", 
            "  111", 
            "111  ", 
            "1*1  "
        )

        $got | Should -BeExactly $want
    }

    It "Invalid character in minefield" {
        # Due to the dynamic output of Validating Parameter Input, this test accept any error throw by it instead of a specific message.
        # As long as you implement Validating Parameter Input correctly, this should pass.

        {Get-Annotate -Minefield @("X  * ")} | Should -Throw
    }
}
