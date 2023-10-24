<#
.SYNOPSIS
    Given two buckets of different size and which bucket to fill first, determine how many actions are required to measure an exact number of liters by strategically transferring fluid between the buckets.

.DESCRIPTION
    Please read the rules of how to implement the solution in instructions.
    
    Your task here is to implement a class to solve for the solution.
    The class should take in : size of bucket 1, size of bucket 2, and which bucket to start with "one" or "two"
    The class should have the Measure method that take in the target, and if possible return an object for the result.

    If it is not possible to reach the target, please throw an error.
    
.EXAMPLE
    $buckets = [TwoBucket]::new(6, 7, "one")
    $buckets.Measure(5) | Format-List

    Returns:
    Moves       : 4
    GoalBucket  : one
    OtherBucket : 7
#>
Class State {
    <#
    .DESCRIPTION
    A state class, represent amount of water in each bucket, and how many moves have been made to get to this state.
    #>
    [int] hidden $water1
    [int] hidden $water2
    [int] hidden $move
    [int] static hidden $PRIME1 = 17
    [int] static hidden $PRIME2 = 53

    State([int] $bucket1, [int] $bucket2, [int] $move) {
        $this.water1 = $bucket1
        $this.water2 = $bucket2
        $this.move = $move
    }

    [bool] TargetReached([int] $target) {
        return $this.water1 -eq $target -or  $this.water2 -eq $target
    }

    [PSCustomObject] GetResult([int]$target) {
        return [PSCustomObject]@{
            Moves       = $this.move
            GoalBucket  = $this.water1 -eq $target ? "one" : "two"
            OtherBucket = $this.water1 -eq $target ? $this.water2 : $this.water1
        }
    }
    #these 2 need to be implemeted so State can work nicely in a hashset
    [bool] hidden Equals($other) {
        $equalBucket1 = $this.water1 -eq $other.water1
        $equalBucket2 = $this.water2 -eq $other.water2
        return $equalBucket1 -and $equalBucket2
    }

    [int] hidden GetHashCode() {
        return ([State]::PRIME1 * $this.water1) + ([State]::PRIME2 * $this.water2)
    }
}

Class TwoBucket {
    [int] $sizeOne
    [int] $sizeTwo
    [int] hidden $FIRST
    [int] hidden $SECOND
    [int] hidden $start
    [State] hidden $setupState

    TwoBucket([int] $size1, [int] $size2, [string] $start) {
        $this.FIRST   = 1
        $this.SECOND  = -1
        $this.sizeOne = $size1
        $this.sizeTwo = $size2
        $this.start   = $start -eq "one" ? $this.FIRST : $this.SECOND
        $this.setupState = [State]::new(0, 0, 0)
    }

    [PSCustomObject] Measure([int] $target) {
        <#
        .DESCRIPTION
        Main method
        #>
        $this.ValidateBuckets($this.sizeOne, $this.sizeTwo, $target)

        $initialStart   = $this.Fill($this.setupState, $this.start)
        $unallowedState = $this.Fill($this.setupState, -$this.start)

        $invalidStates = [System.Collections.Generic.HashSet[State]]::new()
        $invalidStates.Add($unallowedState)

        $queue = [System.Collections.Queue]::new(@($initialStart))

        while ($queue.Count) {
            $currentState = $queue.Dequeue()
            
            if ($currentState.TargetReached($target)) {
                return $currentState.GetResult($target)
            }

            $invalidStates.Add($currentState)
            $actions = $this.GetActions($currentState)

            foreach ($action in $actions) {
                if (-not $invalidStates.Contains($action)) {
                    $queue.Enqueue($action)
                }
            }
        }
        return $null
    }

    [State[]] hidden GetActions([State] $state) {
        <#
        .DESCRIPTION
        Method to perform all possible actions from a state
        #>
        $fill1    = $this.Fill($state,$this.FIRST)
        $fill2    = $this.Fill($state,$this.SECOND)
        $empty1   = $this.Empty($state,$this.FIRST)
        $empty2   = $this.Empty($state,$this.SECOND)
        $pour1to2 = $this.Pour($state,$this.FIRST,$this.SECOND)
        $pour2to1 = $this.Pour($state,$this.SECOND,$this.FIRST)
        return $fill1, $fill2, $empty1, $empty2, $pour1to2, $pour2to1
    }

    [State] hidden Fill([State] $state, [int] $bucket) {
        $water1 = $bucket -eq $this.FIRST  ? $this.sizeOne : $state.water1
        $water2 = $bucket -eq $this.SECOND ? $this.sizeTwo : $state.water2
        $move = $state.move + 1
        return [State]::new($water1, $water2, $move)
    }

    [State] hidden Empty([State] $state, [int] $bucket) {
        $water1 = $bucket -eq $this.FIRST ? 0 : $state.water1
        $water2 = $bucket -eq $this.SECOND ? 0 : $state.water2
        $move = $state.move + 1
        return [State]::new($water1, $water2, $move)
    }

    [State] hidden Pour([State] $state, [int] $from, [int] $to) {
        if ($from -eq $this.FIRST) {
            $give = [math]::Min($state.water1, $this.sizeTwo - $state.water2)
            $water1 = $state.water1 - $give
            $water2 = $state.water2 + $give
        }else {
            $give = [math]::Min($state.water2, $this.sizeOne - $state.water1)
            $water1 = $state.water1 + $give
            $water2 = $state.water2 - $give
        }
        $move = $state.move + 1
        return [State]::new($water1, $water2, $move)
    }

    [void] hidden ValidateBuckets([int] $bucket1, [int] $bucket2, [int] $target) {
        <#
        .DESCRIPTION
        Helper function to validate buckets and determine if a goal is possible
        #>
        if ($bucket1 -eq $bucket2) {
            Throw "Two buckets can't be of the same size"
        }
        if ($target -gt $bucket1 -and $target -gt $bucket2) {
            Throw "Target is impossible to reach"
        }
        $gcd = [System.Numerics.BigInteger]::GreatestCommonDivisor($bucket1, $bucket2)
        if ($target % $gcd) {
            Throw "Target is impossible to reach"
        }
    }
}