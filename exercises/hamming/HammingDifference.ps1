function Get-HammingDifference([string]$strand1, [string]$strand2) {
  if ( $strand1.length -ne $strand2.length) {
    Throw "Mismatching string lengths"
  }
  $first = [char[]][string]$strand1
  $second = [char[]][string]$strand2
  $result = 0
  for ($i=0; $i -lt $first.length; $i++) {
    if ( $first[$i] -ne $second[$i] ) {
      $result += 1
    }
  }
  return $result
}
