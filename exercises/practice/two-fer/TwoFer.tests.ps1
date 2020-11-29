# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.tests\.', '.'
# . "$here\$sut"

BeforeAll {
    . ".\TwoFer.ps1"
}

Describe "Get-TwoFer Tests" {

    It "Given <Name> expects <Expected>" -TestCases @(
        @{ Name = $null; Expected = "One for you, one for me" },
        @{ Name = ""; Expected = "One for you, one for me" },
        @{ Name = "Alice"; Expected = "One for Alice, one for me" }
    ) {
        Param(
            $Name, $Expected
        )

        Get-TwoFer -Name $Name | Should -Be $Expected
    }
}