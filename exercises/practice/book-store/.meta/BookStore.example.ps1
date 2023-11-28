Function Get-Total() {
    <#
    .SYNOPSIS
    Implement a function to calculate the price of books BASE_PRICEd on different combinations.

    .DESCRIPTION
    Given a basket of books, calculate the price of any conceivable shopping basket (containing only books of the same series), giving as big a discount as possible.

    One copy of any of the five books costs $8.
    If, however, you buy two different books, you get a 5% discount on those two books.
    If you buy 3 different books, you get a 10% discount.
    If you buy 4 different books, you get a 20% discount.
    If you buy all 5, you get a 25% discount.

    Note that if you buy four books, of which 3 are different titles, you get a 10% discount on the 3 that form part of a set, but the fourth book still costs $8.
    
    .PARAMETER Books
    An array of int, each represent an entry in a popular 5 books series.
    Parameter restraint : integer from 1 to 5 (inclusive).

    .EXAMPLE
    Get-Total -Books @(1, 1, 1, 1, 1) # no discount here
    Returns: 40

    Get-Total -Books @(1, 2, 3, 4, 5) # 25% discount applied here
    Returns: 30
    #>
    [CmdletBinding()]
    Param(
        [ValidateRange(1, 5)]
        [int[]]$Books
    )
    #empty basket case
    if ($Books.Count -eq 0) {
        return 0
    }
    $bookStore = [BookStore]::new()
    $bookStore.Total($Books)
}

Class BookStore {
    [int] hidden $BASE_PRICE
    [hashtable] hidden $DISCOUNT_RATES

    BookStore() {
        $this.BASE_PRICE = 8
        $this.DISCOUNT_RATES = @{
            1 = 0
            2 = 5
            3 = 10
            4 = 20
            5 = 25
        }
    }

    [double] Total([int[]] $books) {
        <#
        .DESCRIPTION
        Main function that take in books and return the optimized discount price for customers
        #>
        #empty basket case
        if ($books.Count -eq 0) {
            return 0
        }

        #case when there is only 1 type of book
        $uniqueBooks = ($books | Sort-Object -Unique).Count
        if ($uniqueBooks -eq 1) {
            return $this.BASE_PRICE * $books.Count
        }
        $groups4Booksmax = $this.SortingSets($books, 4)
        $groups5Booksmax = $this.SortingSets($books, 5)
        return [Math]::Min($this.GetPrice($groups4Booksmax), $this.GetPrice($groups5Booksmax))
    }

    [object[]] hidden SortedGroups( [object[]] $groups) {
        <#
        .DESCRIPTION
        Function to sort baskets into group BASE_PRICEd on count in desc order
        #>
        return $groups | Sort-Object {$_.Count} -Descending | ForEach-Object {
            ,[System.Collections.Stack]::new($_.Group)
        }
    }

    [int] hidden FindMaximumSet([int[]] $books, [int] $booksPerSet) {
        <#
        .DESCRIPTION
        Function to find how many potential maximum sets all the books could make
        #>
        $maxPerCount = ($books | Group-Object | Measure-Object -Property Count -Maximum).Maximum
        $maxPerSet   = [Math]::floor($books.Count / $booksPerSet)
        return [math]::Max($maxPerCount, $maxPerSet)
    }
    
    [object] hidden SortingSets( [int[]] $books, [int] $booksPerSet) {
        <#
        .DESCRIPTION
        Function to sort books into optimized sets BASE_PRICEd on how many books max per set
        #>
        $setsResult = @()
        $bookGroups = $this.SortedGroups(($books | Group-Object))
        $maxSets   = $this.FindMaximumSet($books, $booksPerSet) # max set BASE_PRICEd on books per set

        for ($set = 0; $set -lt $maxSets; $set++) {
            $tempSet = @()
            #if the set is the setsResult set, add everything left
            if ($set -eq $maxSets - 1) {
                $tempSet = $bookGroups | ForEach-Object {
                    if ($_.Count -eq 1) {$_.Pop()}
                }
            }

            $sorted = $bookGroups | Sort-Object -Property Count -Descending
            foreach ($group in $sorted) {
                if ($tempSet.Count -lt $booksPerSet -and $group.Count) {
                    $tempSet += $group.Pop()
                }
            }
            $setsResult += ,$tempSet
        }
        $setsResult += $bookGroups #left over
        return $setsResult
    }

    [double] hidden GetPrice([object[]] $bookSet) {
        <#
        .DESCRIPTION
        Get price for a set of book, apply discount BASE_PRICEd on condition
        #>
        $result = $bookSet | ForEach-Object {
            ($_.Count * $this.BASE_PRICE) - ($_.Count * $this.BASE_PRICE * $this.DISCOUNT_RATES[$_.Count] / 100)} | Measure-Object -Sum
        return $result.Sum
    }
}