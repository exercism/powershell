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
   
    Robot() {
        Throw "Please implement this class"
    }

    [void] Reset() {
        Throw "Please implement this function"
    }
}
