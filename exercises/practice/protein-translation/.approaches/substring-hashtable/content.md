# Using `substring` and `hashtable`

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

This approach utilize the `SubString` method to extract sections of a string, and `hashtable` to translate the codons into proteins.

First thing we do is check if the string is divisible by 3, if it isn't then we threw an error because it confirmed there will be invalid codon since all codon have to be exactly a string of 3 characters.

```powershell
    if ($Strand.Length % 3) {Throw "Error: Invalid codon"}
```

Then we set up an empty array to collect all the proteins to be returned later, along with a `hashtable` with codons as keys and their protein names as values.

```powershell
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
```

Next we loop over the indexes of the string, and use index to extract the `subtring` as codon, then use codon as key to retrieve value from the hashtable as protein.

Normally when a `substring` method got called and the index is out of range, it will throw an error that we don't want.
However due to the check we did previously, it eliminated that posibility.

```powershell
    for ($i = 0; $i -lt $Strand.Length; $i+=3) {
        $Protein = $codonsToProteins[$Strand.Substring($i, 3)]
```

After we got a protein, we need to check its value.
If the protein is one of the three terminating protein, we simply break out of the loop and stop the stranlsation process.
If the protein is an invalid one that doesn't existed in the hashtable (`null`), we throw an error.
Otherwise we add the protein into the proteins array.
When the loop has stopped, we simply return the proteins array.
```powershell
        if ("STOP" -eq $Protein) {break}
        if ($null -eq $Protein) {Throw "error: Invalid codon"}
        $Proteins += $Protein
    }
    $Proteins
```

[Hashtable.](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable)

[Substring.](https://ss64.com/ps/substring.html)