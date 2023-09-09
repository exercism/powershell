BeforeAll {
    . "./House.ps1"
}
Describe "House test cases" {
    It "verse one - the house that jack built" {
        $got  = Get-Rhyme -Start 1 -End 1
        $want = "This is the house that Jack built."

        $got | Should -BeExactly $want
    }

    It "verse two - the malt that lay" {
        $got  = Get-Rhyme -Start 2 -End 2
        $want = "This is the malt that lay in the house that Jack built."

        $got | Should -BeExactly $want
    }

    It "verse three - the rat that ate" {
        $got  = Get-Rhyme -Start 3 -End 3
        $want = "This is the rat that ate the malt that lay in the house that Jack built."

        $got | Should -BeExactly $want
    }

    It "verse four - the cat that killed" {
        $got  = Get-Rhyme -Start 4 -End 4
        $want = "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse five - the dog that worried" {
        $got  = Get-Rhyme -Start 5 -End 5
        $want = "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse six - the cow with the crumpled horn" {
        $got  = Get-Rhyme -Start 6 -End 6
        $want = "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse seven - the maiden all forlorn" {
        $got  = Get-Rhyme -Start 7 -End 7
        $want = "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse eight - the man all tattered and torn" {
        $got  = Get-Rhyme -Start 8 -End 8
        $want = "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse nine - the priest all shaven and shorn" {
        $got  = Get-Rhyme -Start 9 -End 9
        $want = "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse 10 - the rooster that crowed in the morn" {
        $got  = Get-Rhyme -Start 10 -End 10
        $want = "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse 11 - the farmer sowing his corn" {
        $got  = Get-Rhyme -Start 11 -End 11
        $want = "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "verse 12 - the horse and the hound and the horn" {
        $got  = Get-Rhyme -Start 12 -End 12
        $want = "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
        
        $got | Should -BeExactly $want
    }

    It "multiple verses" {
        $got  = Get-Rhyme -Start 4 -End 8
        $want = (
            "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                ) -join "`n"
        
        $got | Should -BeExactly $want
    }

    It "full rhyme" {
        $got  = Get-Rhyme -Start 1 -End 12
        $want = (
            "This is the house that Jack built.",
            "This is the malt that lay in the house that Jack built.",
            "This is the rat that ate the malt that lay in the house that Jack built.",
            "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
            "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                ) -join "`n"

        $got | Should -BeExactly $want
    }
}
