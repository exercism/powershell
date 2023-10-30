## Powershell Track

### Flags change

Powershell supports switch parameter for functions, which behave similar to flags in command line.

Keeping up with powershell custom of having detailed and verbose names for cmdlets and its properties, the flags being used for this exercise also have their name changed to reflect the language.

- `Line` (-n): Prepend the line number and a colon (':') to each line in the output, placing the number after the filename (if present).
- `File` (-l): Output only the names of the files that contain at least one matching line.
- `Insensitive` (-i): Match using a case-insensitive comparison.
- `Invert` (-v): Invert the program -- collect all lines that fail to match.
- `Whole` (-x): Search only for lines where the search string matches the entire line.

### Files handling

Your main focus should be implement the grep function and not to worry about getting the path to the files correctly.

This exercise will provide 3 required text files: `iliad.txt`, `midsummer-night.txt`, and `paradise-lost.txt` in the test suit, you can just access their content with `Get-Content` using the name string instead of the usual file path.

### Cmdlet

Powershell does have a cmdlet similar to `grep` called `Select-String`, and you could read more about it [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string) if you are interested. You should not use `Select-String` for this exercise at any point.