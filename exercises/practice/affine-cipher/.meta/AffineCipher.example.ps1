Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Use the affine cipher, an ancient encryption system created in the Middle East to encrypt text.

    .DESCRIPTION
    The encryption function is: E(x) = (ai + b) mod m
    
    i is the letter's index from 0 to the length of the alphabet - 1
    m is the length of the alphabet. For the Roman alphabet m is 26.
    a and b are integers which make the encryption key
    Values a and m must be coprime, if not you should throw error.

    .PARAMETER Plaintext
    The text to be encrypted.

    .PARAMETER Keys
    A hashtable contain the pair of keys `a` and `b`.

    .EXAMPLE
    Invoke-Encode -Plaintext "test" -Keys @{a = 5; b = 7}
    Returns: "ybty"
    #>
    [CmdletBinding()]
    Param(
        [string]$Plaintext,
        [hashtable]$Keys
    )
    $alphabets = 'a'..'z'
    $m = $alphabets.Length
    $gcd , $ex, $_ =  ExtendedEuclidean $Keys.a $m

    if ($gcd -ne 1) {
        Throw "a and m must be coprime"
    }

    $charsArray = $Plaintext.ToCharArray() | Where-Object {$_ -match "\w"} | ForEach-Object {
        if ($_ -match "[a-z]") {
            $i = $alphabets.IndexOf([char]::ToLower($_))
            $x = ($Keys.a * $i + $Keys.b) % $m
            $alphabets[$x]
        }else {
            $_
        } 
    }

    (-join $charsArray -split '(\w{5})' | Where-Object {$_}) -join " "
}

Function Invoke-Decode() {
    <#
    .SYNOPSIS
    Use the affine cipher, an ancient encryption system created in the Middle East to decrypt ciphertext.

    .DESCRIPTION
    The decryption function is: D(y) = (a^-1)(y - b) mod m
    
    y is the numeric value of an encrypted letter, i.e., y = E(x)
    it is important to note that a^-1 is the modular multiplicative inverse (MMI) of a mod m
    the modular multiplicative inverse only exists if a and m are coprime, if they are not you should throw error.
    The MMI of a is x such that the remainder after dividing ax by m is 1: ax mod m = 1

    .PARAMETER Ciphertext
    The text to be decrypted.

    .PARAMETER Keys
    A hashtable contain the pair of keys `a` and `b`.

    .EXAMPLE
    Invoke-Decode -Ciphertext "ybty" -Keys @{a = 5; b = 7}
    Returns: "test"
     #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [hashtable]$Keys
    )
    $alphabets = 'a'..'z'
    $m = $alphabets.Length

    $gcd , $ex, $_ =  ExtendedEuclidean $Keys.a $m

    if ($gcd -ne 1) {
        Throw "a and m must be coprime"
    }else {
        $MMI = ($ex % $m + $m) % $m
    }

    $charsArray = $Ciphertext.ToCharArray() | ForEach-Object {
        if ($_ -match "[a-z]") {
            $y = $alphabets.IndexOf($_)
            $x = ($MMI * ($y - $Keys.b)) % $m
            $alphabets[$x]
        } elseif ($_ -match "\d") {
            $_
        }
    }

    -join $charsArray
}

function ExtendedEuclidean($a, $b) {
    if ($a -eq 0) {
        return $b, 0, 1
    }

    $gcd , $x, $y = ExtendedEuclidean ($b % $a) $a 
    $x1, $y1 = $x, $y

    $x = $y1 - [math]::Floor($b / $a) * $x1
    $y = $x1
    return $gcd , $x, $y
}