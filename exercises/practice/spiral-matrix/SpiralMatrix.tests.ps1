BeforeAll {
    . "./SpiralMatrix.ps1"
}

Describe "SpiralMatrix test cases" {
    It "empty spiral" {
        $got  = Get-SpiralMatrix -Size 0
        $want = @()

        $got | Should -BeExactly $want
    }

    It "trivial spiral" {
        $got  = Get-SpiralMatrix -Size 1
        $want = @(
            ,@(1)
        )

        $got | Should -BeExactly $want
    }

    It "spiral of size 2" {
        $got  = Get-SpiralMatrix -Size 2
        $want = @(
            @(1,2),
            @(4,3)
        )

        $got | Should -BeExactly $want
    }

    It "spiral of size 3" {
        $got  = Get-SpiralMatrix -Size 3
        $want = @(
            @(1,2,3),
            @(8,9,4),
            @(7,6,5)
        )

        $got | Should -BeExactly $want
    }

    It "spiral of size 4" {
        $got  = Get-SpiralMatrix -Size 4
        $want = @(
            @( 1, 2, 3,4),
            @(12,13,14,5),
            @(11,16,15,6),
            @(10, 9, 8,7)
        )

        $got | Should -BeExactly $want
    }

    It "spiral of size 5" {
        $got  = Get-SpiralMatrix -Size 5
        $want = @(
            @( 1, 2, 3, 4,5),
            @(16,17,18,19,6),
            @(15,24,25,20,7),
            @(14,23,22,21,8),
            @(13,12,11,10,9)
        )

        $got | Should -BeExactly $want
    }

}
