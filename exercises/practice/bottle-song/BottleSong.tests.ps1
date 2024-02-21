BeforeAll {
    . "./BottleSong.ps1"
}

Describe "BottleSong test cases" {
    Context "recite" {
        It "verse -> single verse -> first generic verse" {
            $got  = Get-Lyric -Start 10
            $want = (
                "Ten green bottles hanging on the wall,",
                "Ten green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be nine green bottles hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "verse -> single verse -> last generic verse" {
            $got  = Get-Lyric -Start 3
            $want = (
                "Three green bottles hanging on the wall,",
                "Three green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be two green bottles hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "verse -> single verse -> verse with 2 bottles" {
            $got  = Get-Lyric -Start 2
            $want = (
                "Two green bottles hanging on the wall,",
                "Two green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be one green bottle hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "verse -> single verse -> verse with 1 bottle" {
            $got  = Get-Lyric -Start 1
            $want = (
                "One green bottle hanging on the wall,",
                "One green bottle hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be no green bottles hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "lyrics -> multiple verses -> first two verses" {
            $got  = Get-Lyric -Start 10 -Take 2
            $want = (
                "Ten green bottles hanging on the wall,",
                "Ten green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be nine green bottles hanging on the wall.",
                "",
                "Nine green bottles hanging on the wall,",
                "Nine green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be eight green bottles hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "lyrics -> multiple verses -> last three verses" {
            $got  = Get-Lyric -Start 3 -Take 3
            $want = (
                "Three green bottles hanging on the wall,",
                "Three green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be two green bottles hanging on the wall.",
                "",
                "Two green bottles hanging on the wall,",
                "Two green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be one green bottle hanging on the wall.",
                "",
                "One green bottle hanging on the wall,",
                "One green bottle hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be no green bottles hanging on the wall."
            ) -join "`n"

            $got | Should -BeExactly $want
        }

        It "lyrics -> multiple verses -> all verses" {
            $got  = Get-Lyric -Start 10 -Take 10
            $want = (
                "Ten green bottles hanging on the wall,",
                "Ten green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be nine green bottles hanging on the wall.",
                "",
                "Nine green bottles hanging on the wall,",
                "Nine green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be eight green bottles hanging on the wall.",
                "",
                "Eight green bottles hanging on the wall,",
                "Eight green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be seven green bottles hanging on the wall.",
                "",
                "Seven green bottles hanging on the wall,",
                "Seven green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be six green bottles hanging on the wall.",
                "",
                "Six green bottles hanging on the wall,",
                "Six green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be five green bottles hanging on the wall.",
                "",
                "Five green bottles hanging on the wall,",
                "Five green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be four green bottles hanging on the wall.",
                "",
                "Four green bottles hanging on the wall,",
                "Four green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be three green bottles hanging on the wall.",
                "",
                "Three green bottles hanging on the wall,",
                "Three green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be two green bottles hanging on the wall.",
                "",
                "Two green bottles hanging on the wall,",
                "Two green bottles hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be one green bottle hanging on the wall.",
                "",
                "One green bottle hanging on the wall,",
                "One green bottle hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be no green bottles hanging on the wall."
            ) -join "`n"
            
            $got | Should -BeExactly $want
        }
    }

    Context "Error: Invalid parameter inputs" {
        It "start with too many bottles" {
            $bottles = 50
            $errMsg = "*Cannot validate argument on parameter 'Start'. The $bottles argument is greater than the maximum allowed range of 10. Supply an argument that is less than or equal to 10 and then try the command again.*"
            { Get-Lyric -Start $bottles } | Should -Throw $errMsg
        }

        It "start with less than one bottle" {
            $bottles = 0
            $errMsg = "*Cannot validate argument on parameter 'Start'. The $bottles argument is less than the minimum allowed range of 1. Supply an argument that is greater than or equal to 1 and then try the command again.*"
            { Get-Lyric -Start $bottles } | Should -Throw $errMsg
        }

        It "taking less than one bottle" {
            $bottles = -1
            $errMsg = "*Cannot validate argument on parameter 'Take'. The $bottles argument is less than the minimum allowed range of 1. Supply an argument that is greater than or equal to 1 and then try the command again.*"
            { Get-Lyric -Start 3 -Take $bottles } | Should -Throw $errMsg
        }

        It "taking more bottle than available" {
            { Get-Lyric -Start 3 -Take 5 } | Should -Throw "*You can't take more bottle than what you started with.*"
        }
    }
}


