BeforeAll {
    . "./Markdown.ps1"
}

Describe "Markdown test cases" {
    It "parses normal text as a paragraph" {
        $got  = Invoke-Parser -Markdown "This will be a paragraph"
        $want = "<p>This will be a paragraph</p>"

        $got | Should -BeExactly $want
    }

    It "parsing italics" {
        $got  = Invoke-Parser -Markdown "_This will be italic_"
        $want = "<p><em>This will be italic</em></p>"

        $got | Should -BeExactly $want
    }

    It "parsing bold text" {
        $got  = Invoke-Parser -Markdown "__This will be bold__"
        $want = "<p><strong>This will be bold</strong></p>"

        $got | Should -BeExactly $want
    }

    It "mixed normal, italics and bold text" {
        $got  = Invoke-Parser -Markdown "This will _be_ __mixed__"
        $want = "<p>This will <em>be</em> <strong>mixed</strong></p>"

        $got | Should -BeExactly $want
    }

    It "with h1 header level" {
        $got  = Invoke-Parser -Markdown "# This will be an h1"
        $want = "<h1>This will be an h1</h1>"

        $got | Should -BeExactly $want
    }

    It "with h2 header level" {
        $got  = Invoke-Parser -Markdown "## This will be an h2"
        $want = "<h2>This will be an h2</h2>"

        $got | Should -BeExactly $want
    }

    It "with h3 header level" {
        $got  = Invoke-Parser -Markdown "### This will be an h3"
        $want = "<h3>This will be an h3</h3>"

        $got | Should -BeExactly $want
    }

    It "with h4 header level" {
        $got  = Invoke-Parser -Markdown "### This will be an h3"
        $want = "<h3>This will be an h3</h3>"

        $got | Should -BeExactly $want
    }

    It "with h5 header level" {
        $got  = Invoke-Parser -Markdown "##### This will be an h5"
        $want = "<h5>This will be an h5</h5>"

        $got | Should -BeExactly $want
    }

    It "with h6 header level" {
        $got  = Invoke-Parser -Markdown "###### This will be an h6"
        $want = "<h6>This will be an h6</h6>"

        $got | Should -BeExactly $want
    }

    It "h7 header level is a paragraph" {
        $got  = Invoke-Parser -Markdown "####### This will not be an h7"
        $want = "<p>####### This will not be an h7</p>"

        $got | Should -BeExactly $want
    }

    It "unordered lists" {
        $got  = Invoke-Parser -Markdown "* Item 1\n* Item 2"
        $want = "<ul><li>Item 1</li><li>Item 2</li></ul>"

        $got | Should -BeExactly $want
    }

    It "With a little bit of everything" {
        $got  = Invoke-Parser -Markdown "# Header!\n* __Bold Item__\n* _Italic Item_"
        $want = "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"

        $got | Should -BeExactly $want
    }

    It "with markdown symbols in the header text that should not be interpreted" {
        $got  = Invoke-Parser -Markdown "# This is a header with # and * in the text"
        $want = "<h1>This is a header with # and * in the text</h1>"

        $got | Should -BeExactly $want
    }

    It "with markdown symbols in the list item text that should not be interpreted" {
        $got  = Invoke-Parser -Markdown "* Item 1 with a # in the text\n* Item 2 with * in the text"
        $want = "<ul><li>Item 1 with a # in the text</li><li>Item 2 with * in the text</li></ul>"

        $got | Should -BeExactly $want
    }

    It "with markdown symbols in the paragraph text that should not be interpreted" {
        $got  = Invoke-Parser -Markdown "This is a paragraph with # and * in the text"
        $want = "<p>This is a paragraph with # and * in the text</p>"

        $got | Should -BeExactly $want
    }

    It "unordered lists close properly with preceding and following lines" {
        $got  = Invoke-Parser -Markdown "# Start a list\n* Item 1\n* Item 2\nEnd a list"
        $want = "<h1>Start a list</h1><ul><li>Item 1</li><li>Item 2</li></ul><p>End a list</p>"

        $got | Should -BeExactly $want
    }

}
