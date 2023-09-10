## Printing Tree
This exercise has some predefined class methods to help printing out the tree in a nice format.
Its main purpose is to help debugging and provide extra clarity.
If you implement the rest of the class correctly it should print out the tree for you.

```powershell
.Example
$tree = [BinarySearchTree]::new(@(50, 76, 1, 34, 89, 44, 25, 6, 26, 100, 13))
$tree.ToString()

Return:
@"
50
├──L:1
│   └──R:34
│       ├──L:25
│       │   ├──L:6
│       │   │   └──R:13    
│       │   └──R:26        
│       └──R:44
└──R:76
    └──R:89
        └──R:100
"@
```