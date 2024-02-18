BeforeAll {
    . "./SimpleLinkedList.ps1"
}

Describe "SimpleLinkedList test cases" {
    Context "Head method" {
        It "singleton list has head with correct value" {
            $list = [LinkedList]::new(1)
            $got  = $list.Head().Data
            $want = 1

            $got | Should -BeExactly $want
        }

        It "multi values list has head with correct value" {
            $list = [LinkedList]::new(@(1, 2, 3))
            $got  = $list.Head().Data
            $want = 3

            $got | Should -BeExactly $want
        }

        It "error trying to access head on empty list" {
            $list = [LinkedList]::new()
            {$list.Head()} | Should -Throw "*The list is empty*"
        }
    }

    Context "Size method" {
        It "empty linked list has size 0" {
            $list = [LinkedList]::new()
            $got  = $list.Size()
            $want = 0
            
            $got | Should -BeExactly $want
        }

        It "linked list size" {
            $list = [LinkedList]::new(@(1, 2, 3, 4, 5))
            $got  = $list.Size()
            $want = 5
            
            $got | Should -BeExactly $want
        }
    }

    Context "Push method" {
        It "can push to empty list" {
            $list = [LinkedList]::new()
            $list.Push(1)
            $got  = $list.Size()
            $want = 1

            $got | Should -BeExactly $want
        }

        It "can push to non empty list change size" {
            $list = [LinkedList]::new(@(1, 2, 3, 4))
            $list.Push(5)
            $got  = $list.Size()
            $want = 5

            $got | Should -BeExactly $want
        }

        It "pushing new value into the list change the head" {
            $list = [LinkedList]::new(@(1, 2, 3))
            $list.Push(4)
            $got  = $list.Head().Data
            $want = 4

            $got | Should -BeExactly $want
        }
    }

    Context "Pop method" {
        It "pop empty list will throw error" {
            $list = [LinkedList]::new()
            {$list.Pop()} | Should -Throw "The list is empty"
        }

        It "pop singleton list will turn it empty" {
            $list = [LinkedList]::new(1)

            $got  = $list.Pop()
            $got | Should -BeExactly 1

            $size  = $list.Size()
            $size | Should -BeExactly 0
        }

        It "pop list with many values follow FILO" {
            $list = [LinkedList]::new()
            $list.Push(1)
            $list.Push(4)
            $list.Pop()  | Should -BeExactly 4
            $list.Push(8)
            $list.Pop()  | Should -BeExactly 8
            $list.Pop()  | Should -BeExactly 1
            $list.Size() | Should -BeExactly 0
        }
    }

    Context "ToArray method" {
        It "empty link list create empty array" {
            $list = [LinkedList]::new()
            $got = $list.ToArray()
            
            $got | Should -BeNullOrEmpty
        }

        It "link list into array" {
            $list = [LinkedList]::new(@(1, 2, 3, 4, 5))
            $got = $list.ToArray()
            
            $got | Should -BeExactly @(5, 4, 3, 2, 1)
        }

        It "correct array after pop and push" {
            $list = [LinkedList]::new(@(1, 2, 3, 4, 5))
            $list.Pop()
            $list.Push(10)
            $got = $list.ToArray()
            
            $got | Should -BeExactly @(10, 4, 3, 2, 1)
        }
    }

    Context "Reverse method" {
        It "reverse empty list is empty" {
            $list = [LinkedList]::new()
            $list.Reverse()
            $got = $list.ToArray()
            
            $got | Should -BeNullOrEmpty
        }

        It "reverse singleton list is same list" {
            $list = [LinkedList]::new(1)
            $list.Reverse()
            $got = $list.ToArray()
            $want = @(1)
            
            $got | Should -BeExactly $want
        }

        It "reverse non empty list" {
            $list = [LinkedList]::new(@(1, 2, 3, 4))
            $list.Reverse()
            $got  = $list.ToArray()
            $want = @(1, 2, 3, 4)
            
            $got | Should -BeExactly $want
        }
    }

    # Extra test implement enumerable/enumerator. Remove skip to run in your local environment
    Context "Enumerable" -Skip {
        It "can call foreach loop on the list" {
            $list = [LinkedList]::new(@(1, 2, 3, 4, 5))
            $got  = $list | ForEach-Object {$_ * 2}
            $want = @(10, 8, 6, 4, 2)

            $got | Should -BeExactly $want
        }

        It "can call where-object on the list" {
            $list = [LinkedList]::new(@(1, 2, 3, 4, 5))
            $got  = $list | Where-Object {$_ % 2 -eq 0}
            $want = @(4, 2)

            $got | Should -BeExactly $want
        }

        It "can call group-object on the list" {
            $list = [LinkedList]::new(@(1, 1, 1, 1, 1))
            $got  = ($list | Group-Object).Count
            $want = 5

            $got | Should -BeExactly $want
        }
    }
}
