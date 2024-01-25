<#
.SYNOPSIS
    Implement a linked list.

.DESCRIPTION
    The linked list is a fundamental data structure in computer science, often used in the implementation of other data structures.
    As the name suggests, it is a list of nodes that are linked together.
    In a 'doubly linked list', each node links to both the node that comes before, as well as the node that comes after.

    The class to represent the linked list should support these operations:
    - Push    : accept a value, append it to the end of the list.
    - Pop     : remove a value of the end of the list, return it.
    - Unshift : accept a value, append it to the front of the list.
    - Shift   : remove a value from the front of the list, return it.
    - Delete  : accept a value, remove the first occurence of it in the list.

    The class should also have a 'Count' property to reflect the current length of the list.
    Any attempt of removal operation on an empty list should throw an error.

.EXAMPLE
    $linked = [LinkedList]::new()

    $linked.Push(5)
    $linked.Unshift(7)
    $linked.Push(8)

    $linked.Pop()
    Returns: 8

    $linked.Count
    Returns: 2
#>
class Node {
    Node() {
        #This class is here as a suggestion, feel free to edit it however you want
    }
}

class LinkedList {
    [int] $Count

    LinkedList() {
        Throw "Please implement this class"
    }

    Push($value) {
        Throw "Please implement this function"
    }

    Pop() {
        Throw "Please implement this function"
    }

    Unshift($value) {
        Throw "Please implement this function"
    }

    Shift() {
        Throw "Please implement this function"
    }

    Delete($value) {
        Throw "Please implement this function"
    }
}