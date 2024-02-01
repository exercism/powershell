Enum Rank {
    HIGH_CARD
    PAIR
    TWO_PAIRS
    THREE_OF_A_KIND
    LOW_STRAIGHT
    HIGH_STRAIGHT
    FLUSH
    FULL_HOUSE
    FOUR_OF_A_KIND
    LOW_STRAIGHT_FLUSH
    STRAIGHT_FLUSH
    ROYAL_FLUSH
}

Function Get-BestHand() {
    <#
    .SYNOPSIS
    Pick the best hand(s) from a list of poker hands.

    .DESCRIPTION
    Given an array of poke hands, pick out the best (highest value) hand(s) and return them in an array.

    .PARAMETER Hands
    An array of string(s), each representing a poker hand.

    .EXAMPLE
    Get-BestHand -Hands @("AS QS KS 10S JS", "JS AH QD 10S KC")
    Return: @("AS QS KS 10S JS")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Hands
    )
    if ($Hands.Length -eq 1) {return $Hands}
    $besthands = [Collections.Generic.List[string]]::new()
    $currentBest = $null

    foreach ($hand in $Hands) {
        $curHand = [Poker]::new($hand)
        if ($null -eq $currentBest -or $curHand -gt $currentBest) { 
            $currentBest = $curHand
            $besthands.Clear()
        }
        if ($curHand -eq $currentBest) {
            $besthands.Add($curHand.HandStr)
        }
    }
    $besthands
}

class Card {
    [int] $Value
    [string] $Suit
    [string] static $Pattern = "^(\d+|[JQKA])([HCSD])$"

    Card ([string]$card) {
        $valid = $card -match [Card]::Pattern
        if (-not $valid) {Write-Error "Invalid card: $card" -ErrorAction Stop}
        $this.Value = $Matches[1] -eq "10" ? 10 : "..23456789XJQKA".IndexOf($Matches[1])
        $this.Suit  = $Matches[2]
    }
}

class Poker : IComparable {
    [string] $HandStr
    [Card[]] $Cards
    [Rank] $Rank
    [int] $RawValue

    Poker ([string] $hand) {
        $this.HandStr = $hand
        $this.Cards = $this.SortHand($hand)
        $this.RawValue = $this.GetValue($this.Cards)
        $this.Rank = $this.GetRank($this.Cards)
    }

    [Card[]] SortHand($hand) {
        <#
        Helper function to sort the hand based on occurent and then value
        #>
        return  -split $hand
            | ForEach-Object {[Card]::new($_)} 
            | Group-Object Value
            | Sort-Object -Property @{Expression={$_.Count}; Descending=$true}, @{Expression={[int]$_.Name}; Descending=$true}
            | ForEach-Object {$_.Group}
    }

    [int] GetValue([Card[]] $sortedCards) {
        <#
        Helper function to return a raw int value of the hand
        #>
        return [int](-join ($sortedCards | ForEach-Object {$_.Value}))
    }

    [Rank] GetRank([Card[]] $sortedCards) {
        <#
        Function to return the proper hand rank
        #>
        $unqCards = ($sortedCards | ForEach-Object {$_.Value} | Get-Unique).Count
        $isFlush  = ($sortedCards | ForEach-Object {$_.Suit}  | Get-Unique).Count -eq 1
        $isLwStr  = $this.RawValue -eq 145432 #A5432
        $isHgStr  = ($unqCards -eq 5) -and ($sortedCards[0].Value - $sortedCards[-1].Value) -eq 4

        if ($isFLush) {
            if ($isLwStr) {return [Rank]::LOW_STRAIGHT_FLUSH}
            if ($isHgStr) {
                if ($sortedCards[0].Value -eq 14) {return [Rank]::ROYAL_FLUSH}
                return [Rank]::STRAIGHT_FLUSH
            }
            return [Rank]::FLUSH
        }

        if ($isLwStr) {return [Rank]::LOW_STRAIGHT}
        if ($isHgStr) {return [Rank]::HIGH_STRAIGHT}

        if ($unqCards -eq 2) {
            if ($sortedCards[0].Value -eq $sortedCards[3].Value) {return [Rank]::FOUR_OF_A_KIND}
            return [Rank]::FULL_HOUSE
        }

        if ($unqCards -eq 3) {
            if ($sortedCards[0].Value -eq $sortedCards[2].Value) {return [Rank]::THREE_OF_A_KIND}
            return [Rank]::TWO_PAIRS
        }

        if ($unqCards -eq 4) {return [Rank]::PAIR}
        return [Rank]::HIGH_CARD
    }

    [int] CompareTo([System.Object]$other) {
        if ($this.Rank -lt $other.Rank) {
            return -1
        } elseif (($this.Rank -gt $other.Rank) -or ($this.RawValue -gt $other.RawValue)) {
            return 1
        }
        return 0
    }

    [bool] Equals([System.Object]$other) {
        return ($this.Rank -eq $other.Rank) -and ($this.RawValue -eq $other.RawValue)
    }
}