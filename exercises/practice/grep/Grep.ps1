Function Get-FilePath([string]$File) {
    <#
    .DESCRIPTION
    This is a helper function that take in a string name of a file, and return a full path of the file to be used.
    #>
    return Join-Path -Path $PSScriptRoot -ChildPath "/data/$($File)"
}

$DebugPreference = 'Continue'
Function Invoke-Grep() {
    <#
    .SYNOPSIS
    Implement a grep function similar to the grep command in unix system.

    .DESCRIPTION
    The Unix grep command searches files for lines that match a regular expression.
    Your task is to implement a simplified grep command, which supports searching for fixed strings.

    The grep command takes three arguments:

    1. The string to search for.
    2. Zero or more flags for customizing the command's behavior.
    3. One or more files to search in.

    It then reads the contents of the specified files (in the order specified), finds the lines that contain the search string, and finally returns those lines in the order in which they were found.
    When searching in multiple files, each matching line is prepended by the file name and a colon (':').
    Attempt to read file that doesn't exist should throw an error.

    .PARAMETER Pattern
    The string to be matched

    .PARAMETER Files
    An array of string, each represent a List
    This should be used with the given Get-FilePath function to retrieve the complete path

    .PARAMETER Number
    A switch parameter, similar to '-n' flag

    .PARAMETER List
    A switch parameter, similar to '-l' flag

    .PARAMETER Insensitive
    A switch parameter, similar to '-i' flag

    .PARAMETER Invert
    A switch parameter, similar to '-v' flag

    .PARAMETER Whole
    A switch parameter, similar to '-x' flag

    .EXAMPLE
    #>
    [CmdletBinding()]
    Param(
        [string]$Pattern,
        [string[]]$Files,
        [switch]$Number,
        [switch]$List,
        [switch]$Insensitive,
        [switch]$Invert,
        [switch]$Whole
    )

    Throw "Please implement this function"
}