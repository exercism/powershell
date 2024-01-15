BeforeAll {
    . "./Poker.ps1"
}

Describe "Poker test cases" {
    It "single hand always wins" {
        $got  = Get-BestHand -Hands @("4S 5S 7H 8D JC")
        $want = @("4S 5S 7H 8D JC")

        $got | Should -BeExactly $want
    }

    It "highest card out of all hands wins" {
        $got  = Get-BestHand -Hands @(
            "4D 5S 6S 8D 3C",
            "2S 4C 7S 9H 10H",
            "3S 4S 5D 6H JH")
        $want = @("3S 4S 5D 6H JH")

        $got | Should -BeExactly $want
    }

    It "a tie has multiple winners" {
        $got  = Get-BestHand -Hands @(
            "4D 5S 6S 8D 3C",
            "2S 4C 7S 9H 10H",
            "3S 4S 5D 6H JH",
            "3H 4H 5C 6C JD")
        $want = @("3S 4S 5D 6H JH", "3H 4H 5C 6C JD")

        $got | Should -BeExactly $want
    }

    It "multiple hands with the same high cards, tie compares next highest ranked, down to last card" {
        $got  = Get-BestHand -Hands @("3S 5H 6S 8D 7H", "2S 5D 6D 8C 7S")
        $want = @("3S 5H 6S 8D 7H")

        $got | Should -BeExactly $want
    }

    It "one pair beats high card" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 6C 8D KH",
            "2S 4H 6S 4D JH")
        $want = @("2S 4H 6S 4D JH")

        $got | Should -BeExactly $want
    }

    It "highest pair wins" {
        $got  = Get-BestHand -Hands @(
            "4S 2H 6S 2D JH",
            "2S 4H 6C 4D JD")
        $want = @("2S 4H 6C 4D JD")

        $got | Should -BeExactly $want
    }

    It "two pairs beats one pair" {
        $got  = Get-BestHand -Hands @(
            "2S 8H 6S 8D JH",
            "4S 5H 4C 8C 5C")
        $want = @("4S 5H 4C 8C 5C")

        $got | Should -BeExactly $want
    }

    It "both hands have two pairs, highest ranked pair wins" {
        $got  = Get-BestHand -Hands @(
            "2S 8H 2D 8D 3H",
            "4S 5H 4C 8S 5D")
        $want = @("2S 8H 2D 8D 3H")

        $got | Should -BeExactly $want
    }

    It "both hands have two pairs, with the same highest ranked pair, tie goes to low pair" {
        $got  = Get-BestHand -Hands @(
            "2S QS 2C QD JH",
            "JD QH JS 8D QC")
        $want = @("JD QH JS 8D QC")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have two identically ranked pairs, tie goes to remaining card (kicker)" {
        $got  = Get-BestHand -Hands @(
            "JD QH JS 8D QC",
            "JS QS JC 2D QD")
        $want = @("JD QH JS 8D QC")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have two pairs that add to the same value, win goes to highest pair" {
        $got  = Get-BestHand -Hands @(
            "6S 6H 3S 3H AS",
            "7H 7S 2H 2S AC")
        $want = @("7H 7S 2H 2S AC")
    
        $got | Should -BeExactly $want
    }
    
    It "two pairs first ranked by largest pair" {
        $got  = Get-BestHand -Hands @(
            "5C 2S 5S 4H 4C",
            "6S 2S 6H 7C 2C")
        $want = @("6S 2S 6H 7C 2C")
    
        $got | Should -BeExactly $want
    }
    
    It "three of a kind beats two pair" {
        $got  = Get-BestHand -Hands @(
            "2S 8H 2H 8D JH",
            "4S 5H 4C 8S 4H")
        $want = @("4S 5H 4C 8S 4H")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have three of a kind, tie goes to highest ranked triplet" {
        $got  = Get-BestHand -Hands @(
            "2S 2H 2C 8D JH",
            "4S AH AS 8C AD")
        $want = @("4S AH AS 8C AD")
    
        $got | Should -BeExactly $want
    }

    It "with multiple decks, two players can have the same three of a kind, ties go to highest remaining cards" {
        $got  = Get-BestHand -Hands @(
            "5S AH AS 7C AD",
            "4S AH AS 8C AD")
        $want = @("4S AH AS 8C AD")
    
        $got | Should -BeExactly $want
    }
    
    It "a straight beats three of a kind" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 4C 8D 4H",
            "3S 4D 2S 6D 5C")
        $want = @("3S 4D 2S 6D 5C")
    
        $got | Should -BeExactly $want
    }
    
    It "aces can end a straight (10 J Q K A)" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 4C 8D 4H",
            "10D JH QS KD AC")
        $want = @("10D JH QS KD AC")
    
        $got | Should -BeExactly $want
    }
    
    It "aces can start a straight (A 2 3 4 5)" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 4C 8D 4H",
            "4D AH 3S 2D 5C")
        $want = @("4D AH 3S 2D 5C")
    
        $got | Should -BeExactly $want
    }
    
    It "aces cannot be in the middle of a straight (Q K A 2 3)" {
        $got  = Get-BestHand -Hands @(
            "2C 3D 7H 5H 2S",
            "QS KH AC 2D 3S")
        $want = @("2C 3D 7H 5H 2S")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands with a straight, tie goes to the highest ranked card" {
        $got  = Get-BestHand -Hands @(
            "4S 6C 7S 8D 5H",
            "5S 7H 8S 9D 6H")
        $want = @("5S 7H 8S 9D 6H")
    
        $got | Should -BeExactly $want
    }

    It "even though an ace is usually high, a 5-high straight is the lowest-scoring straight" {
        $got  = Get-BestHand -Hands @(
            "2H 3C 4D 5D 6H",
            "4S AH 3S 2D 5H")
        $want = @("2H 3C 4D 5D 6H")
    
        $got | Should -BeExactly $want
    }
    
    It "flush beats a straight" {
        $got  = Get-BestHand -Hands @(
            "4C 6H 7D 8D 5H",
            "2S 4S 5S 6S 7S")
        $want = @("2S 4S 5S 6S 7S")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have a flush, tie goes to the high card, down to the last one if necessary" {
        $got  = Get-BestHand -Hands @(
            "2H 7H 8H 9H 6H",
            "3S 5S 6S 7S 8S")
        $want = @("2H 7H 8H 9H 6H")
    
        $got | Should -BeExactly $want
    }
    
    It "full house beats a flush" {
        $got  = Get-BestHand -Hands @(
            "3H 6H 7H 8H 5H",
            "4S 5H 4C 5D 4H")
        $want = @("4S 5H 4C 5D 4H")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have a full house, tie goes to the highest-ranked triplet" {
        $got  = Get-BestHand -Hands @(
            "4H 4S 4D 9S 9D",
            "5H 5S 5D 8S 8D")
        $want = @("5H 5S 5D 8S 8D")
    
        $got | Should -BeExactly $want
    }
    
    It "with multiple decks, both hands have a full house with the same triplet, tie goes to the pair" {
        $got  = Get-BestHand -Hands @(
            "5H 5S 5D 9S 9D",
            "5H 5S 5D 8S 8D")
        $want = @("5H 5S 5D 9S 9D")
    
        $got | Should -BeExactly $want
    }
    
    It "four of a kind beats a full house" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 4D 5D 4H",
            "3S 3H 2S 3D 3C")
        $want = @("3S 3H 2S 3D 3C")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have four of a kind, tie goes to the high quad" {
        $got  = Get-BestHand -Hands @(
            "2S 2H 2C 8D 2D",
            "4S 5H 5S 5D 5C")
        $want = @("4S 5H 5S 5D 5C")
    
        $got | Should -BeExactly $want
    }

    It "with multiple decks, both hands with identical four of a kind, tie determined by kicker" {
        $got  = Get-BestHand -Hands @(
            "3S 3H 2S 3D 3C",
            "3S 3H 4S 3D 3C")
        $want = @("3S 3H 4S 3D 3C")
    
        $got | Should -BeExactly $want
    }
    
    It "straight flush beats four of a kind" {
        $got  = Get-BestHand -Hands @(
            "4S 5H 5S 5D 5C",
            "7S 8S 9S 6S 10S")
        $want = @("7S 8S 9S 6S 10S")
    
        $got | Should -BeExactly $want
    }
    
    It "aces can end a straight flush (10 J Q K A)" {
        $got  = Get-BestHand -Hands @(
            "KC AH AS AD AC",
            "10C JC QC KC AC")
        $want = @("10C JC QC KC AC")
    
        $got | Should -BeExactly $want
    }
    
    It "aces can start a straight flush (A 2 3 4 5)" {
        $got  = Get-BestHand -Hands @(
            "KS AH AS AD AC",
            "4H AH 3H 2H 5H")
        $want = @("4H AH 3H 2H 5H")
    
        $got | Should -BeExactly $want
    }
    
    It "aces cannot be in the middle of a straight flush (Q K A 2 3)" {
        $got  = Get-BestHand -Hands @(
            "2C AC QC 10C KC",
            "QH KH AH 2H 3H")
        $want = @("2C AC QC 10C KC")
    
        $got | Should -BeExactly $want
    }
    
    It "both hands have a straight flush, tie goes to highest-ranked card" {
        $got  = Get-BestHand -Hands @(
            "4H 6H 7H 8H 5H",
            "5S 7S 8S 9S 6S")
        $want = @("5S 7S 8S 9S 6S")
    
        $got | Should -BeExactly $want
    }
    
    It "even though an ace is usually high, a 5-high straight flush is the lowest-scoring straight flush" {
        $got  = Get-BestHand -Hands @(
            "2H 3H 4H 5H 6H",
            "4D AD 3D 2D 5D")
        $want = @("2H 3H 4H 5H 6H")
    
        $got | Should -BeExactly $want
    }

    It "winning high card hand also has the lowest card" {
        $got  = Get-BestHand -Hands @(
            "2S 5H 6S 8D 7H",
            "3S 4D 6D 8C 7S")
        $want = @("2S 5H 6S 8D 7H")
    
        $got | Should -BeExactly $want
    }

    It "both hands have the same pair, high card wins" {
        $got  = Get-BestHand -Hands @(
            "4H 4S AH JC 3D",
            "4C 4D AS 5D 6C")
        $want = @("4H 4S AH JC 3D")
    
        $got | Should -BeExactly $want
    }
}
