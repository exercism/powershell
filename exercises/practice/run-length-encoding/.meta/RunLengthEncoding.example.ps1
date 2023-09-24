Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Implement run-length encoding function.

    .DESCRIPTION
    Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count.
    
    For example we can represent the original 53 characters with only 13.
    "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"

    .PARAMETER Data
    A string represent the data to be encoded.
    This parameter should accept value from pipeline.

    .EXAMPLE
    Invoke-Encode -Data "EEXEERCIIISM"
    Return: "2EX2ERC3ISM"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$Data
    )

    $encoded = @()
    $currentChar = $null
    $count = 0

    for ($i = 0; $i -lt $Data.Length; $i++) {
        $char = $Data[$i]
        if ($char -ceq $currentChar -or $null -eq $currentChar) {
            $currentChar = $char
            $count ++
        }else {
            $compressed = $count -eq 1 ? "$currentChar" : "$count$currentChar"
            $encoded += $compressed
            $currentChar = $char
            $count = 1
        }
        #handle the last character
        if ($i -eq ($Data.Length - 1)) {
            $compressed = $count -eq 1 ? "$currentChar" : "$count$currentChar"
            $encoded += $compressed
        }
    }
    
    -join $encoded
}
Function Invoke-Decode() {
        <#
    .SYNOPSIS
    Implement run-length decoding function.

    .DESCRIPTION
    Decoding is the reverse of encoding compression, it turn the compressed data into the original form.
    
    For example we can turn the encoded 13 characters to the original 53.
    "12WB12W3B24WB"   ->   "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"

    .PARAMETER Data
    A string represent the data to be decoded.
    This parameter should accept value from pipeline.

    .EXAMPLE
    Invoke-Decode -Data "2EX2ERC3ISM"
    Return: "EEXEERCIIISM"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$Data
    )
    $chunks = $Data -split "(\d*[A-Za-z\s])"
    $decoded = $chunks | ForEach-Object {
        if ($_ -match "(\d*)([A-Za-z\s])") {
            $dup = $Matches[1] ? $Matches[1] : 1
            $Matches[2] * $dup
        }
    }
    -join $decoded
}