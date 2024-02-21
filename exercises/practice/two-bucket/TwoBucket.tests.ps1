BeforeAll {
    . "./TwoBucket.ps1"
}

Describe "TwoBucket test cases" {
    It "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" {
        $buckets = [TwoBucket]::new(3, 5, "one")
        $got = $buckets.Measure(1)

        $got.Moves       | Should -BeExactly 4
        $got.GoalBucket  | Should -BeExactly "one"
        $got.OtherBucket | Should -BeExactly 5
    }

    It "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" {
        $buckets = [TwoBucket]::new(3, 5, "two")
        $got = $buckets.Measure(1)

        $got.Moves       | Should -BeExactly 8
        $got.GoalBucket  | Should -BeExactly "two"
        $got.OtherBucket | Should -BeExactly 3
    }

    It "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" {
        $buckets = [TwoBucket]::new(7, 11, "one")
        $got = $buckets.Measure(2)

        $got.Moves       | Should -BeExactly 14
        $got.GoalBucket  | Should -BeExactly "one"
        $got.OtherBucket | Should -BeExactly 11
    }

    It "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" {
        $buckets = [TwoBucket]::new(7, 11, "two")
        $got = $buckets.Measure(2)

        $got.Moves       | Should -BeExactly 18
        $got.GoalBucket  | Should -BeExactly "two"
        $got.OtherBucket | Should -BeExactly 7
    }

    It "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" {
        $buckets = [TwoBucket]::new(1, 3, "two")
        $got = $buckets.Measure(3)

        $got.Moves       | Should -BeExactly 1
        $got.GoalBucket  | Should -BeExactly "two"
        $got.OtherBucket | Should -BeExactly 0
    }

    It "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" {
        $buckets = [TwoBucket]::new(2, 3, "one")
        $got = $buckets.Measure(3)

        $got.Moves       | Should -BeExactly 2
        $got.GoalBucket  | Should -BeExactly "two"
        $got.OtherBucket | Should -BeExactly 2
    }

    It "Not possible to reach the goal" {
        $buckets = [TwoBucket]::new(6, 15, "one")
        { $buckets.Measure(5) } | Should -Throw "*Target is impossible to reach*"
    }

    It "With the same buckets but a different goal, then it is possible" {
        $buckets = [TwoBucket]::new(6, 15, "one")
        $got = $buckets.Measure(9)

        $got.Moves       | Should -BeExactly 10
        $got.GoalBucket  | Should -BeExactly "two"
        $got.OtherBucket | Should -BeExactly 0
    }

    It "Goal larger than both buckets is impossible" {
        $buckets = [TwoBucket]::new(5, 7, "one")
        { $buckets.Measure(8) } | Should -Throw "*Target is impossible to reach*"
    }

    It "Two buckets of the same size throw error" {
        $buckets = [TwoBucket]::new(5, 5, "one")
        { $buckets.Measure(4) } | Should -Throw "*Two buckets can't be of the same size*"
    }
}
