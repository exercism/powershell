BeforeAll {
    . "./Forth.ps1"
}

Describe "Forth test cases" {
    BeforeEach {
        $forth = [Forth]::new()
    }

    Context "parsing and numbers" {
        It "numbers just get pushed onto the stack" {
            $forth.Evaluate(@("1 2 3 4 5"))
            $forth.GetStack() | Should -Be @(1, 2, 3, 4, 5)
        }
    
        It "pushes negative numbers onto the stack" {
            $forth.Evaluate(@("-1 -2 -3 -4 -5"))
            $forth.GetStack() | Should -Be @(-1, -2, -3, -4, -5)
        }
    }
    
    Context "arithmetic operations" {
        It "addition -> can add two numbers" {
            $forth.Evaluate(@("1 2 +"))
            $forth.GetStack() | Should -Be @(3)
        }
    
        It "addition -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("+"))} | Should -Throw "*Stack is empty*"
        }
    
        It "addition -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 +"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    
        It "subtraction -> can subtract two numbers" {
            $forth.Evaluate(@("3 4 -"))
            $forth.GetStack() | Should -Be @(-1)
        }
    
        It "subtraction -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("-"))} | Should -Throw "*Stack is empty*"
        }
    
        It "subtraction -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 -"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    
        It "multiplication -> can multiply two numbers" {
            $forth.Evaluate(@("2 4 *"))
            $forth.GetStack() | Should -Be @(8)
        }
    
        It "multiplication -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("*"))} | Should -Throw "*Stack is empty*"
        }
    
        It "multiplication -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 *"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    
        It "division -> can divide two numbers" {
            $forth.Evaluate(@("12 3 /"))
            $forth.GetStack() | Should -Be @(4)
        }
    
        It "division -> performs integer division" {
            $forth.Evaluate(@("8 3 /"))
            $forth.GetStack() | Should -Be @(2)
        }
    
        It "division -> errors if dividing by zero" {
            {$forth.Evaluate(@("4 0 /"))} | Should -Throw "*Can't divided by 0*"
        }
    
        It "division -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("/"))} | Should -Throw "*Stack is empty*"
        }
    
        It "division -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 /"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    
        It "combined arithmetic -> addition and subtraction" {
            $forth.Evaluate(@("1 2 + 4 -"))
            $forth.GetStack() | Should -Be @(-1)
        }
    
        It "combined arithmetic -> multiplication and division" {
            $forth.Evaluate(@("2 4 * 3 /"))
            $forth.GetStack() | Should -Be @(2)
        }
    }
    
    Context "stack manipulation operations" {
        It "dup -> copies a value on the stack" {
            $forth.Evaluate(@("1 dup"))
            $forth.GetStack() | Should -Be @(1, 1)
        }
    
        It "dup -> copies the top value on the stack" {
            $forth.Evaluate(@("1 2 dup"))
            $forth.GetStack() | Should -Be @(1, 2, 2)
        }
    
        It "dup -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("dup"))} | Should -Throw "*Stack is empty*"
        }
    
        It "drop -> removes the top value on the stack if it is the only one" {
            $forth.Evaluate(@("1 drop"))
            $forth.GetStack() | Should -BeNullOrEmpty
        }
    
        It "drop -> removes the top value on the stack if it is not the only one" {
            $forth.Evaluate(@("1 2 drop"))
            $forth.GetStack() | Should -Be @(1)
        }
    
        It "drop -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("drop"))} | Should -Throw "*Stack is empty*"
        }
    
        It "swap -> swaps the top two values on the stack if they are the only ones" {
            $forth.Evaluate(@("1 2 swap"))
            $forth.GetStack() | Should -Be @(2, 1)
        }
    
        It "swap -> swaps the top two values on the stack if they are not the only ones" {
            $forth.Evaluate(@("1 2 3 swap"))
            $forth.GetStack() | Should -Be @(1, 3, 2)
        }
    
        It "swap -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("swap"))} | Should -Throw "*Stack is empty*"
        }
    
        It "swap -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 swap"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    
        It "over -> copies the second element if there are only two" {
            $forth.Evaluate(@("1 2 over"))
            $forth.GetStack() | Should -Be @(1, 2, 1)
        }
    
        It "over -> copies the second element if there are more than two" {
            $forth.Evaluate(@("1 2 3 over"))
            $forth.GetStack() | Should -Be @(1, 2, 3, 2)
        }
    
        It "over -> errors if there is nothing on the stack" {
            {$forth.Evaluate(@("over"))} | Should -Throw "*Stack is empty*"
        }
    
        It "over -> errors if there is only one value on the stack" {
            {$forth.Evaluate(@("1 over"))} | Should -Throw "*Not enough items in stack to perform operation*"
        }
    }
    
    Context "user-defined words" {
        It "can consist of built-in words" {
            $forth.Evaluate(@(": dup-twice dup dup ;", "1 dup-twice"))
            $forth.GetStack() | Should -Be @(1, 1, 1)
        }
    
        It "execute in the right order" {
            $forth.Evaluate(@(": countup 1 2 3 ;", "countup"))
            $forth.GetStack() | Should -Be @(1, 2, 3)
        }
    
        It "can override other user-defined words" {
            $forth.Evaluate(@(": foo dup ;", ": foo dup dup ;", "1 foo"))
            $forth.GetStack() | Should -Be @(1, 1, 1)
        }
    
        It "can override built-in words" {
            $forth.Evaluate(@(": swap dup ;", "1 swap"))
            $forth.GetStack() | Should -Be @(1, 1)
        }
    
        It "can override built-in operators" {
            $forth.Evaluate(@(": + * ;", "3 4 +"))
            $forth.GetStack() | Should -Be @(12)
        }
    
        It "can use different words with the same name" {
            $forth.Evaluate(@(": foo 5 ;", ": bar foo ;", ": foo 6 ;", "bar foo"))
            $forth.GetStack() | Should -Be @(5, 6)
        }
    
        It "can define word that uses word with the same name" {
            $forth.Evaluate(@(": foo 10 ;", ": foo foo 1 + ;", "foo"))
            $forth.GetStack() | Should -Be @(11)
        }
    
        It "cannot redefine non-negative numbers" {
            {$forth.Evaluate(@(": 1 2 ;"))} | Should -Throw "*Illegal operation*"
        }
    
        It "cannot redefine negative numbers" {
            {$forth.Evaluate(@(": -1 2 ;"))} | Should -Throw "*Illegal operation*"
        }
    
        It "errors if executing a non-existent word" {
            {$forth.Evaluate(@("foo"))} | Should -Throw "*Undefined operation*"
        }
    
        It "only defines locally" {
            $forth1 = [Forth]::new()
            $forth2 = [Forth]::new()
    
            $forth1.Evaluate(@(": + - ;", "1 1 +"))
            $forth1.GetStack() | Should -Be @(0)
    
            $forth2.Evaluate(@("1 1 +"))
            $forth2.GetStack() | Should -Be @(2)
        }
    }
    
    Context "case-insensitivity" {
        It "DUP is case-insensitive" {
            $forth.Evaluate(@("1 DUP Dup dup"))
            $forth.GetStack() | Should -Be @(1, 1, 1, 1)
        }
    
        It "DROP is case-insensitive" {
            $forth.Evaluate(@("1 2 3 4 DROP Drop drop"))
            $forth.GetStack() | Should -Be @(1)
        }
    
        It "SWAP is case-insensitive" {
            $forth.Evaluate(@("1 2 SWAP 3 Swap 4 swap"))
            $forth.GetStack() | Should -Be @(2, 3, 4, 1)
        }
    
        It "OVER is case-insensitive" {
            $forth.Evaluate(@("1 2 OVER Over over"))
            $forth.GetStack() | Should -Be @(1, 2, 1, 2, 1)
        }
    
        It "user-defined words are case-insensitive" {
            $forth.Evaluate(@(": foo dup ;", "1 FOO Foo foo"))
            $forth.GetStack() | Should -Be @(1, 1, 1, 1)
        }
    
        It "definitions are case-insensitive" {
            $forth.Evaluate(@(": SWAP DUP Dup dup ;", "1 swap"))
            $forth.GetStack() | Should -Be @(1, 1, 1, 1)
        }
    }
}
