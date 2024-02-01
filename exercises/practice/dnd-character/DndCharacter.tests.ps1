BeforeAll {
    . "./DndCharacter.ps1"
}

Describe "DnD Character test cases" {
    Context "ability modifier tests" {
        It "ability modifier for score 3 is -4" {
            $got = [Character]::GetModifier(3)
            $want = -4

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 4 is -3" {
            $got = [Character]::GetModifier(4)
            $want = -3

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 5 is -3" {
            $got = [Character]::GetModifier(5)
            $want = -3

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 6 is -2" {
            $got = [Character]::GetModifier(6)
            $want = -2

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 7 is -2" {
            $got = [Character]::GetModifier(7)
            $want = -2

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 8 is -1" {
            $got = [Character]::GetModifier(8)
            $want = -1

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 9 is -1" {
            $got = [Character]::GetModifier(9)
            $want = -1

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 10 is 0" {
            $got = [Character]::GetModifier(10)
            $want = 0

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 11 is 0" {
            $got = [Character]::GetModifier(11)
            $want = 0

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 12 is 1" {
            $got = [Character]::GetModifier(12)
            $want = 1

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 13 is 1" {
            $got = [Character]::GetModifier(13)
            $want = 1

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 14 is 2" {
            $got = [Character]::GetModifier(14)
            $want = 2

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 15 is 2" {
            $got = [Character]::GetModifier(15)
            $want = 2

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 16 is 3" {
            $got = [Character]::GetModifier(16)
            $want = 3

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 17 is 3" {
            $got = [Character]::GetModifier(17)
            $want = 3

            $got | Should -BeExactly $want
        }

        It "ability modifier for score 18 is 4" {
            $got = [Character]::GetModifier(18)
            $want = 4

            $got | Should -BeExactly $want
        }
    }


    Context "random character tests" {
        It "random ability is in range" {
            $character = [Character]::New()
            1..20 | ForEach-Object {
                $ability = $character.Ability()
                $got = $ability -ge 3 -and $ability -le 18
                $want = $true

                $got | Should -BeExactly $want
            }
        }

        It "random character is valid" {
            1..20 | ForEach-Object {
                $character = [Character]::New()
                $abilitiesValid = (@("Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom", "Charisma") | ForEach-Object {
                    $character.$_ -ge 3 -and $character.$_ -le 18}) -notcontains $false
                $healthValid = $character.HitPoints -eq (10 + [Character]::GetModifier($character.Constitution))

                $got = $abilitiesValid -and $healthValid
                $want = $true

                $got | Should -BeExactly $want
            }
        }

        It "each ability is calculated once" {
            $character = [Character]::New()

            $character.Strength     | Should -BeExactly $character.Strength
            $character.Dexterity    | Should -BeExactly $character.Dexterity
            $character.Constitution | Should -BeExactly $character.Constitution
            $character.Intelligence | Should -BeExactly $character.Intelligence
            $character.Wisdom       | Should -BeExactly $character.Wisdom
            $character.Charisma     | Should -BeExactly $character.Charisma
        }
    }
}
