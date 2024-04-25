# Instructions

In this exercise, you need to implement some rules from [Pac-Man][Pac-Man], the classic 1980s-era arcade-game.

There are six tasks in total, four of them are rules related to the game states.

> _Do not worry about how the arguments are derived in functions, just focus on combining the arguments to return the intended result._


## 0. Define a power state

Define a variable named `PowerOn` with a value to represent that the power is indeed on.

```powershell
> $PowerOn
True
```

## 1. Define if Pac-Man eats a ghost

Define the `EatGhost` function that takes two parameters (_if Pac-Man has a power pellet active_ and _if Pac-Man is touching a ghost_) and returns a Boolean value if Pac-Man is able to eat the ghost.
The function should return `True` only if Pac-Man has a power pellet active and is touching a ghost.

```powershell
> EatGhost -ActivePower $false -TouchingGhost $true
False
```

## 2. Define if Pac-Man scores

Define the `Score` function that takes two parameters (_if Pac-Man is touching a power pellet_ and _if Pac-Man is touching a dot_) and returns a Boolean value if Pac-Man scored.
The function should return `True` if Pac-Man is touching a power pellet or a dot.

```powershell
> Score -TouchDot $true -TouchPowerPellet $true
4
```

## 3. Define if Pac-Man loses

Define the `Lose` function that takes two parameters (_if Pac-Man has a power pellet active_ and _if Pac-Man is touching a ghost_) and returns a Boolean value if Pac-Man loses.
The function should return `True` if Pac-Man is touching a ghost and does not have a power pellet active.

```powershell
> Lose -ActivePower $false -TouchingGhost $true
True
```

## 4. Define if Pac-Man wins

Define the `Win` function that takes three parameters (_if Pac-Man has eaten all of the dots_, _if Pac-Man has a power pellet active_, and _if Pac-Man is touching a ghost_) and returns a Boolean value if Pac-Man wins.
The function should return `True` if Pac-Man has eaten all of the dots and has not lost based on the parameters defined in part 3.

```powershell
> Win -EatenAllDots $false -ActivePower $true -TouchingGhost $false
False
```

## 5. Write Synopsis for winning condition

Go back to the last function, add a `Synopsis` section to the comment block as a short description of how to win the game.
The description should be at minimum ten characters long.

```powershell
function MyFunc($Arg) {
    <#
    .DESCRIPTION
    This is a demonstration of the comment-based help with the description keyword.
    #>
}
```

[Pac-Man]: https://en.wikipedia.org/wiki/Pac-Man