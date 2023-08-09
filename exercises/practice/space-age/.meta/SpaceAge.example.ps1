Function Get-SpaceAge() {
    <#
    .SYNOPSIS
    Given an age in seconds, calculate how old someone would be on a planet in the solar system. (RIP Pluto)
    
    .DESCRIPTION
    The function takes a positive integer, and return a double (float) to show how old someone is on a specific planet.

    .PARAMETER $Seconds
    The seconds of a person's age.

    .PARAMETER $Planet
    The planet to calculate how old the person would be on it.
    Note: Since the planets in the solar system is a known shortlist, we can just validate the input with a set of values in the params.
    If no planet is specified, it should be default to Earth.
    
    .EXAMPLE
    Get-SpaceAge -Seconds 1000000000 -Planet Neptune
    Retuns: 0.19
    #>
    [CmdletBinding()]
    Param(
        [int]$Seconds,
        [ValidateSet("Earth", "Mercury","Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", ErrorMessage = "Invalid planet")]
        [string]$Planet = "Earth"
    )

    $OrbitalPeriods = @{
        'Mercury'   = 0.2408467
        'Venus'     = 0.61519726
        'Earth'     = 1
        'Mars'      = 1.8808158
        'Jupiter'   = 11.862615
        'Saturn'    = 29.447498
        'Uranus'    = 84.016846
        'Neptune'   = 164.79132
    }
    $EarthAge = $Seconds / 31557600
    return [math]::Round($EarthAge / $OrbitalPeriods[$Planet],2)
}