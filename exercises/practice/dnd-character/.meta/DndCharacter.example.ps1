Class Character {
    [int]$Strength
    [int]$Dexterity
    [int]$Constitution
    [int]$Intelligence
    [int]$Wisdom
    [int]$Charisma
    [int]$HitPoints

    Character() {
        $this.RollAbilities()
        $this.SetHitPoints()
    }

    [int] Ability() {
        $Dice = 1..4 | ForEach-Object {Get-Random -Minimum 1 -Maximum 7} | Sort-Object
        return ($Dice[1..3] | Measure-Object -Sum).Sum
    }

    Hidden [void] RollAbilities() {
        $this.Strength      = $this.Ability()
        $this.Dexterity     = $this.Ability()
        $this.Constitution  = $this.Ability()
        $this.Intelligence  = $this.Ability()
        $this.Wisdom        = $this.Ability()
        $this.Charisma      = $this.Ability()
    }

    Hidden [void] SetHitPoints() {
        $this.HitPoints = [Character]::GetModifier($this.Constitution) + 10
    }

    static [int] GetModifier([int]$Score) {
        return [Math]::Floor(($Score - 10)/2)
    }
}