Function Get-PrismSequence() {
    <#
    .SYNOPSIS
    Finds the sequence of prisms hit by a laser.

    .DESCRIPTION
    Determines the order in which a laser beam encounters prisms based on
    the laser's starting position and angle. After hitting a prism, the
    laser is moved to that prism and its angle is adjusted by the prism's
    refraction angle.
    See visual demonstration for more details.

    .PARAMETER Laser
    Infomation about the laser.

    .PARAMETER Prisms
    Infomation about the prisms.
    #>
    [CmdletBinding()]
    Param(
        [Laser]$Laser,
        [Prism[]]$Prisms
    )

    Throw "Please implement this function"
}

class Laser {
    [double]$X
    [double]$Y
    [double]$Angle

    Laser() {
        Throw "Please implement this class"
    }
}

class Prism {
    [int]$Id
    [double]$X
    [double]$Y
    [double]$Angle

    Prism() {
        Throw "Please implement this class"
    }
}
