<#
.SYNOPSIS
    Manage robot factory settings.

.DESCRIPTION
    Generate a random name for a robot when it is created.
    The name should be in the format of two uppercase letters followed by three digits, such as RX837 or BC811.
    The robot should be able to reset and get a completely new name. (Old name that got reset should not be available for future use)

.EXAMPLE
    $robot = [Robot]::new()
    $robot.Name
    Returns: "EX341"
#>

Class Robot {
    [String]$Name
    static  $NameBank = [System.Collections.Generic.HashSet[string]]::new()

    Robot() {
        $this.Name = $this.GenerateName()
    }

    [string] GenerateName() {
        do {
            $newName = $this.GenerateNum() + $this.GenerateChars()
        } while (
            [Robot]::NameBank.Contains($newName)
        )
        [Robot]::NameBank.Add($newName)
        return $newName
    }

    [string] GenerateNum() {
        return -join ('A'..'Z' | Get-Random -Count 2)
    }

    [string] GenerateChars() {
        return -join ('1'..'9' | Get-Random -Count 3) 
    }

    [void] Reset() {
        $this.Name = $this.GenerateName()
    }
}
