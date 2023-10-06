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
    [object]$Data
    [Node]$Next

    Node([object]$value, [Node]$ref=$null) {
        $this.Data = $value
        $this.Next = $ref
    }
}

Class LinkedList : System.Collections.IEnumerator{
    [Node] hidden $_Head
    [int] hidden $_Count
    [Node] hidden $_Current

    # Constructors
    LinkedList() {
        $this._Head  = $null
        $this._Count = 0
    }

    LinkedList([object]$value) {
        $this._Head  = $null
        $this._Count = 0
        $this.Push($value)
    }
    
    LinkedList([object[]]$values) {
        $this._Head  = $null
        $this._Count = 0
        $this._Current = $null
        foreach ($value in $values) {
            $this.Push($value)
        }
    }

    # Standards methods
    [int] Size() {
        return $this._Count
    }

    [Node] Head() {
        if ($null -eq $this._Head) {Throw "The list is empty"}
        return $this._Head
    }

    [void] Push($value) {
        $this._Head = [Node]::new($value, $this._Head)
        $this._Count++
    }

    [object] Pop() {
        if ($null -eq $this._Head) {Throw "The list is empty"}
        $value = $this._Head.Data
        $this._Head = $this._Head.Next
        $this._Count--
        return $value
    }

    [void] Reverse() {
        $current = $this._Head
        $previous = $null
        $next = $null

        while ($current) {
            $next = $current.Next
            $current.Next = $previous
            $previous = $current
            $current = $next
        }
        $this._Head = $previous
    }

    [object[]]ToArray() {
        $array = @()

        $node = $this._Head
        while ($node) {
            $array += $node.Data
            $node = $node.Next
        }
        return $array
    }

    # Enumerator methods
    [object] get_Current() {
        return $this._Current.Data
    }

    [bool] MoveNext() {
        if ($null -eq $this._Current) {
            $this._Current = $this._Head
        }else {
            $this._Current = $this._Current.Next
        }
        return $this._Current
    }

    [void] Reset() {
        $this._Current = $null
    }
}