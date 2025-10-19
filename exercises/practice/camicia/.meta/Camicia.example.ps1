using namespace System.Collections.Generic
using namespace System.Text

enum Status {
    Finished
    Loop
}

Function Invoke-Camicia() {
    <#
    .SYNOPSIS
    Simulate a game very similar to the classic card game Camicia.

    .DESCRIPTION
    Given two hands of cards, simulate a game (similar to Camicia) until it ends (or detect if it is in a loop).
    Read instruction for rules and game example.

    .PARAMETER PlayerA
    An array of string(s) represents the first player's cards.

    .PARAMETER PlayerB
    An array of string(s) represents the second player's cards.
    #>
    [CmdletBinding()]
    Param(
        [string[]]$PlayerA,
        [string[]]$PlayerB
    )
    $gameState = [GameState]::New($PlayerA, $PlayerB)
    $stateSet = [HashSet[string]]::new()
    $resultStatus = [Status]::Loop

    while ($true) {
        $stateRepresent = $gameState.ToString()
        if ($stateSet.Contains($stateRepresent)) {
            break
        }
        if ($stateRepresent -match '[JQKA]') {
            $stateSet.Add($stateRepresent) | Out-Null
        }
        PlayTurn($gameState)
        if ($gameState.HasWinner()) {
            $resultStatus = [Status]::Finished
            break
        }
    }
    [PSCustomObject]@{
        Status  = $resultStatus
        Cards   = $gameState.CardsPlayed
        Tricks  = $gameState.Tricks
    }
}

Function PlayTurn ([GameState]$state) {
    while ($true) {
        $startDebt = $state.Debt
        $player = $state.PlayerTurn -eq "A" ? $state.PAHand : $state.PBHand
        $other = $state.PlayerTurn -eq "A" ? $state.PBHand : $state.PAHand
        if ($player.Count -eq 0) {
            $state.Piles | ForEach-Object { $other.Enqueue($_) }
            $state.Piles.Clear()
            $state.Tricks++
            break
        }
    
        $top = $player.Dequeue()
        $state.Piles.Add($top)
        $state.CardsPlayed++

        if ($state.PaymentCards -match $top)
        {
            $state.Debt = $state.PaymentCards.IndexOf($top) + 1
            $state.SwitchPlayer()
        } else {
            $state.Debt = $state.Debt -gt 0 ? $state.Debt - 1 : 0
            if ($startDebt -gt 0 -and $state.Debt -eq 0) {
                $state.SwitchPlayer()
                $state.Piles | ForEach-Object { $other.Enqueue($_) }
                $state.Piles.Clear()
                $state.Tricks++
                break
            }

            if ($state.Debt -eq 0) {
                $state.SwitchPlayer()
            }
        }
    }
}

class GameState {
    [Queue[string]]$PAHand
    [Queue[string]]$PBHand
    [List[string]]$Piles
    [string]$PlayerTurn
    [int]$Tricks
    [int]$Debt
    [string]$PaymentCards
    [int]$CardsPlayed
    
    GameState([string[]]$PlayerA, [string[]]$PlayerB) {
        $this.PAHand = [Queue[string]]::New($PlayerA)
        $this.PBHand = [Queue[string]]::New($PlayerB)
        $this.Piles = [List[string]]::New()
        $this.PlayerTurn = "A"
        $this.Tricks = 0
        $this.Debt = 0
        $this.PaymentCards = "JQKA"
    }

    [bool]HasWinner() {
        return ($this.Piles.Count -eq 0) -and ($this.PAHand.Count -eq 0 -or $this.PBHand.Count -eq 0)
    }

    [string]ToString() {
        $sb = [StringBuilder]::new()
        foreach ($card in $this.PAHand) {
            $sb.Append( $card -match '[JQKA]' ? $card : '_')
        }
        $sb.Append(' ')
        foreach ($card in $this.PBHand) {
            $sb.Append( $card -match '[JQKA]' ? $card : '_')
        }
        return $sb.ToString()
    }

    [void] SwitchPlayer() {
        $this.PlayerTurn = $this.PlayerTurn -eq "A" ? "B" : "A"
    }
}
