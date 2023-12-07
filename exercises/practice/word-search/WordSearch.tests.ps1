BeforeAll {
    . "./WordSearch.ps1"
}

Describe "WordSearch test cases" {
    It "Should accept an initial game grid and a target search word" {
        $grid   = @("jefblpepre")
        $puzzle = [WordSearch]::new($grid)

        $puzzle.Search("clojure") | Should -BeNullOrEmpty
    }

    It "Should locate one word written left to right" {
        $grid   = @("clojurermt")
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(0, 6)
    }

    It "Should locate the same word written left to right in a different position" {
        $grid   = @("mtclojurer")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(0, 2), @(0, 8)
    }

    It "Should locate a different left to right word" {
        $grid   = @("coffeelplx")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("coffee")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(0, 5)
    }

    It "Should locate that different left to right word in a different position" {
        $grid   = @("xcoffeezlp")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("coffee")
        $got.Start, $got.End | Should -BeExactly @(0, 1), @(0, 6)
    }

    It "Should locate a left to right word in two line grid" {
        $grid   = @("jefblpepre", "tclojurerm")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(1, 1), @(1, 7)
    }

    It "Should locate a left to right word in three line grid" {
        $grid   = @("camdcimgtc", "jefblpepre", "clojurermt")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(2, 0), @(2, 6)
    }

    It "Should locate a left to right word in ten line grid" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
    }

    It "Should locate that left to right word in a different position in a ten line grid" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "clojurermt",
            "jalaycalmp"
        )
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(8, 0), @(8, 6)
    }

    It "Should locate a different left to right word in a ten line grid" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "fortranftw",
            "alxhpburyi",
            "clojurermt",
            "jalaycalmp"
        )
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("fortran")
        $got.Start, $got.End | Should -BeExactly @(6, 0), @(6, 6)
    }

    It "Should locate multiple words" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "fortranftw",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("fortran")
        $got.Start, $got.End | Should -BeExactly @(6, 0), @(6, 6)
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)

    }

    It "Should locate a single word written right to left" {
        $grid   = @("rixilelhrs")
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(0, 5), @(0, 0)
    }

    It "Should locate multiple words written in different horizontal directions" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)
        
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
    }

    It "Should locate words written vertically" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
    }

    It "Should locate words written bottom to top" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
    }

    It "Should locate words written top left to bottom right" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
        $got = $puzzle.Search("java")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(3, 3)
    }

    It "Should locate words written bottom right to top left" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
        $got = $puzzle.Search("java")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(3, 3)
        $got = $puzzle.Search("lua")
        $got.Start, $got.End | Should -BeExactly @(8, 7), @(6, 5)
    }

    It "Should locate words written bottom left to top right" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
        $got = $puzzle.Search("java")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(3, 3)
        $got = $puzzle.Search("lua")
        $got.Start, $got.End | Should -BeExactly @(8, 7), @(6, 5)
        $got = $puzzle.Search("lisp")
        $got.Start, $got.End | Should -BeExactly @(5, 2), @(2, 5)
    }

    It "Should locate words written top right to bottom left" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
        $got = $puzzle.Search("java")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(3, 3)
        $got = $puzzle.Search("lua")
        $got.Start, $got.End | Should -BeExactly @(8, 7), @(6, 5)
        $got = $puzzle.Search("lisp")
        $got.Start, $got.End | Should -BeExactly @(5, 2), @(2, 5)
        $got = $puzzle.Search("ruby")
        $got.Start, $got.End | Should -BeExactly @(5, 7), @(8, 4)
    }

    It "Should fail to locate a word that is not in the puzzle" {
        $grid   = @(
            "jefblpepre",
            "camdcimgtc",
            "oivokprjsm",
            "pbwasqroua",
            "rixilelhrs",
            "wolcqlirpc",
            "screeaumgr",
            "alxhpburyi",
            "jalaycalmp",
            "clojurermt"
        )
        $puzzle = [WordSearch]::new($grid)

        $got = $puzzle.Search("clojure")
        $got.Start, $got.End | Should -BeExactly @(9, 0), @(9, 6)
        $got = $puzzle.Search("elixir")
        $got.Start, $got.End | Should -BeExactly @(4, 5), @(4, 0)
        $got = $puzzle.Search("ecmascript")
        $got.Start, $got.End | Should -BeExactly @(0, 9), @(9, 9)
        $got = $puzzle.Search("rust")
        $got.Start, $got.End | Should -BeExactly @(4, 8), @(1, 8)
        $got = $puzzle.Search("java")
        $got.Start, $got.End | Should -BeExactly @(0, 0), @(3, 3)
        $got = $puzzle.Search("lua")
        $got.Start, $got.End | Should -BeExactly @(8, 7), @(6, 5)
        $got = $puzzle.Search("lisp")
        $got.Start, $got.End | Should -BeExactly @(5, 2), @(2, 5)
        $got = $puzzle.Search("ruby")
        $got.Start, $got.End | Should -BeExactly @(5, 7), @(8, 4)
        $puzzle.Search("haskell") | Should -BeNullOrEmpty
    }

    It "Should fail to locate words that are not on horizontal, vertical, or diagonal lines" {
        $grid   = @("abc", "def")
        $puzzle = [WordSearch]::new($grid)

        $puzzle.Search("aef") | Should -BeNullOrEmpty
        $puzzle.Search("ced") | Should -BeNullOrEmpty
        $puzzle.Search("abf") | Should -BeNullOrEmpty
        $puzzle.Search("cbd") | Should -BeNullOrEmpty
    }

    It "Should not concatenate different lines to find a horizontal word" {
        $grid   = @("abceli", "xirdfg")
        $puzzle = [WordSearch]::new($grid)

        $puzzle.Search("elixir") | Should -BeNullOrEmpty
    }

    It "Should not wrap around horizontally to find a word" {
        $grid   = @("silabcdefp")
        $puzzle = [WordSearch]::new($grid)

        $puzzle.Search("lisp") | Should -BeNullOrEmpty
    }

    It "Should not wrap around vertically to find a word" {
        $grid   = @("s", "u", "r", "a", "b", "c", "t")
        $puzzle = [WordSearch]::new($grid)

        $puzzle.Search("rust") | Should -BeNullOrEmpty
    }
}