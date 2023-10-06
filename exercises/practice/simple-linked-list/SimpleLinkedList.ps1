<#
.SYNOPSIS
    Implement simple linked list (singly linked list) data structure.

.DESCRIPTION
    Implement two classes: Node and LinkedList
    Node should have these properties:
        - Data, contain the value of the node
        - Next, contain the reference to the next linked Node
    
    LinkedList's constrcutor should be able to accept : zero value, one single value, and an array of values to create the linked list.
    LinkedList should have these methods:
        - Size: returns how many elements in the list
        - Head: returns the current Node that is currently the head of the list.
        - Push: add a new Node to the beginning of the list.
        - Pop : remove a Node from the beginning of the list, returns the value of that Node.
        - Reverse : reverse the order of the list
        - ToArray : returns an array of the list in the correct order.

    Extra: implement enumberable behavior, e.g. can call Foreach-Object on the list. Remove the skipped test to run, only for local environment.

.EXAMPLE
    $list = [LinkedList]::new(@(1, 2, 3))

    $list.Pop()
    Returns: 3

    $list.Push(4)
    $list.ToArray()
    Returns: @(4, 2, 1)
#>
Class Node {
    Node() {
        Throw "Please implement this class"
    }
}

Class LinkedList {
    LinkedList() {
        Throw "Please implement this class"
    }

    Size() {
        Throw "Please implement this function"
    }

    Head() {
        Throw "Please implement this function"
    }

    Push() {
        Throw "Please implement this function"
    }

    Pop() {
        Throw "Please implement this function"
    }

    Reverse() {
        Throw "Please implement this function"
    }

    ToArray() {
        Throw "Please implement this function"
    }
}