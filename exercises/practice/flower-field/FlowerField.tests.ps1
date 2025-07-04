BeforeAll {
    . "./FlowerField.ps1"
}

Describe "Flower Field test cases" {
    It "no rows" {
        $got = Get-Annotate -Garden @()
        
        $got | Should -BeNullOrEmpty
    }

    It "no columns" {
        $got  = Get-Annotate -Garden @("")
        $want = @("")

        $got | Should -BeExactly $want
    }

    It "no flowers" {
        $got  = Get-Annotate -Garden @(
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

    It "garden full of flowers" {
        $got  = Get-Annotate -Garden @(
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

    It "flower surrounded by spaces" {
        $got  = Get-Annotate -Garden @(
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

    It "space surrounded by flowers" {
        $got  = Get-Annotate -Garden @(
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
        $got  = Get-Annotate -Garden @(" * * ")
        $want = @("1*2*1")

        $got | Should -BeExactly $want
    }

    It "horizontal line, flowers at edges" {
        $got  = Get-Annotate -Garden @("*   *")
        $want = @("*1 1*")

        $got | Should -BeExactly $want
    }

    It "vertical line" {
        $got  = Get-Annotate -Garden @(
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

    It "vertical line, flowers at edges" {
        $got  = Get-Annotate -Garden @(
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
        $got  = Get-Annotate -Garden @(
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

    It "large garden" {
        $got  = Get-Annotate -Garden @(
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
        $got  = Get-Annotate -Garden @(
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

    It "Invalid character in garden" {
        # Due to the dynamic output of Validating Parameter Input, this test accept any error throw by it instead of a specific message.
        # As long as you implement Validating Parameter Input correctly, this should pass.

        {Get-Annotate -Garden @("X  * ")} | Should -Throw
    }
}
