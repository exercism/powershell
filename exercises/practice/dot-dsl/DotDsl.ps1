<#
.SYNOPSIS
    Write a Domain Specific Language similar to the Graphviz dot language.

.DESCRIPTION
    Implement the classes to stimulate a DSL similar to the Graphviz dot language.

    Node class : represent the nodes inside the graph.
    Edge class : represent the relationship between two nodes.
    Attr class : represent the attributes of other objects (node, edge or graph).
    Graph class: represent the graph, contains info about nodes, edges and attributes.

    Node, Edge and Attr should have the 'Equals' method implemented for the purpose of comparison in the test suite.
#>

Class Node {
    Node(){
        Throw "Please implement this class"
    }

    [bool] Equals() {
        Throw "Please implement this fucntion"
    }
}

Class Edge {
    Edge(){
        Throw "Please implement this class"
    }

    [bool] Equals() {
        Throw "Please implement this fucntion"
    }
}

Class Attr {
    Attr() {
        Throw "Please implement this class"
    }

    [bool] Equals() {
        Throw "Please implement this fucntion"
    }
}

Class Graph {
    [Node[]] $Nodes
    [Edge[]] $Edges
    [Attr[]] $Attrs

    Graph($data){
        Throw "Please implement this class"
    }
}


