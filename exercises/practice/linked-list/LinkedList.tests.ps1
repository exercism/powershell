BeforeAll {
    . "./LinkedList.ps1"
}

Describe "LinkedList test cases" {
    Context "Valid operation" {
        BeforeEach {
            $list = [LinkedList]::new()
        }
    
        It "pop gets element from the list" {
            $list.Push(7)
            $list.Pop() | Should -BeExactly 7
        }
    
        It "push/pop respectively add/remove at the end of the list" {
            $list.Push(11)
            $list.Push(13)
            $list.Pop() | Should -BeExactly 13
            $list.Pop() | Should -BeExactly 11
        }
    
        It "shift gets an element from the list" {
            $list.Push(17)
            $list.Shift() | Should -BeExactly 17
        }
    
        It "shift gets first element from the list" {
            $list.Push(23)
            $list.Push(5)
            $list.Shift() | Should -BeExactly 23
            $list.Shift() | Should -BeExactly 5
        }
    
        It "unshift adds element at start of the list" {
            $list.Unshift(23)
            $list.Unshift(5)
            $list.Shift() | Should -BeExactly 5
            $list.Shift() | Should -BeExactly 23
        }
    
        It "pop, push, shift, and unshift can be used in any order" {
            $list.Push(1)
            $list.Push(2)
            $list.Pop()   | Should -BeExactly 2
            $list.Push(3)
            $list.Shift() | Should -BeExactly 1
            $list.Unshift(4)
            $list.Push(5)
            $list.Shift() | Should -BeExactly 4
            $list.Pop()   | Should -BeExactly 5
            $list.Shift() | Should -BeExactly 3
        }
    
        It "count an empty list" {
            $list.Count | Should -BeExactly 0
        }
    
        It "count a list with items" {
            $list.Push(37)
            $list.Push(1)
            $list.Count | Should -BeExactly 2
        }
    
        It "count is correct after mutation" {
            $list.Push(31)
            $list.Count | Should -BeExactly 1
            $list.Unshift(43)
            $list.Count | Should -BeExactly 2
            $list.Shift()
            $list.Count | Should -BeExactly 1
            $list.Pop()
            $list.Count | Should -BeExactly 0
        }
    
        It "popping to empty doesn't break the list" {
            $list.Push(41)
            $list.Push(59)
            $list.Pop()
            $list.Pop()
            $list.Push(47)
            $list.Count | Should -BeExactly 1
            $list.Pop() | Should -BeExactly 47
        }
    
        It "shifting to empty doesn't break the list" {
            $list.Push(41)
            $list.Push(59)
            $list.Shift()
            $list.Shift()
            $list.Push(47)
            $list.Count | Should -BeExactly 1
            $list.Shift() | Should -BeExactly 47
        }
    
        It "deletes the only element" {
            $list.Push(61)
            $list.Delete(61)
            $list.Count | Should -BeExactly 0
        }
    
        It "deletes the element with the specified value from the list" {
            $list.Push(71)
            $list.Push(83)
            $list.Push(79)
            $list.Delete(83)
            $list.Count | Should -BeExactly 2
            $list.Pop() | Should -BeExactly 79
            $list.Shift() | Should -BeExactly 71
    
        }
    
        It "deletes the element with the specified value from the list, re-assigns tail" {
            $list.Push(71)
            $list.Push(83)
            $list.Push(79)
            $list.Delete(83)
            $list.Count | Should -BeExactly 2
            $list.Pop() | Should -BeExactly 79
            $list.Pop() | Should -BeExactly 71
        }
    
        It "deletes the element with the specified value from the list, re-assigns head" {
            $list.Push(71)
            $list.Push(83)
            $list.Push(79)
            $list.Delete(83)
            $list.Count | Should -BeExactly 2
            $list.Shift() | Should -BeExactly 71
            $list.Shift() | Should -BeExactly 79
        }
    
        It "deletes the first of two elements" {
            $list.Push(97)
            $list.Push(101)
            $list.Delete(97)
            $list.Count | Should -BeExactly 1
            $list.Pop() | Should -BeExactly 101
        }
    
        It "deletes the second of two elements" {
            $list.Push(97)
            $list.Push(101)
            $list.Delete(101)
            $list.Count | Should -BeExactly 1
            $list.Pop() | Should -BeExactly 97
        }
    
        It "delete does not modify the list if the element is not found" {
            $list.Push(89)
            $list.Delete(103)
            $list.Count | Should -BeExactly 1
        }
    
        It "deletes only the first occurrence" {
            $list.Push(73)
            $list.Push(9)
            $list.Push(9)
            $list.Push(107)
            $list.Delete(9)
            $list.Count | Should -BeExactly 3
            $list.Pop() | Should -BeExactly 107
            $list.Pop() | Should -BeExactly 9
            $list.Pop() | Should -BeExactly 73
        }
    }

    # Addition tests adapted from Python track
    Context "invalid operation" {
        BeforeEach {
            $list = [LinkedList]::new()
        }

        It "pop empty list raise error" {
            { $list.Pop() } | Should -Throw "*List is empty*" 
        }

        It "can return with pop and then raise error if empty" {
            $list.Push(1)
            $list.Unshift(5)
            $list.Pop() | Should -BeExactly 1
            $list.Pop() | Should -BeExactly 5

            { $list.Pop() } | Should -Throw "*List is empty*" 
        }

        It "shift empty list raise error" {
            { $list.Shift() } | Should -Throw "*List is empty*" 
        }

        It "can return with shift and then raise error if empty" {
            $list.Push(1)
            $list.Unshift(5)
            $list.Pop()   | Should -BeExactly 1
            $list.Shift() | Should -BeExactly 5

            { $list.Shift() } | Should -Throw "*List is empty*" 
        }

        It "delete empty list raise error" {
            { $list.Delete(0) } | Should -Throw "*List is empty*" 
        }
    }
}
