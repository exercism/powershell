<#
.SYNOPSIS
    Implement an evaluator for a very simple subset of Forth.

.DESCRIPTION
    Forth is a stack-based programming language.

    Implement a very basic evaluator for a small subset of Forth.
    Your evaluator has to support the following words:

    - '+', '-', '*', '/' (integer arithmetic)
    - 'DUP', 'DROP', 'SWAP', 'OVER' (stack manipulation)

    Your evaluator also has to support defining new words using the customary syntax: ': word-name definition ;'.

    To keep things simple the only data type you need to support is signed integers of at least 16 bits size.

    You should use the following rules for the syntax: a number is a sequence of one or more (ASCII) digits, a word is a sequence of one or more letters, digits, symbols or punctuation that is not a number.
    (Forth probably uses slightly different rules, but this is close enough.)

    Words are case-insensitive.

    Your class should have these two methods: Evaluate to evaluate the inputs, and GetStack to retrieve the current state of the stack.
    
.EXAMPLE
    $forth = [Forth]::new()
    $forth.Evaluate(@(": BIG 1000 ;", "BIG 500 + 100 swap dup"))
    $forth.GetStack()
    Returns: @(100, 1500, 100)

    First define BIG as 1000.
    Add 1000 to the stack, then 500. Do the addition (+) of those two to get 1500
    100 is now being added to the stack, then we swap 1500 and 100
    After the swap 1500 is now on top, then we call dup and create another 1500
    So the final stack is [100, 1500, 1500]
#>

Class Forth {
    [string] hidden $customPattern
    [hashtable] hidden $operators
    [System.Collections.Stack] hidden $resultStack

    Forth() {
        $this.resultStack = New-Object System.Collections.Stack
        $this.customPattern = "^: (\w+-?\w+|[*+/-]) ((\w+-?\w+ |-?\d+ |[*+/-] )+)+;$"
        $this.operators = @{
            "+"     = $this.Addition
            "-"     = $this.Subtraction
            "*"     = $this.Multiplication
            "/"     = $this.Division
            "dup"   = $this.Dup
            "drop"  = $this.Drop
            "swap"  = $this.Swap
            "over"  = $this.Over
        }
    }

    [void] Evaluate([string[]]$inputs) {
        $inputStack = $this.ProcessInput($inputs)

        while ($inputStack.Count) {
            $current = $inputStack.Pop()
            if ($current -is [int] ) {
                $this.resultStack.Push($current)
            }else {
                if ($this.resultStack.Count -eq 0) {
                    Throw "Stack is empty"
                }
                $current.Invoke($this.resultStack)
            }
        }
    }

    [object[]] GetStack() {
        return ([array]$this.resultStack)[($this.resultStack.Count-1)..0]
    }

    [System.Collections.Stack] hidden ProcessInput([string[]]$inputs) {
        <#
        .DESCRIPTION
        Process the inputs into a stack to be evaluated.
        #>
        $stack = @()
        foreach ($input in $inputs) {
            if ($input -match "^:.*;$") {
                $this.ProcessCustomWord($input)
            }else {
                $stack += $this.Parse($input)
            }
        }
        return $stack[($stack.Count-1)..0]
    }

    [object] hidden Parse([string]$expression) {
        <#
        .DESCRIPTION
        Parsing function. Check if a string is a digit or an operator, or undefined.
        #>
        $tokens = -split $expression.ToLower() | ForEach-Object {
            if ($_ -match "^-?\d+$") {
                [Int]$_
            }elseif ($this.operators.ContainsKey($_)) {
                $this.operators[$_]
            }else {
                Throw "Undefined operation"
            }
        }
        return $tokens
    }

    [void] hidden ProcessCustomWord([string]$word) {
        <#
        .DESCRIPTION
        Method to handle custom word. If it match the format pattern, then it extract the word and parse the definition.
        Then add them into the hashtable of words.
        #>
        if ($word -match $this.customPattern) {
            $customWord  = $Matches[1].ToLower()
            $definitions = $this.Parse($Matches[2])
            $this.operators[$customWord] = $definitions
        }else {
            Throw "Illegal operation"
        }
    }

    #operators
    [void] hidden Swap($stack) {
        $this.ValidateStack($stack, 2)
        $second, $first = $stack.Pop(), $stack.Pop()
        $stack.Push($second)
        $stack.Push($first)
    }

    [void] hidden Dup($stack) {
        $stack.Push($stack.Peek())
    }

    [void] hidden Over($stack) {
        $this.ValidateStack($stack, 2)
        $top = $stack.Pop()
        $belowTop = $stack.Peek()
        $stack.Push($top)
        $stack.Push($belowTop)
    }

    [void] hidden Drop($stack) {
        $stack.Pop()
    }

    [void] hidden Addition($stack) {
        $this.ValidateStack($stack, 2)
        $second, $first = $stack.Pop(), $stack.Pop()
        $stack.Push($first + $second)
    }

    [void] hidden Subtraction($stack) {
        $this.ValidateStack($stack, 2)
        $second, $first = $stack.Pop(), $stack.Pop()
        $stack.Push($first - $second)
    }

    [void] hidden Multiplication($stack) {
        $this.ValidateStack($stack, 2)
        $second, $first = $stack.Pop(), $stack.Pop()
        $stack.Push($first * $second)
    }

    [void] hidden Division($stack) {
        $this.ValidateStack($stack, 2)
        $second, $first = $stack.Pop(), $stack.Pop()
        if ($second -eq 0) {Throw "Can't divided by 0"}
        $stack.Push([Math]::Floor($first / $second))
    }

    [void] hidden ValidateStack($stack, $count) {
        if ($stack.Count -lt $count) {
            Throw "Not enough items in stack to perform operation"
        }
    }
}