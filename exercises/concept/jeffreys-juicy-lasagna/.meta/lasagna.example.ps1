New-Variable -Name ExpectedBakeTime -Value 40 -Option Constant
New-Variable -Name MinutesPerLayer -Value 2 -Option Constant

function RemainingTime($Minutes) {
    return $ExpectedBakeTime - $Minutes
}

function PreparationTime($Layers) {
    return $Layers * $MinutesPerLayer
}

function ElapsedTime($Layers, $Minutes) {
    return (PreparationTime $Layers) + $Minutes
}

function Notification {
    return "Lasagna's ready!"
}