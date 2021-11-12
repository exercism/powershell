BeforeAll {
    . "./accumulate.ps1"
}

Describe 'Test Get-Accumulation.ps1' {
    It "square numbers" {
        $got = @()
        $got += Get-Accumulation -List 1,2,3,4,5 -Func { Param([Int64[]]$numbers) $numbers | ForEach-Object { $_ * $_ }}

        $want = @(1,4,9,16,25)

        $got | Should -BeExactly $want
    }

    It "add numbers" {
        $got = @()
        $got += Get-Accumulation -List 1,2,3,4,5 -Func { Param([Int64[]]$numbers) $numbers | ForEach-Object { $_ + $_ }}

        $want = @(2,4,6,8,10)

        $got | Should -BeExactly $want
    }
}
