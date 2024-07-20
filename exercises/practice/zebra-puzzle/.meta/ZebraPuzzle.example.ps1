# Base values
Enum Color { Blue ; Green ; Ivory ; Red ; Yellow }
Enum Nationality { English ; Japanese ; Norwegian ; Spaniard ; Ukrainian }
Enum Pet { Dog ; Fox ; Horse ; Snails ; Zebra }
Enum Drink { Coffee ; Milk ; OrangeJuice ; Tea ; Water }
Enum Smoke { Paint ; Football ; Dance ; Chess ; Read }

Function Get-Permutation() {
    <#
    .DESCRIPTION
    Permutation implementation
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Collections.Generic.List[Object]] $collection,
        [Collections.Generic.List[Object]] $result = [Collections.Generic.List[Object]]::new()
        
    )
    #base case
    if ($collection.Count -eq 1) {
        $result.Add(@($collection[0]))
        return $result
    }

    for ($i = 0; $i -lt $collection.Count; $i++) {
        $rest = [Collections.Generic.List[Object]]::new($collection)
        $currentElement = $rest[$i]
        $rest.RemoveAt($i)

        $subResult = Get-Permutation $rest
        foreach ($Peruted in $subResult) {
            $result.Add(@($currentElement) + $Peruted)
        }
    }
    return $result
}


Class ZebraPuzzle {
    [object[]] $peoplePer
    [object[]] $colorsPer
    [object[]] $drinksPer
    [object[]] $smokesPer
    [object[]] $petsPer

    ZebraPuzzle() {
        $this.colorsPer = Get-Permutation ([Color].GetEnumNames())
        $this.peoplePer = Get-Permutation ([Nationality].GetEnumNames())
        $this.drinksPer = Get-Permutation ([Drink].GetEnumNames())
        $this.smokesPer = Get-Permutation ([Smoke].GetEnumNames())
        $this.petsPer   = Get-Permutation ([Pet].GetEnumNames())
    }

    [bool] hidden ColorRule($colors) {
        $cond1 = $colors[1] -eq 'Blue'                                      #Rule 15
        $cond2 = $colors[0] -ne 'Red'                                       #Rule 10 + 2
        $cond3 = $colors.IndexOf('Green') - $colors.IndexOf('Ivory') -eq 1  #Rule 6
        return $cond1 -and $cond2 -and $cond3
    }

    [bool] NationalityRule($colors, $people) {
        $cond1 = $people[0] -eq 'Norwegian'                             #Rule 10
        $cond2 = $colors.IndexOf('Red') -eq $people.IndexOf('English')  #Rule 2
        return $cond1 -and $cond2
    }

    [bool] hidden DrinkRule($colors, $people, $drinks) {
        $cond1 = $drinks[2] -eq 'Milk' #Rule 9
        $cond2 = $drinks.IndexOf('Coffee') -eq $colors.IndexOf('Green')     #Rule 4
        $cond3 = $drinks.IndexOf('Coffee') -ne $people.IndexOf('English')   #Rule 4 + 2
        $cond4 = $drinks.IndexOf('Tea') -eq $people.IndexOf('Ukrainian')    #Rule 5
        $cond5 = $drinks.IndexOf('Tea') -ne $colors.IndexOf('Red')          #Rule 5 + 2
        return $cond1 -and $cond2 -and $cond3 -and $cond4 -and $cond5
    }

    [bool] hidden SmokeRule($colors, $people, $drinks, $smokes) {
        $cond1 = $smokes.IndexOf('Paint') -eq $colors.IndexOf('Yellow')             #Rule 8
        $cond2 = $smokes.IndexOf('Chess') -eq $people.IndexOf('Japanese')     #Rule 14
        $cond3 = $smokes.IndexOf('Chess') -ne $colors.IndexOf('Red')          #Rule 14 + 2
        $cond4 = $smokes.IndexOf('Football') -eq $drinks.IndexOf('OrangeJuice')  #Rule 13
        $cond5 = $smokes.IndexOf('Football') -ne $colors.IndexOf('Green')        #Rule 13 + 4
        $cond6 = $smokes.IndexOf('Football') -ne $people.IndexOf('Ukrainian')    #Rule 13 + 5
        return $cond1 -and $cond2 -and $cond3 -and $cond4 -and $cond5 -and $cond6
    }

    [bool] hidden PetRule($colors, $people, $drinks, $smokes, $pets) {
        $cond1 = $people.IndexOf('Spaniard') -eq $pets.IndexOf('Dog')                       #Rule 3
        $cond2 = $smokes.IndexOf('Dance') -eq $pets.IndexOf('Snails')                     #Rule 7
        $cond3 = [Math]::Abs($smokes.IndexOf('Paint') - $pets.IndexOf('Horse')) -eq 1       #Rule 12
        $cond4 = [Math]::Abs($smokes.IndexOf('Read') - $pets.IndexOf('Fox')) -eq 1 #Rule 11
        return $cond1 -and $cond2 -and $cond3 -and $cond4
    }

    [object] Solve() {
    return  $this.colorsPer | Where-Object { $this.ColorRule($_) } | ForEach-Object { $colors = $_
            $this.peoplePer | Where-Object { $this.NationalityRule($colors, $_) } | ForEach-Object { $people = $_
            $this.drinksPer | Where-Object { $this.DrinkRule($colors, $people, $_) } | ForEach-Object {$drinks = $_
            $this.smokesPer | Where-Object { $this.SmokeRule($colors, $people, $drinks, $_) } | ForEach-Object {$smokes = $_
            $this.petsPer   | Where-Object { $this.PetRule($colors, $people, $drinks, $smokes, $_) } | ForEach-Object {$pets = $_
                [PSCustomObject]@{
                People = $people
                Colors = $colors
                Drinks = $drinks
                Smokes = $smokes
                Pets   = $pets
            }}}}}}
    }
}

$result = [ZebraPuzzle]::new().Solve()

Function Get-ZebraOwner() {
    <#
    .SYNOPSIS
    Solve the zebra puzzle and return who owns the zebra.
    #>
    [Nationality]$result.People[$result.Pets.IndexOf('Zebra')]
}

Function Get-WaterDrinker() {
    <#
    .SYNOPSIS
    Solve the zebra puzzle and return who drinks water.
    #>
    [Nationality]$result.People[$result.Drinks.IndexOf('Water')]
}