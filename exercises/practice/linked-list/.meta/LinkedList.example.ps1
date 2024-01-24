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
    [Object] $Value
    [Node] $Prev = $null
    [Node] $Next = $null

    Node($value) {
        $this.Value = $value
    }

    Node($value, $succeeding, $previous) {
        $this.Value = $value
        $this.Next  = $succeeding
        $this.Prev  = $previous
    }
}

class LinkedList {
    [int]  $Count
    [Node] $Head
    [Node] $Tail

    LinkedList() {
        $this.Count = 0
        $this.Head  = $null
        $this.Tail  = $null
    }

    #Append to the end
    [void] Push([object] $value) {
        $newNode = [Node]::new($value)
        if ($null -eq $this.Tail) {
            $this.Head = $this.Tail = $newNode
        }else {
            $newNode.Prev = $this.Tail
            $this.Tail.Next = $newNode
            $this.Tail = $newNode
        }
        $this.Count++
    }

    #Remove from the end
    [object] Pop() {
        if ($null -eq $this.Tail) {Throw "List is empty."}
        $data = $this.Tail.Value
        if ($this.Count -eq 1) {
            $this.Head = $this.Tail = $null
        }else {
            $this.Tail = $this.Tail.Prev
            $this.Tail.Next = $null
        }
        $this.Count--
        return $data
    }

    #Append to the front
    [void] Unshift([object] $value) {
        $newNode = [Node]::new($value)
        if ($null -eq $this.Head) {
            $this.Head = $this.Tail = $newNode
        }else {
            $this.Head.Prev = $newNode
            $newNode.Next = $this.Head
            $this.Head = $newNode
        }
        $this.Count++
    }

    #Remove from the front
    [object] Shift() {
        if ($null -eq $this.Head) {Throw "List is empty."}
        $data = $this.Head.Value
        if ($this.Count -eq 1) {
            $this.Head = $this.Tail = $null
        }else {
            $this.Head = $this.Head.Next
            $this.Head.Prev = $null
        }
        $this.Count--
        return $data
    }

    #Delete first encounted value in the list
    [void] Delete($value) {
        if ($null -eq $this.Head) {Throw "List is empty."}
        $curr = $this.Head
        while ($curr) {
            if ($curr.Value -eq $value) {
                if ($this.Count -eq 1) {
                    $this.Head = $this.Tail = $null
                } elseif ($null -eq $curr.Prev) { #node is head
                    $this.Head = $curr.Next
                    $this.Head.Prev = $null
                } elseif ($null -eq $curr.Next)  { #node is tail
                    $this.Tail = $curr.Prev
                    $this.Tail.Next = $null
                } else {
                    $curr.Next.Prev = $curr.Prev
                    $curr.Prev.Next = $curr.Next
                }
                $this.Count--
                break
            }
            $curr = $curr.Next
        }
    }
}