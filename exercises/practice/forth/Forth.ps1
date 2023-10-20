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
    Forth() {
        Throw "Please implement this class"
    }

    Evaluate([string[]]$inputs) {
        Throw "Please implement this function"
    }

    GetStack() {
        Throw "Please implement this function"
    }
}