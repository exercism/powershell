<#
.SYNOPSIS
Implement a RESTful API for tracking IOUs.

.DESCRIPTION
Implement a RestAPI class that can receives IOUs from POST requests, and able to deliver specified summary information from GET requests.

The class should have the two main methods : 'Get' and 'Post'
- Get method : accept an URL string ("/users") and an optional payload (json string), and it returns an object based on whether payload was provided or not.
- Post method : accept an URL string ("/add" or "/iou") and a payload (json string), it returns an object based on the ULR input.

Please read instructions for more details about the methods, their payload format and their response format.

.EXAMPLE
$data = @{ 
    users = @(
        @{name = "Adam"; owes = @{}; owed_by = @{}; balance = 5.0}
        @{name = "Bob" ; owes = @{}; owed_by = @{}; balance = 3.0}
    ) 
}

$api = [RestAPI]::new($data)

# Get method to retrieve one single user
$api.Get("/users", '{"users":["Adam"]}' )
Returns: @{ users = @(
                @{ name = "Adam"; owes = @{}; owed_by = @{};balance = 5.0 }
            )
        }

# Post method to add a new user
$api.Post("/add", '{"users":["Chuck"]}')
Returns: @{ name = "Chuck"; owes = @{}; owed_by = @{}; balance = 0.0 }
#>

Class RestAPI{
    [hashtable] $Database 

    RestAPI([object] $data) {
        $this.Database = @{}
        foreach ($user in $data.users) {
            $this.Database[$user.name] = $user
        }
    }

    [object] Get([string] $url) {
        if ($url -ne "/users") { return $null }
        return @{ users = $this.Database.Values }
    }

    [object] Get([string] $url, [string] $payload) {
        if ($url -ne "/users") { return $null }
        $names = ($payload | ConvertFrom-Json).users
        return @{"users" = @($this.Database.Values | Where-Object {$names -contains $_.name} | Sort-Object name) }
    }

    [object] Post([string] $url, [string] $payload) {
        if (-not $payload) {return $null}
        $response = switch ($url) {
            '/add' { $this.AddUser($payload) }
            '/iou' { $this.AddIou($payload) }
            Default {Throw "Invalid url"}
        }
        return $response
    }

    [object] hidden AddUser([string] $payload) {
        $name = ($payload | ConvertFrom-Json).user
        if ($this.Database.ContainsKey($name)) {Throw "User already existed"}
        $newUser = @{ "name" = $name ; "owes" = @{}; "owed_by" = @{}; "balance" = 0.0 }
        $this.Database[$name] = $newUser
        return $newUser
    }

    [object] hidden AddIou([object] $payload) {
        $iou = $payload | ConvertFrom-Json

        $this.Database[$iou.lender].owes[$iou.borrower] -= $iou.amount
        $this.Database[$iou.lender].owed_by[$iou.borrower] -= $this.Database[$iou.lender].owes[$iou.borrower]
        $this.Database[$iou.lender].balance += $iou.amount

        $this.ClearRelation($iou.lender, $iou.borrower)

        $this.Database[$iou.borrower].owed_by[$iou.lender] -= $iou.amount
        $this.Database[$iou.borrower].owes[$iou.lender] -= $this.Database[$iou.borrower].owed_by[$iou.lender]
        $this.Database[$iou.borrower].balance -= $iou.amount

        $this.ClearRelation($iou.borrower, $iou.lender)

        return @{"users" = $this.Database.Values | Where-Object {@($iou.lender, $iou.borrower) -contains $_.name} | Sort-Object name }
    }

    [void] hidden ClearRelation ($lender, $borrower) {
        <#
        .DESCRIPTION
        Helper function that will remove user from owes or owed_by if the balance is <= 0
        #>
        if ($this.Database[$lender].owes[$borrower] -le 0) {
            $this.Database[$lender].owes.Remove($borrower)
        }
        if ($this.Database[$lender].owed_by[$borrower] -le 0) {
            $this.Database[$lender].owed_by.Remove($borrower)
        }
    }
}