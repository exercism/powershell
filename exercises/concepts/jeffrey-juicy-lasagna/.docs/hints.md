# Hints

## General
- A variable [type][types] are based on the value of that variables: *10* as `Int` , *'Hello'* as `String`, or *2.0* as `double`.

## 1. Define constant expected bake time in minutes

- You need to define a constant variable, and assign it an integer value.
- Constant can be defined through [New-Variable cmdlet][new variable].

## 2. Calculate remaining bake time in minutes

- You need to define a [function][defining functions] with a single parameter.
- Use the [mathematical operator for subtraction][arithmetic] to subtract values.
- This function should [return a value][return].

## 3. Calculate preparation time in minutes

- You need to define a [function][defining functions] with a single parameter.
- Use the [mathematical operator for multiplication][arithmetic] to multiply values.
- You could define an extra _constant_ for the time in minutes per layer rather than using a "magic number" in your code.
- This function should [return a value][return] an integer.

## 4. Calculate total elapsed cooking time (prep + bake) in minutes

- Define a [function][defining functions] with two parameters.
- You can _call_ a function you've defined previously.
- You can use the [mathematical operator for addition][arithmetic] to sum values.
- This function should [return a value][return] an integer.

## 5. Update the recipe with notes

- Define a function without parameter.
- This function should return a string value.

[types]: https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04
[assignment]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_assignment_operators
[comments]: https://realpython.com/python-comments-guide/
[defining functions]: https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions
[return]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_return
[arithmetic]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators
[new variable]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-variable