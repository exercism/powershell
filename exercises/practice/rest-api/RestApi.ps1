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

    RestAPI( $data) {
        Throw "Please implement this class"
    }

    Get([string] $url, [string] $payload) {
        Throw "Please implement this function"
    }

    Post([string] $url, [string] $payload) {
        Throw "Please implement this function"
    }
}