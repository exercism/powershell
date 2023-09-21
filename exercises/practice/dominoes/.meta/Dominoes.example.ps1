Function Test-DominoesChain() {
    <#
    .SYNOPSIS
    Implement a function to test if a dominoes chain can be made.

    .DESCRIPTION
    Given a list of dominoes, check to see if they can form a chain.
    A correct chain mean the dots on one half of a stone match the dots on the neighboring half of an adjacent stone,
    and that dots on the halves of the stones which don't have a neighbor (the first and last stone) match each other.

    .PARAMETER Dominoes
    A list of 2-elements arrays, each array represent a domino.

    .EXAMPLE
    Test-DominoesChain -Dominoes @( @(1, 5), @(5, 6), @(6, 1))
    Return: true
    #>
    [CmdletBinding()]
    Param(
        [Collections.Generic.List[int[]]]$Dominoes
    )
    if ($Dominoes.Count -eq 0) {
        return $true
    }

    $len = $Dominoes.Count
    [Collections.Generic.List[Int[]]]$chain = $Dominoes[0]
    $Dominoes.RemoveAt(0)

    Backtrack $Dominoes $chain $len
}


Function Backtrack($dominoes, $chain, $len) {
    <#
    .DESCRIPTION
    Helper function to backtrack solutions
    #>
    if ($chain.Count -eq $len) {
        return $chain[0][0] -eq $chain[-1][1]
    }

    $tail = $chain[-1][1]

    for ($i = 0; $i -lt $dominoes.Count; $i++) {
        $left_pip, $right_pip = $dominoes[$i]
        if ($tail -in $dominoes[$i]) {
            $domino = $right_pip -eq $tail ? @($right_pip, $left_pip) : $dominoes[$i]
            $chain.Add($domino)
            $dominoes.RemoveAt($i)
            if (Backtrack $dominoes $chain $len) {
                return $true
            }else {
                $chain.RemoveAt($chain.Count -1)
                $dominoes.Insert($i, $domino)
            }
        }
    }
    return $false
}