New-Variable -Name "PowerOn" -Value $true

function EatGhost($ActivePower, $TouchingGhost) {
    <#
    .PARAMETER ActivePower
    Boolean value - does the player have an active power pellet?

    .PARAMETER TouchingGhost
    Boolean value - is the player touching a ghost?
    #>
    $ActivePower -and $TouchingGhost
}

function Score($TouchPowerPellet, $TouchDot) {
    <#
    .PARAMETER TouchPellet
    Boolean value - does the player have an active power pellet?

    .PARAMETER TouchDot
    Boolean value - is the player touching a ghost?
    #>
    $TouchPowerPellet -or $TouchDot
}

function Lose($ActivePower, $TouchingGhost) {
    <#
    .PARAMETER ActivePower
    Boolean value - does the player have an active power pellet?

    .PARAMETER TouchingGhost
    Boolean value - is the player touching a ghost?
    #>
    (-not $ActivePower) -and $TouchingGhost
}   


function Win($EatenAllDots, $ActivePower, $TouchingGhost) {
    <#
    .SYNOPSIS
    Function to check if the game has been won.

    .PARAMETER EatenAllDots
    Boolean value - does the player have an active power pellet?

    .PARAMETER ActivePower
    Boolean value - is the player touching a ghost?

    .PARAMETER TouchingGhost
    Boolean value - is the player touching a ghost?
    #>
    $EatenAllDots -and -not (Lose $ActivePower $TouchingGhost)
}
