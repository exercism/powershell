# Using `regex` and `switch` statement

```powershell
function ProteinTranslation {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )
    $codons = $Strand -split "(\w{3})" -ne ""
    switch -Regex ($codons) {
        "AUG"           { "Methionine" }
        "UU[U|C]"       { "Phenylalanine" }
        "UU[A|G]"       { "Leucine" }
        "UC[U|C|A|G]"   { "Serine" }
        "UA[U|C]"       { "Tyrosine" }
        "UG[U|C]"       { "Cysteine" }
        "UGG"           { "Tryptophan" }
        "(UAA|UAG|UGA)" { break }
        Default {Throw "Error: Invalid codon"}
    }
}
```

This approach utilize `regex` and `switch` statement to work with strings.

First, the string being split into an array of strings by length 3.
When a string length is not divisible by 3, the last string will simply be a string of lenght less than 3.

```powershell
$codons = $Strand -split "(\w{3})" -ne ""
```

Next we utilize the flexibility of `switch` statement in Powershell to translate these strings of codons into the correct protein name.
We set the `-Regex` flag for `switch` statement so it can match `regex` patterns of codons to correspondent proteins.

```powershell
switch -Regex ($codons) {
        "AUG"           { "Methionine" }
        "UU[U|C]"       { "Phenylalanine" }
        "UU[A|G]"       { "Leucine" }
        "UC[U|C|A|G]"   { "Serine" }
        "UA[U|C]"       { "Tyrosine" }
        "UG[U|C]"       { "Cysteine" }
        "UGG"           { "Tryptophan" }
```

If the codon match any of three terminating codons (`STOP` value) then we simply just `break` out of the `switch` statement, and end the translation there.

```powershell
        "(UAA|UAG|UGA)" { break }
```

Anything else and it would be an invalid codon and should throw an error.

```powershell
        Default {Throw "Error: Invalid codon"}
```

If no error were thrown, an array of proteins is now being returned.

[Regular expression.](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_regular_expressions)

[Switch statement.](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch)