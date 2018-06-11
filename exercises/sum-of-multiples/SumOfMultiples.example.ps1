Function Get-SumOfMultiples {
    [CmdletBinding()]
    Param(
        [int[]]$Multiples,
        [int]$Limit
    )

    $result = 0;

    for($i = 1; $i -lt $Limit; $i ++) {
        foreach($multiple in $Multiples) {
            if ($i % $multiple -eq 0) {
                $result += $i
                break   # Break out of the foreach look because we've found a factor
            }
        }
    }

    Return $result;
}
