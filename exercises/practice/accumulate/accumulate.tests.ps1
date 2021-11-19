BeforeAll {
    . "./accumulate.ps1"
}

Describe 'Test Get-Accumulation.ps1' {
    It "accumulate empty" {
        $got = @()
        $got += Get-Accumulation -List @() -Func { Param($numbers) $numbers | ForEach-Object { $_ * $_ }}
        $want = @()

        $got | Should -BeExactly $want
    }

    It "accumulate squares" {
        $got = @()
        $got += Get-Accumulation -List 1,2,3 -Func { Param($numbers) $numbers | ForEach-Object { $_ * $_ }}
        $want = @(1, 4, 9)

        $got | Should -BeExactly $want
    }

    It "add numbers" {
        $got = @()
        $got += Get-Accumulation -List 1,2,3 -Func { Param($numbers) $numbers | ForEach-Object { $_ + $_ }}
        $want = @(2, 4, 6)

        $got | Should -BeExactly $want
    }

    It "accumulate upcases" {
        $got = @()
        $got += Get-Accumulation -List "Hello", "World!" -Func { Param($List) $List | ForEach-Object { $_.ToUpper() }}

        $want = @("HELLO", "WORLD!")

        $got | Should -BeExactly $want
    }

    It "accumulate reverse strings" {
        $got = @()
        $got += Get-Accumulation -List "the", "quick", "brown", "fox", "etc" -Func { Param($List) $List | ForEach-Object { $arr = $_.ToCharArray(); [array]::Reverse($arr); -join($arr) }}

        $want = @("eht", "kciuq", "nworb", "xof", "cte")

        $got | Should -BeExactly $want
    }

    It "accumulate recursively" {
        $got = @()
        $got += Get-Accumulation -List "a", "b", "c" -Func { 
            Param($List) 
            $arr = @(1, 2, 3); 
            $newArr = @(@(), @(), @())

            for($i = 0; $i -lt $List.Length; $i++) {
                for($j = 0; $j -lt $List.Length; $j++) {
                    $newArr[$i] += "$($List[$i])$($arr[$j])"
                }
            }
            $newArr
        }

        $want = @(
            @("a1", "a2", "a3"),
            @("b1", "b2", "b3"),
            @("c1", "c2", "c3")
        )

        $got | Should -BeExactly $want
    }


}
