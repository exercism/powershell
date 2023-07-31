BeforeAll {
    . "./Proverb.ps1"
}

Describe "Test Get-Proverb" {
    It "zero pieces" {
        $got    = Get-Proverb -Data @()
        $want   = ""

        $got | Should -BeExactly $want
    }

    It "one piece" {
        $got    = Get-Proverb -Data @("nail")
        $want   = "And all for the want of a nail."

        $got | Should -BeExactly $want
    }

    It "two pieces" {
        $got    = Get-Proverb -Data @("nail", "shoe")
        $want   = ( "For want of a nail the shoe was lost.",
                    "And all for the want of a nail.") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "three pieces" {
        $got    = Get-Proverb -Data @("nail", "shoe", "horse")
        $want   = ( "For want of a nail the shoe was lost.",
                    "For want of a shoe the horse was lost.",
                    "And all for the want of a nail.") -join "`r`n"

        $got | Should -BeExactly $want  
    }

    It "full proverb" {
        $got    = Get-Proverb -Data @("nail", "shoe", "horse", "rider", "message", "battle", "kingdom")
        $want   = ( "For want of a nail the shoe was lost.",
                    "For want of a shoe the horse was lost.",
                    "For want of a horse the rider was lost.",
                    "For want of a rider the message was lost.",
                    "For want of a message the battle was lost.",
                    "For want of a battle the kingdom was lost.",
                    "And all for the want of a nail.") -join "`r`n"

        $got | Should -BeExactly $want
    }

    It "four pieces modernized" {
        $got    = Get-Proverb -Data @("pin", "gun", "soldier", "battle")
        $want   = ( "For want of a pin the gun was lost.",
                    "For want of a gun the soldier was lost.",
                    "For want of a soldier the battle was lost.",
                    "And all for the want of a pin.") -join "`r`n"

        $got | Should -BeExactly $want
    }
} 