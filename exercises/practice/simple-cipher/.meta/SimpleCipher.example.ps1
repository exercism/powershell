Function Invoke-EncodeCipher() {
    <#
    .SYNOPSIS
    Implement a simple shift cipher like Caesar and a more secure substitution cipher.

    .DESCRIPTION
    Given a string of plaintext and a string of key, encode the text using the key.
    If there is no key provided, generate a random key of minumun 100 lowercase letters.
    
    .PARAMETER Plaintext
    String of text to be encrypted.
    This parameter be able to accept value from pipeline.

    .PARAMETER Key
    The key string used to encrypt the plaintext.

    .EXAMPLE
    Invoke-EncodeCipher -Plaintext "b" -Key "d"
    Return: "e"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]$Plaintext,
        [string]$Key
    )

    if (-not $Key) {
        $Key = GenerateKey
    }

    $Key = NormalizeKey $Key $Plaintext.Length
    $alphabets = 'a'..'z'
    $encoded = 0..($Plaintext.Length-1) | ForEach-Object {
        $newIndex = ($alphabets.IndexOf($Plaintext[$_]) + $alphabets.IndexOf($Key[$_])) % 26
        $alphabets[$newIndex]
    }
    -join $encoded
}

Function Invoke-DecodeCipher() {
    <#
    .SYNOPSIS
    Implement a simple shift cipher like Caesar and a more secure substitution cipher.

    .DESCRIPTION
    Given a string of ciphertext and a string of key, decode the text using the key.
    
    .PARAMETER Ciphertext
    String of encoded text.
    This parameter should be able to accept value from pipeline.

    .PARAMETER Key
    The key string used to decode the ciphertext.

    .EXAMPLE
    Invoke-DecodeCipher -Ciphertext "f" -Key "d"
    Return: "c"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true)]
        [string]$Ciphertext,
        [string]$Key
    )
    if (-not $Key) {
        Throw "You need a key to decode ciphertext."
    }

    $Key = NormalizeKey $Key $Ciphertext.Length
    $alphabets = 'a'..'z'
    $decoded = 0..($Ciphertext.Length-1) | ForEach-Object {
        $newIndex = ($alphabets.IndexOf($Ciphertext[$_]) - $alphabets.IndexOf($Key[$_])) % 26
        $alphabets[$newIndex]
    }
    -join $decoded
}

Function GenerateKey() {
    <#
    .SYNOPSIS
    Implement a function to generate a random key to work with the cipher.

    .DESCRIPTION
    Gerate a key string of minimum 100 lowercase letters.

    .EXAMPLE
    GenerateKey
    Return: "zxweavtutoadkjvbtldoljeyahzhaewaujyyowxdqxvxiadkeerloshchnhihmkvpvrwrqfgtbfxwtrnjcwssbawsxqixsbyrlbs"
    #>
    -join (0..99 | ForEach-Object { Get-Random -InputObject ('a'..'z') })
}

Function NormalizeKey($key, $keyLenght) {
    if ($key.Length -lt $keyLenght) {
        $key *= [Math]::Ceiling($keyLenght / $key.Length)
    }
    $key
}