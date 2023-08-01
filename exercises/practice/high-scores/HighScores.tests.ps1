BeforeAll {
    . "./HighScores.ps1"
}

Describe "High Scores Test cases" {
    It "List of scores" {
        $scores = [HighScores]::New(@(30, 50, 90, 40, 20, 70))
        $got    = $scores.GetScores()
        $want   = @(30, 50, 90, 40, 20, 70)

        $got | Should -BeExactly $want
    }

    It "Latest score" {
        $scores = [HighScores]::New(@(20, 60, 80))
        $got    = $scores.GetLatest()
        $want   = 80

        $got | Should -BeExactly $want
    }

    It "should return the personal best score" {
        $scores = [HighScores]::New(@(50, 40, 10, 20, 90, 100))
        $got    = $scores.GetPersonalBest()
        $want   = 100

        $got | Should -BeExactly $want
    }

    It "Personal top three from a list of scores" {
        $scores = [HighScores]::New(@(10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70))
        $got    = $scores.GetTopThree()
        $want   = @(100, 90, 70)

        $got | Should -BeExactly $want
    }

    It "Personal top highest to lowest" {
        $scores = [HighScores]::New(@(20, 10, 30))
        $got    = $scores.GetTopThree()
        $want   = @(30, 20, 10)

        $got | Should -BeExactly $want
    }

    It "Personal top when there is a tie" {
        $scores = [HighScores]::New(@(20, 30, 40, 30))
        $got    = $scores.GetTopThree()
        $want   = @(40, 30, 30)

        $got | Should -BeExactly $want
    }

    It "Personal top when there are less than 3" {
        $scores = [HighScores]::New(@(50, 60))
        $got    = $scores.GetTopThree()
        $want   = @(60, 50)

        $got | Should -BeExactly $want
    }

    It "Personal top when there is only one" {
        $scores = [HighScores]::New(@(80))
        $got    = $scores.GetTopThree()
        $want   = @(80)

        $got | Should -BeExactly $want
    }

    It "Latest score after personal top scores" {
        $scores = [HighScores]::New(@(70, 50, 20, 30))
        $scores.GetTopThree()
        $got    = $scores.GetLatest()
        $want   = @(30)

        $got | Should -BeExactly $want
    }

    It "Scores after personal top scores" {
        $scores = [HighScores]::New(@(70, 50, 20, 30))
        $scores.GetTopThree()
        $got    = $scores.GetScores()
        $want   = @(70, 50, 20, 30)

        $got | Should -BeExactly $want
    }

    It "Latest score after personal best" {
        $scores = [HighScores]::New(@(40, 60, 20, 90, 70))
        $scores.GetPersonalBest()
        $got    = $scores.GetLatest()
        $want   = 70

        $got | Should -BeExactly $want
    }

    It "Scores after personal best" {
        $scores = [HighScores]::New(@(50, 60, 100, 90, 70))
        $scores.GetPersonalBest()
        $got    = $scores.GetScores()
        $want   = @(50, 60, 100, 90, 70)
        
        $got | Should -BeExactly $want
    }
}