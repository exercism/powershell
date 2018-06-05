Function Get-Raindrops() {
    [CmdletBinding()]
    Param(
        [int]$Rain
    )

    # Initialize the result
    [string]$Result = ""

    # Use a hashtable to list the factors and what they are replaced with
    $factorRain = @{
        3 = "Pling";
        5 = "Plang";
        7 = "Plong";
    }

    # Loop over the hashtable testing the factors and building up the result.
    # NOTE: You must sort hashtables if order is important. See: https://blogs.technet.microsoft.com/heyscriptingguy/2014/09/28/weekend-scripter-sorting-powershell-hash-tables/
    Foreach($factor in ($factorRain.GetEnumerator() | Sort-Object -Property Name)){
        If($Rain % $factor.Name -eq 0){
            $Result += $factor.Value
        }
    }

    # Deal with the case that no factors are found so passthrough the original value
    If ([string]::IsNullOrEmpty($Result)){
        $Result = $Rain.ToString()
    }

    # Return the resulting string
    Return $Result
}