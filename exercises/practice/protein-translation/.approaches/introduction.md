# Introduction

There are many idiomatic approaches to solve the exercise Protein Translation.
The `substring` method could be used tandem with a `hashtable` to look up values.
Utilizing `regex` combine with the flexibility of `switch` statement to arrive to a neat approach. 

## General guidance

The main object of this exercise is to deal with the input string by chunks of three characters, each chunk (codon) can be translate into a protein.
If a codon has a `STOP` value then the translation process is halted.


## Approach: `substring` and `hashtable`

This approach use `substring` method to look up a section of the input string, then use that value to retrive the result from a `hashtable`.

```powershell
Function ProteinTranslation() {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )
    if ($Strand.Length % 3) {Throw "Error: Invalid codon"}
    $Proteins = @()
    $codonsToProteins = @{
        "AUG" = "Methionine"
        "UUU" = "Phenylalanine"
        "UUC" = "Phenylalanine"
        "UUA" = "Leucine"
        "UUG" = "Leucine"
        "UCU" = "Serine"
        "UCC" = "Serine"
        "UCA" = "Serine"
        "UCG" = "Serine"
        "UAU" = "Tyrosine"
        "UAC" = "Tyrosine"
        "UGU" = "Cysteine"
        "UGC" = "Cysteine"
        "UGG" = "Tryptophan"
        "UAA" = "STOP"
        "UAG" = "STOP"
        "UGA" = "STOP"
    }
    for ($i = 0; $i -lt $Strand.Length; $i+=3) {
        $Protein = $codonsToProteins[$Strand.Substring($i, 3)]
        if ("STOP" -eq $Protein) {break}
        if ($null -eq $Protein) {Throw "error: Invalid codon"}
        $Proteins += $Protein
    }
    $Proteins
}
```

For more information, check the [`substring` and `hashtable` approach][approach-substring-hashtable].


## Approach: `regex` and `switch` statement

This approach utilize `regex` to deal with the input, then use `switch` statement to get to the result.

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

For more information, check the [`regex` and `switch` statement approach][approach-regex-switch].


[approach-regex-switch]: https://exercism.org/tracks/powershell/exercises/protein-translation/approaches/regex-switch
[approach-substring-hashtable]: https://exercism.org/tracks/powershell/exercises/protein-translation/approaches/ordered-hashtable