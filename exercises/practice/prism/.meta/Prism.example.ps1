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

    $seq = @()
    $tolerance = 0.01
    while ($true) {
        $closestDistance = [double]::PositiveInfinity
        $closestPrism = [Prism]::new()
        $directions = $Laser.GetDirection()
        foreach ($prism in $Prisms) {
            $deltas = $Laser.GetDelta($prism)
            $crossProduct = $deltas.X * $directions.Y - $deltas.Y * $directions.X
            if ([Math]::Abs($crossProduct) -ge $tolerance) {continue}
            $dotProduct = $deltas.X * $directions.X + $deltas.Y * $directions.Y
            if ($dotProduct -le 0) {continue}
            $distance = $deltas.X * $deltas.X + $deltas.Y * $deltas.Y
            if ($distance -ge $closestDistance) {continue}
            $closestDistance = $distance
            $closestPrism = $prism
        }
        if ($closestPrism.Id -eq 0) {break}
        $Laser.Redirect($closestPrism)
        $seq += $closestPrism.Id
    }
    $seq
}

class Laser {
    [double]$X
    [double]$Y
    [double]$Angle

    Laser() {}
    Laser([double]$Angle) {
        $this.Angle = $Angle
    }

    [void] Redirect([Prism]$prism) {
        $this.X = $prism.X
        $this.Y = $prism.Y
        $this.Angle += $prism.Angle
    }

    [PsCustomobject]GetDelta([Prism]$prism) {
        return [PSCustomObject]@{
            X = $prism.X - $this.X
            Y = $prism.Y - $this.Y
        }
    }

    [PsCustomobject]GetDirection() {
        $radian = $this.Angle * [Math]::PI / 180
        return [PSCustomObject]@{
            X = [Math]::Cos($radian)
            Y = [Math]::Sin($radian)
        }
    }
}

class Prism {
    [int]$Id
    [double]$X
    [double]$Y
    [double]$Angle
    Prism() {}
    Prism([int]$Id, [double]$X, [double]$Y, [double]$Angle) {
        $this.Id = $Id
        $this.X = $X
        $this.Y = $Y
        $this.Angle = $Angle
    }
}
