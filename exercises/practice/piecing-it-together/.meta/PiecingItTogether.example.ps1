<#
.SYNOPSIS
Given partial information about a jigsaw puzzle, add the missing pieces.

.DESCRIPTION
Calculate properties of a jigsaw puzzle with given information if possible.
If not possible due to insufficient or incorrect information, the user should be notified.
Read instructions for more information and example.
#>

enum Format {
    Unknown
    Portrait
    Square
    Landscape
}

class JigsawPuzzle {
    [int]$Pieces
    [int]$Border
    [int]$Inside
    [int]$Rows
    [int]$Columns
    [double]$AspectRatio
    [Format]$Format

    GetData([PSCustomObject]$partialData)
    {
        if ($partialData.PSObject.Properties.Name -contains "AspectRatio") {
            $this.ProcessDataFromRatio($partialData)
        } elseif ($partialData.PSObject.Properties.Name -contains "Format") {
            $this.ProcessDataFromFormat($partialData)
        } else {
            throw "insufficient data"
        }
    }

    FillFromRowsAndColumns()
    {
        $this.Pieces = $this.Rows * $this.Columns
        $this.Border = 2*$this.Rows + 2*$this.Columns - 4
        $this.Inside = $this.Pieces - $this.Border
        $this.AspectRatio = $this.Columns / $this.Rows
    }

    [int[]]FindRowsAndColumn() {
        $a, $b = 0, 0
        for ($i = 1; $i -le [Math]::Sqrt($this.Pieces); $i++) {
            if (($i * $i * $this.AspectRatio) -eq $this.Pieces) {
                $a, $b = $i, ($i * $this.AspectRatio)
                break
            }
        }
        return $this.Format -eq [Format]::Landscape ? [Math]::Min($a,$b), [Math]::Max($a,$b) 
                                                    : [Math]::Max($a,$b), [Math]::Min($a,$b) 
    }

    ProcessDataFromRatio([PSCustomObject]$partialData)
    {
        $properties = $partialData.PSObject.Properties.Name
        $this.AspectRatio = $partialData.AspectRatio
        $this.Format = switch ($true) {
            ($partialData.AspectRatio -gt 1) { [Format]::Landscape }
            ($partialData.AspectRatio -lt 1) { [Format]::Portrait }
            Default {[Format]::Square}
        }

        if ($properties -contains "Pieces") {
            $this.Pieces = $partialData.Pieces
            $this.Rows, $this.Columns = $this.FindRowsAndColumn()
        } elseif ($properties -contains "Border") {
            $this.Border = $partialData.Border
            $this.Rows = ($this.Border + 4) / (2 * (1 + $this.AspectRatio))
            $this.Columns = $this.Rows * $this.AspectRatio
        } elseif ($properties -contains "Inside") {
            $this.Inside = $partialData.Inside
            $r = $this.AspectRatio
            $i = $this.Inside

            $discriminant = [Math]::Pow((2 * $r + 2), 2) - (16 * $r) + (4 * $r * $i)
            $rows1 = ((2 * $r + 2) + [Math]::Sqrt($discriminant)) / (2 * $r)
            $rows2 = ((2 * $r + 2) - [Math]::Sqrt($discriminant)) / (2 * $r)

            $this.Rows = @($rows1, $rows2) | Where-Object { $_ -gt 0 -and [Math]::Round($_) -eq $_ } | Select-Object -First 1
            $this.Columns = $r * $this.Rows
        } elseif ($properties -contains "Rows") {
            $this.Rows = $partialData.Rows
            $this.Columns = $this.AspectRatio * $this.Rows
        } elseif ($properties -contains "Columns") {
            $this.Columns = $partialData.Columns
            $this.Rows = $this.Columns / $this.AspectRatio
        }
        $this.FillFromRowsAndColumns()
    }

    ProcessDataFromFormat([PSCustomObject]$partialData)
    {
        $this.Format = $partialData.Format
        $properties = $partialData.PSObject.Properties.Name
        if ($this.Format -eq [Format]::Square) {
            $this.AspectRatio = 1.0
            if ($properties -contains "Pieces") {
                $this.Rows = $this.Columns = [Math]::Sqrt($partialData.Pieces)
            } elseif ($properties -contains "Rows") {
                $this.Rows = $partialData.Rows
                $this.Columns = $this.Rows
            } elseif ($properties -contains "Columns") {
                $this.Columns = $partialData.Columns
                $this.Rows = $this.Columns
            } elseif ($properties -contains "Border") {
                $this.Rows = $this.Columns = ($partialData.Border + 4) / 4
            } elseif ($properties -contains "Inside") {
                $this.Rows = $this.Columns = [Math]::Sqrt($partialData.Inside) + 2
            } else {
                throw "bad data"
            }
        } else {
            $otherProperties = ($properties | Where-Object { $_ -ne "Format"}).Count
            if ($otherProperties -lt 2) {
                throw "insufficient data"
            }
            $pairs = $this.GenerateRowsAndColumnsFromFormat([PSCustomObject]$partialData)
            foreach ($pair in $pairs) {
                $tempPieces = $pair[0] * $pair[1]
                $tempBorder = 2*$pair[0] + 2*$pair[1] - 4
                if ($tempPieces -eq $partialData.Pieces -and $tempBorder -eq $partialData.Border) {
                    if ($partialData.Format -eq [Format]::Landscape) {
                        $this.Rows = [Math]::Min($pair[0], $pair[1])
                        $this.Columns = [Math]::Max($pair[0], $pair[1])
                    } else {
                        $this.Rows = [Math]::Max($pair[0], $pair[1])
                        $this.Columns = [Math]::Min($pair[0], $pair[1])
                    }
                }
            }

        }
        $this.FillFromRowsAndColumns()
        $this.ValidateGivenData($partialData)
    }

    [object[]]GenerateRowsAndColumnsFromFormat([PSCustomObject]$partialData) {
        $properties = $partialData.PSObject.Properties.Name
        $pairs = @()
        if ($properties -contains "Pieces") {
            $this.Pieces = $partialData.Pieces
            for ($r = 1; $r -le [Math]::Sqrt($this.Pieces); $r++) {
                for ($c = $r; $c -le $this.Pieces; $c++) {
                    if ($r * $c -eq $this.Pieces) {
                        $pairs += ,@($c, $r)
                    }
                }
            }
        }elseif ($properties -contains "Border") {
            $this.Border = $partialData.Border
            $sum = ($this.Border + 4) / 2
            for ($c = 1; $c -lt ($sum - 1); $c++) {
                $pairs += ,@($c, ($sum - $c))
            }
        }
        return $pairs
    }

    ValidateGivenData([PSCustomObject]$partialData)
    {
        foreach ($property in $partialData.psobject.Properties) {
            if ($property.Value -ne $this.PSObject.Properties[$property.Name].Value) {
                throw "contradictory data"
            }
        }
    }
}
