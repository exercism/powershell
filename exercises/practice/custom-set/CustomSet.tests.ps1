BeforeAll {
    . "./CustomSet.ps1"
}

Describe "custom set test cases" {
    Context "basic methods" {
        It "empty -> sets with no elements are empty" {
            $set = [CustomSet]::new()
            $got = $set.IsEmpty()

            $got | Should -BeTrue
        }

        It "empty -> sets with empty array are empty" {
            $set = [CustomSet]::new(@())
            $got = $set.IsEmpty()

            $got | Should -BeTrue
        }
    
        It "empty -> sets with elements are not empty" {
            $set = [CustomSet]::new(@(1))
            $got = $set.IsEmpty()

            $got | Should -BeFalse

        }
    
        It "contains -> nothing is contained in an empty set" {
            $set = [CustomSet]::new()
            $got = $set.Contains(1)

            $got | Should -BeFalse
        }
    
        It "contains -> when the element is in the set" {
            $set = [CustomSet]::new(@(1))
            $got = $set.Contains(1)

            $got | Should -BeTrue
        }
    
        It "contains -> when the element is not in the set" {
            $set = [CustomSet]::new(@(1, 2, 3))
            $got = $set.Contains(4)

            $got | Should -BeFalse
        }
    }

    Context "relation methods" {
        It "subset -> empty set is a subset of another empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            $got  = $set1.IsSubset($set2)

            $got | Should -BeTrue
        }
    
        It "subset -> empty set is a subset of non-empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(1, 2, 3))
            $got  = $set1.IsSubset($set2)

            $got | Should -BeTrue
        }
    
        It "subset -> non-empty set is not a subset of empty set" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new()
            $got  = $set1.IsSubset($set2)

            $got | Should -BeFalse
        }
    
        It "subset -> set is a subset of set with exact same elements" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(1, 2, 3))
            $got  = $set1.IsSubset($set2)

            $got | Should -BeTrue
        }
    
        It "subset -> set is a subset of larger set with same elements" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(1, 2, 3, 4, 5))
            $got  = $set1.IsSubset($set2)

            $got | Should -BeTrue
        }
    
        It "subset -> set is not a subset of set that does not contain its elements" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(4, 5, 1))
            $got  = $set1.IsSubset($set2)

            $got | Should -BeFalse
        }
    
        It "disjoint -> the empty set is disjoint with itself" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            $got  = $set1.IsDisjoint($set2)

            $got | Should -BeTrue
        }
    
        It "disjoint -> empty set is disjoint with non-empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(1, 2, 3))
            $got  = $set1.IsDisjoint($set2)

            $got | Should -BeTrue
        }
    
        It "disjoint -> non-empty set is disjoint with empty set" {
            $set1 = [CustomSet]::new(@(2, 3, 4))
            $set2 = [CustomSet]::new()
            $got  = $set1.IsDisjoint($set2)

            $got | Should -BeTrue
        }
    
        It "disjoint -> sets are not disjoint if they share an element" {
            $set1 = [CustomSet]::new(@(2, 3, 4))
            $set2 = [CustomSet]::new(@(1, 2, 5))
            $got  = $set1.IsDisjoint($set2)

            $got | Should -BeFalse
        }
    
        It "disjoint -> sets are disjoint if they share no elements" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(4, 5, 6))
            $got  = $set1.IsDisjoint($set2)

            $got | Should -BeTrue
        }

        It "equality -> empty sets are equal" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            $got  = $set1 -eq $set2

            $got | Should -BeTrue
        }
    
        It "equality -> empty set is not equal to non-empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(4, 5, 6))
            $got  = $set1 -eq $set2

            $got | Should -BeFalse
        }
    
        It "equality -> non-empty set is not equal to empty set" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new()
            $got  = $set1 -eq $set2

            $got | Should -BeFalse
        }
    
        It "equality -> sets with the same elements are equal" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(1, 2, 3))
            $got  = $set1 -eq $set2

            $got | Should -BeTrue
        }
    
        It "equality -> sets with different elements are not equal" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(2, 3, 4))
            $got  = $set1 -eq $set2

            $got | Should -BeFalse
        }
    
        It "equality -> set is not equal to larger set with same elements" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(1, 2, 3, 4))
            $got  = $set1 -eq $set2

            $got | Should -BeFalse
        }

        It "equality ->  set is equal to a set constructed from an array with duplicates" {
            $set1 = [CustomSet]::new(@(1))
            $set2 = [CustomSet]::new(@(1, 1))
            $got  = $set1 -eq $set2

            $got | Should -BeTrue
        }
    }

    Context "operation methods" {
        It "add -> add to empty set" {
            $set  = [CustomSet]::new()
            $got  = $set.Add(1)
            $want = [CustomSet]::new(1)

            $got | Should -Be $want
        }
    
        It "add -> add to non-empty set" {
            $set  = [CustomSet]::new(@(1))
            $got  = $set.Add(5)
            $want = [CustomSet]::new(@(1,5))

            $got | Should -Be $want
        }
    
        It "add -> adding an existing element does not change the set" {
            $set  = [CustomSet]::new(@(1, 2, 3))
            $got  = $set.Add(3)
            $want = [CustomSet]::new(@(1, 2, 3))

            $got | Should -Be $want
        }

        It "difference (or complement) -> difference of two empty sets is an empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Difference($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "difference (or complement) -> difference of empty set and non-empty set is an empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(1, 3, 2))
            
            $got  = $set1.Difference($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "difference (or complement) -> difference of a non-empty set and an empty set is the non-empty set" {
            $set1 = [CustomSet]::new(@(1, 3, 4))
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Difference($set2)
            $want = [CustomSet]::new(@(1, 3, 4))

            $got | Should -Be $want
        }
    
        It "difference (or complement) -> difference of two non-empty sets is a set of elements that are only in the first set" {
            $set1 = [CustomSet]::new(@(1, 2, 3))
            $set2 = [CustomSet]::new(@(2, 4))
            
            $got  = $set1.Difference($set2)
            $want = [CustomSet]::new(@(1, 3))

            $got | Should -Be $want
        }

        It "difference (or complement) -> of a set is a set of all elements that are only in the first set removes all duplicates in the first set" {
            $set1 = [CustomSet]::new(@(1, 1))
            $set2 = [CustomSet]::new(@(1))
            
            $got  = $set1.Difference($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "union -> union of empty sets is an empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Union($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "union -> union of an empty set and non-empty set is the non-empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(2, 1))
            
            $got  = $set1.Union($set2)
            $want = [CustomSet]::new(@(2, 1))

            $got | Should -Be $want
        }
    
        It "union -> union of a non-empty set and empty set is the non-empty set" {
            $set1 = [CustomSet]::new(@(3, 5, 7))
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Union($set2)
            $want = [CustomSet]::new(@(3, 5, 7))

            $got | Should -Be $want
        }
    
        It "union -> union of non-empty sets contains all unique elements" {
            $set1 = [CustomSet]::new(@(3, 5, 7))
            $set2 = [CustomSet]::new(@(1, 3, 5, 8))
            
            $got  = $set1.Union($set2)
            $want = [CustomSet]::new(@(3, 5, 7, 1, 8))
            
            $got | Should -Be $want
        }

        It "intersection -> intersection of two empty sets is an empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Intersection($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "intersection -> intersection of an empty set and non-empty set is an empty set" {
            $set1 = [CustomSet]::new()
            $set2 = [CustomSet]::new(@(1, 3, 5))
            
            $got  = $set1.Intersection($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "intersection -> intersection of a non-empty set and an empty set is an empty set" {
            $set1 = [CustomSet]::new(@(2, 4, 5))
            $set2 = [CustomSet]::new()
            
            $got  = $set1.Intersection($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "intersection -> intersection of two sets with no shared elements is an empty set" {
            $set1 = [CustomSet]::new(@(2, 4, 5))
            $set2 = [CustomSet]::new(@(1, 3, 7))

            $got  = $set1.Intersection($set2)
            $want = [CustomSet]::new()

            $got | Should -Be $want
        }
    
        It "intersection -> intersection of two sets with shared elements is a set of the shared elements" {
            $set1 = [CustomSet]::new(@(2, 4, 5, 8, 9))
            $set2 = [CustomSet]::new(@(1, 8, 4, 6, 5))
            
            $got  = $set1.Intersection($set2)
            $want = [CustomSet]::new(@(4, 8, 5))

            $got | Should -Be $want
        }
    }

    Context "chaining methods test" {
        It "chaining different methods" {
            $set1 = [CustomSet]::new(1..10)
            $set2 = [CustomSet]::new(5..15)
            
            $got  = $set1.Intersection($set2).Add(1).Union($set2).Difference($set2)
            $want = [CustomSet]::new(@(1))

            $got | Should -Be $want
        }
    }
}

