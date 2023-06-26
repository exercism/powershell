Function Invoke-ProteinTranslation() {
    <#
    .SYNOPSIS
    Translate RNA sequences into proteins.

    .DESCRIPTION
    Take an RNA sequence and convert it into condons and then into the name of the proteins in the form of a list.

    .PARAMETER Strand
    The RNA sequence to translate.

    .EXAMPLE
    Invoke-ProteinTranslation -Strand "AUG"
    #>
    [CmdletBinding()]
    Param(
        [string]$Strand
    )
    $protein = @()
    :StrandLoop for ($i = 0; $i -lt $Strand.Length; $i += 3) {
        if ($i + 3 -gt $Strand.Length) { throw "error: Invalid codon" }
        switch ($Strand.Substring($i, 3)) {
            "AUG" { $protein += "Methionine" }
            "UUU" { $protein += "Phenylalanine" }
            "UUC" { $protein += "Phenylalanine" }
            "UUA" { $protein += "Leucine" }
            "UUG" { $protein += "Leucine" }
            "UCU" { $protein += "Serine" }
            "UCC" { $protein += "Serine" }
            "UCA" { $protein += "Serine" }
            "UCG" { $protein += "Serine" }
            "UAU" { $protein += "Tyrosine" }
            "UAC" { $protein += "Tyrosine" }
            "UGU" { $protein += "Cysteine" }
            "UGC" { $protein += "Cysteine" }
            "UGG" { $protein += "Tryptophan" }
            "UAA" { break StrandLoop }
            "UAG" { break StrandLoop }
            "UGA" { break StrandLoop }
            default { throw "error: Invalid codon" }
        }
    }
    return $protein
}
