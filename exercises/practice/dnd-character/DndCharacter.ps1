<#
.SYNOPSIS
    Generate a DnD character with all the classic abilities by rolling 4 dice.

.DESCRIPTION
    A DnD character starts has, among other things, six abilities:
    strength, dexterity, constitution, intelligence, wisdom and charisma.
    These abilities score are determined randomly by throwing dice.
    Throw 4 six-sided dice and return the the sum of the largest three.
    Your character's inittial hitpoints are: 10 + your character's constitution modifier.
    You find your character's constitution modifier by but this formula : (Constitution - 10) / 2 and then round down.
    
.EXAMPLE
    $character = [Character]::new()
    $character | Format-Table
    
    Strength Dexterity Constitution Intelligence Wisdom Charisma HitPoints
    -------- --------- ------------ ------------ ------ -------- ---------
           7        10           15            9     13       13        12

#>
Class Character {
    Character() {
        Throw "Please implement this class"
    }

    static [int] GetModifier([int]$Score) {
        Throw "Please implement this function"
    }
}