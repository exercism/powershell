Function Get-NucleotideCount() {
    [CmdletBinding()]
    Param(
        [string]$Strand = ""
    )

    $nucleotides = "ACGT"
    $nucleotideRegEx = "^[$($nucleotides)]+$"

    # Test for valid Strand values (empty string or made up of a string of ACGT characters in any order)
    If ($Strand -ne "" -and $Strand -notmatch $nucleotideRegEx){
        Throw "Invalid nucleotide in strand"
    }

    $result = ""

    # Count the nucleotides in the strand
    ForEach($nucleotide in $nucleotides.ToCharArray()){
        $count = 0
        For($i = 0; $i -lt $Strand.Length; $i++){
            # Test if the current charcter in the strand is the nucleotide we are counting
            If ($Strand[$i] -eq $nucleotide){
                $count ++
            }
        }

        # Add a space to the output if needed
        If ($result -ne "") {
            $result += " "
        }
        
        $result += ("{0}:{1}" -f $nucleotide, $count)
    }

    Return $result
}
