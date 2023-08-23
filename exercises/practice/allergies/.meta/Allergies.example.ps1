<#
.SYNOPSIS
    Given a person's allergy score, determine whether or not they're allergic to a given item, and their full list of allergies.

.DESCRIPTION
    Given a positive integer to represent the score of a person's allergies, calculate which alleriges they have from the list:
    - eggs (1)
    - peanuts (2)
    - shellfish (4)
    - strawberries (8)
    - tomatoes (16)
    - chocolate (32)
    - pollen (64)
    - cats (128)
    Your task is to write methods that check if the person is allergic to a specific item, and return a list of allergies that they could have.

.EXAMPLE
    $person = [Allergies]::new(34)
    $person.IsAllergicTo("chocolate")   => True
    $person.IsAllergicTo("cats")        => False
    $person.GetAllergies()              => @("peanuts", "chocolate")
#>
Class Allergies {
    [string[]]$allergies

    Allergies([int]$score) {
        $this.allergies = $this.CalculateAllergies($score)
    }

    hidden [string[]] CalculateAllergies([int]$score) {
        $allergens = @('eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats')
        $allergiesList = @()
        for ($i = 0; $i -lt $allergens.Count; $i++) {
            if ($score -shr $i -band 1) {
                $allergiesList += $allergens[$i]
            }
        }
        return $allergiesList
    }

    [string[]] GetAllergies() {
        return $this.allergies
    }

    [bool] IsAllergicTo([string]$agent) {
        return $this.allergies -contains $agent
    }
}