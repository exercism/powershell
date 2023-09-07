<#
.SYNOPSIS
Implement a simple shift cipher like Caesar and a more secure substitution cipher.

.DESCRIPTION
Implement a simple cipher class to encode or decode a message with a key.
If there was no key provided, generate one minumum 100 characters long contains only lower case letter (a-z).

.EXAMPLE
$cipher = [SimpleCipher]::new("mykey")

$cipher.Encode("aaaaa")
Return: "mykey"

$cipher.Decode("ecmvcf")
Return: "secret"
#>

Class SimpleCipher {
    hidden $alphabets = 'a'..'z'
    [string]$_key

    SimpleCipher() {
        $this._key = $this.GenerateKey()
    }

    SimpleCipher([string]$Key) {
        $this._key = $Key
    }

    hidden [string] GenerateKey() {
        <#
        .DESCRIPTION
        Gerate a key string of minimum 100 lowercase letters.
        #>
        return -join (0..99 | ForEach-Object { Get-Random -InputObject ('a'..'z') })
    }

    hidden [string] AdjustKey([string]$key, [int]$keyLenght) {
        if ($key.Length -lt $keyLenght) {
            $key *= [Math]::Ceiling($keyLenght / $key.Length)
        }
        return $key
    }

    [string] Encode([string]$Plaintext) {
        <#
        .DESCRIPTION
        Encoding plaintext using key and shift cipher method.
        #>
        $Key = $this.AdjustKey($this._key, $Plaintext.Length)

        $encoded = 0..($Plaintext.Length-1) | ForEach-Object {
            $newIndex = ($this.alphabets.IndexOf($Plaintext[$_]) + $this.alphabets.IndexOf($Key[$_])) % 26
            $this.alphabets[$newIndex]
        }
        return -join $encoded
    }

    [string] Decode([string]$Ciphertext) {
        <#
        .DESCRIPTION
        Decoding ciphertext using key and shift cipher method.
        #>
        $Key = $this.AdjustKey($this._key, $Ciphertext.Length)

        $decoded = 0..($Ciphertext.Length-1) | ForEach-Object {
            $newIndex = ($this.alphabets.IndexOf($Ciphertext[$_]) - $this.alphabets.IndexOf($Key[$_])) % 26
            $this.alphabets[$newIndex]
        }
        return -join $decoded
    }
}