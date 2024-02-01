BeforeAll {
    . "./SgfParsing.ps1"
}

Describe "SgfParsing test cases" {
    Context "valid input" {
        It "node without properties" {
            $got  = Invoke-Parser -Data "(;)"
            $want = [SgfTree]::new()

            $got | Should -BeExactly $want
        }
    
        It "single node tree" {
            $got = Invoke-Parser -Data "(;A[B])"
            $want = [SgfTree]::new(
                @{"A" = @("B")},
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "multiple properties" {
            $got = Invoke-Parser -Data "(;A[b]C[d])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("b")
                    "C" = @("d")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "two nodes" {
            $got = Invoke-Parser -Data "(;A[B];B[C])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("B")
                },
                @(
                    [SgfTree]::new(@{"B" = @("C")}, @())
                )
            )

            $got | Should -BeExactly $want
        }
    
        It "two child trees" {
            $got = Invoke-Parser -Data "(;A[B](;B[C])(;C[D]))"
            $want = [SgfTree]::new(
                @{
                    "A" = @("B")
                },
                @(
                    [SgfTree]::new(@{"B" = @("C")}, @()),
                    [SgfTree]::new(@{"C" = @("D")}, @())
                )
            )

            $got | Should -BeExactly $want
        }
    
        It "multiple property values" {
            $got = Invoke-Parser -Data "(;A[b][c][d])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("b","c","d")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "within property values, whitespace characters such as tab are converted to spaces" {
            $got = Invoke-Parser -Data "(;A[hello\t\tworld])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("hello  world")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "within property values, newlines remain as newlines" {
            $got = Invoke-Parser -Data "(;A[hello\n\nworld])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("hello\n\nworld")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "escaped closing bracket within property value becomes just a closing bracket" {
            $got = Invoke-Parser -Data "(;A[\\]])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("]")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "escaped backslash in property value becomes just a backslash" {
            $got = Invoke-Parser -Data "(;A[\\\\])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("\\")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "opening bracket within property value doesn't need to be escaped" {
            $got = Invoke-Parser -Data "(;A[x[y\\]z][foo]B[bar];C[baz])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("x[y]z", "foo")
                    "B" = @("bar")
                },
                @(
                    [SgfTree]::new(@{"C" = @("baz")}, @())
                )
            )

            $got | Should -BeExactly $want
        }
    
        It "semicolon in property value doesn't need to be escaped" {
            $got = Invoke-Parser -Data "(;A[a;b][foo]B[bar];C[baz])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("a;b", "foo")
                    "B" = @("bar")
                },
                @(
                    [SgfTree]::new(@{"C" = @("baz")}, @())
                )
            )

            $got | Should -BeExactly $want
        }
    
        It "parentheses in property value don't need to be escaped" {
            $got = Invoke-Parser -Data "(;A[x(y)z][foo]B[bar];C[baz])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("x(y)z", "foo")
                    "B" = @("bar")
                },
                @(
                    [SgfTree]::new(@{"C" = @("baz")}, @())
                )
            )

            $got | Should -BeExactly $want
        }
    
        It "escaped tab in property value is converted to space" {
            $got = Invoke-Parser -Data "(;A[hello\\\tworld])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("hello world")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "escaped newline in property value is converted to nothing at all" {
            $got = Invoke-Parser -Data "(;A[hello\\\nworld])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("helloworld")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "escaped t and n in property value are just letters, not whitespace" {
            $got = Invoke-Parser -Data "(;A[\\t = t and \\n = n])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("t = t and n = n")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    
        It "mixing various kinds of whitespace and escaped characters in property value" {
            $got = Invoke-Parser -Data "(;A[\\]b\nc\\\nd\t\te\\\\ \\\n\\]])"
            $want = [SgfTree]::new(
                @{
                    "A" = @("]b\ncd  e\\ ]")
                },
                @()
            )

            $got | Should -BeExactly $want
        }
    }
    
    Context "invalid input" {
        It "empty input" {
            {Invoke-Parser -Data ""} | Should -Throw "*Tree missing*"
        }
    
        It "tree with no nodes" {
            {Invoke-Parser -Data "()"} | Should -Throw "*Tree with no nodes*"
        }
    
        It "node without tree" {
            {Invoke-Parser -Data ";"} | Should -Throw "*Tree missing*"
        }
    
        It "properties without delimiter" {
            {Invoke-Parser -Data "(;A)"} | Should -Throw "*Properties without delimiter*"
        }
    
        It "all lowercase property" {
            {Invoke-Parser -Data "(;a[b])"} | Should -Throw "*Property must be in uppercase*"
        }
    
        It "upper and lowercase property" {
            {Invoke-Parser -Data "(;Aa[b])"} | Should -Throw "*Property must be in uppercase*"
        }
    }

}
