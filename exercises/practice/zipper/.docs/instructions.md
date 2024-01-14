# Instructions

Creating a zipper for a binary tree.

[Zippers][zipper] are a purely functional way of navigating within a data structure and manipulating it.
They essentially contain a data structure and a pointer into that data structure (called the focus).

For example given a binary tree (a node contains a value and a its children nodes) a zipper might support these operations:

- `FromTree` (get a zipper out of a binary tree, the focus is on the root node)
- `ToTree` (get the binary tree out of the zipper)
- `Value` (get the value of the focus node)
- `GoLeft` (move the focus to the left child node, returns a new zipper)
- `GoRight` (move the focus to the right child node, returns a new zipper)
- `GoUp` (move the focus to the parent, returns a new zipper)
- `SetValue` (set the value of the focus node, returns a new zipper)
- `SetLeft` (insert a new subtree before the focus node, it
  becomes the `Left` of the focus node, returns a new zipper)
- `SetRight` (insert a new subtree after the focus node, it becomes
  the `Right` of the focus node, returns a new zipper)
- `Delete` (removes the focus node and all subtrees, focus moves to the
  `Right` node if possible otherwise to the `Left` node if possible,
  otherwise to the parent node, returns a new zipper) (*This operation is optional)

[zipper]: https://en.wikipedia.org/wiki/Zipper_%28data_structure%29
