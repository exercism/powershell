BeforeAll {
    . "./Prism.ps1"
}

Describe "Prism test cases" {
    It "zero prisms" {
        $laser = [Laser]::new()
        $prisms = @()

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "one prism one hit" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(1, 10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(1)
    }

    It "one prism zero hits" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(1, -10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "going up zero hits" {
        $laser = [Laser]::new(90)
        $prisms = @(
            [Prism]::new(3, 0, -10, 0)
            [Prism]::new(1, -10, 0, 0)
            [Prism]::new(2, 10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "going down zero hits" {
        $laser = [Laser]::new(-90)
        $prisms = @(
            [Prism]::new(1, 10, 0, 0)
            [Prism]::new(2, 0, 10, 0)
            [Prism]::new(3, -10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "going left zero hits" {
        $laser = [Laser]::new(180)
        $prisms = @(
            [Prism]::new(2, 0, 10, 0)
            [Prism]::new(3, 10, 0, 0)
            [Prism]::new(1, 0, -10, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "negative angle" {
        $laser = [Laser]::new(-180)
        $prisms = @(
            [Prism]::new(1, 0, -10, 0)
            [Prism]::new(2, 0, 10, 0)
            [Prism]::new(3, 10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }   

    It "large angle" {
        $laser = [Laser]::new(2340)
        $prisms = @(
            [Prism]::new(1, 10, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeNullOrEmpty
    }

    It "upward refraction two hits" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(1, 10, 10, 0)
            [Prism]::new(2, 10, 0, 90)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(2, 1)
    }

    It "downward refraction two hits" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(1, 10, 0, -90)
            [Prism]::new(2, 10, -10, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(1, 2)
    }

    It "same prism twice" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(2, 10, 0, 0)
            [Prism]::new(1, 20, 0, -180)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(2, 1, 2)
    }

    It "simple path" {
        $laser = [Laser]::new()
        $prisms = @(
            [Prism]::new(3, 30, 10, 45)
            [Prism]::new(1, 10, 10, -90)
            [Prism]::new(2, 10, 0, 90)
            [Prism]::new(4, 20, 0, 0)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(2, 1, 3)
    }

    It "multiple prisms floating point precision" {
        $laser = [Laser]::new(-6.429)
        $prisms = @(
            [Prism]::new(26, 5.8, 73.40000000000001, 6.555)
            [Prism]::new(24, 36.2, 65.2, -0.304)
            [Prism]::new(20, 20.4, 82.8, 45.17)
            [Prism]::new(31, -20.2, 48.8, 30.615)
            [Prism]::new(30, 24.0, 0.6, 28.771)
            [Prism]::new(29, 31.4, 79.40000000000001, 61.327)
            [Prism]::new(28, 36.4, 31.4, -18.157)
            [Prism]::new(22, 47.0, 57.8, 54.745)
            [Prism]::new(38, 36.4, 79.2, 49.05)
            [Prism]::new(10, 37.8, 55.2, 11.978)
            [Prism]::new(18, -26.0, 42.6, 22.661)
            [Prism]::new(25, 38.8, 76.2, 51.958)
            [Prism]::new(2, 0.0, 42.4, -21.817)
            [Prism]::new(35, 21.4, 44.8, -171.579)
            [Prism]::new(7, 14.2, -1.6, 19.081)
            [Prism]::new(33, 11.2, 44.4, -165.941)
            [Prism]::new(11, 15.4, 82.59999999999999, 66.262)
            [Prism]::new(16, 30.8, 6.6, 35.852)
            [Prism]::new(15, -3.0, 79.2, 53.782)
            [Prism]::new(4, 29.0, 75.40000000000001, 17.016)
            [Prism]::new(23, 41.6, 59.8, 70.76300000000001)
            [Prism]::new(8, -10.0, 15.8, -9.24)
            [Prism]::new(13, 48.6, 51.8, 45.812)
            [Prism]::new(1, 13.2, 77.0, 17.937)
            [Prism]::new(34, -8.800000000000001, 36.8, -4.199)
            [Prism]::new(21, 24.4, 75.8, 20.783)
            [Prism]::new(17, -4.4, 74.59999999999999, 24.709)
            [Prism]::new(9, 30.8, 41.8, -165.413)
            [Prism]::new(32, 4.2, 78.59999999999999, 40.892)
            [Prism]::new(37, -15.8, 47.0, 33.29)
            [Prism]::new(6, 1.0, 80.59999999999999, 51.295)
            [Prism]::new(36, -27.0, 47.8, 92.52)
            [Prism]::new(14, -2.0, 34.4, -52.001)
            [Prism]::new(5, 23.2, 80.2, 31.866)
            [Prism]::new(27, -5.6, 32.8, -75.303)
            [Prism]::new(12, -1.0, 0.2, 0.0)
            [Prism]::new(3, -6.6, 3.2, 46.72)
            [Prism]::new(19, -13.8, 24.2, -9.205)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(
            7, 30, 16, 28, 13, 22, 23, 10, 9, 24, 25, 38, 29, 4, 35, 21, 5, 20, 11,
            1, 33, 26, 32, 6, 15, 17, 2, 14, 27, 34, 37, 31, 36, 18, 19, 8, 3, 12
        )
    }

    It "complex path with multiple prisms floating point precision" {
        $laser = [Laser]::new(0.0)
        $prisms = @(
            [Prism]::new(46, 37.4, 20.6, -88.33199999999999)
            [Prism]::new(72, -24.2, 23.4, -90.774)
            [Prism]::new(25, 78.59999999999999, 7.8, 98.562)
            [Prism]::new(60, -58.8, 31.6, 115.56)
            [Prism]::new(22, 75.2, 28.0, 63.515)
            [Prism]::new(2, 89.8, 27.8, 91.176)
            [Prism]::new(23, 9.800000000000001, 30.8, 30.829)
            [Prism]::new(69, 22.8, 20.6, -88.315)
            [Prism]::new(44, -0.8, 15.6, -116.565)
            [Prism]::new(36, -24.2, 8.199999999999999, -90.0)
            [Prism]::new(53, -1.2, 0.0, 0.0)
            [Prism]::new(52, 14.2, 24.0, -143.896)
            [Prism]::new(5, -65.2, 21.6, 93.128)
            [Prism]::new(66, 5.4, 15.6, 31.608)
            [Prism]::new(51, -72.59999999999999, 21.0, -100.976)
            [Prism]::new(65, 48.0, 10.2, 87.455)
            [Prism]::new(21, -41.8, 0.0, 68.352)
            [Prism]::new(18, -46.2, 19.2, -128.362)
            [Prism]::new(10, 74.40000000000001, 0.4, 90.93899999999999)
            [Prism]::new(15, 67.59999999999999, 0.4, 84.958)
            [Prism]::new(35, 14.8, -0.4, 89.176)
            [Prism]::new(1, 83.0, 0.2, 89.105)
            [Prism]::new(68, 14.6, 28.0, -29.867)
            [Prism]::new(67, 79.8, 18.6, -136.643)
            [Prism]::new(38, 53.0, 14.6, -90.848)
            [Prism]::new(31, -58.0, 6.6, -61.837)
            [Prism]::new(74, -30.8, 0.4, 85.96599999999999)
            [Prism]::new(48, -4.6, 10.0, -161.222)
            [Prism]::new(12, 59.0, 5.0, -91.164)
            [Prism]::new(33, -16.4, 18.4, 90.73399999999999)
            [Prism]::new(4, 82.59999999999999, 27.6, 71.127)
            [Prism]::new(75, -10.2, 30.6, -1.108)
            [Prism]::new(28, 38.0, 0.0, 86.863)
            [Prism]::new(11, 64.40000000000001, -0.2, 92.35299999999999)
            [Prism]::new(9, -51.4, 31.6, 67.249)
            [Prism]::new(26, -39.8, 30.8, 61.113)
            [Prism]::new(30, -34.2, 0.6, 111.33)
            [Prism]::new(56, -51.0, 0.2, 70.44499999999999)
            [Prism]::new(41, -12.0, 0.0, 91.21899999999999)
            [Prism]::new(24, 63.8, 14.4, 86.586)
            [Prism]::new(70, -72.8, 13.4, -87.238)
            [Prism]::new(3, 22.4, 7.0, -91.685)
            [Prism]::new(13, 34.4, 7.0, 90.0)
            [Prism]::new(16, -47.4, 11.4, -136.02)
            [Prism]::new(6, 90.0, 0.2, 90.41500000000001)
            [Prism]::new(54, 44.0, 27.8, 85.96899999999999)
            [Prism]::new(32, -9.0, 0.0, 91.61499999999999)
            [Prism]::new(8, -31.6, 30.8, 0.535)
            [Prism]::new(39, -12.0, 8.199999999999999, 90.0)
            [Prism]::new(14, -79.59999999999999, 32.4, 92.342)
            [Prism]::new(42, 65.8, 20.8, -85.867)
            [Prism]::new(40, -65.0, 14.0, 87.10899999999999)
            [Prism]::new(45, 10.6, 18.8, 23.697)
            [Prism]::new(71, -24.2, 18.6, -88.53100000000001)
            [Prism]::new(7, -72.59999999999999, 6.4, -89.148)
            [Prism]::new(62, -32.0, 24.8, -140.8)
            [Prism]::new(49, 34.4, -0.2, 89.41500000000001)
            [Prism]::new(63, 74.2, 12.6, -138.429)
            [Prism]::new(59, 82.8, 13.0, -140.177)
            [Prism]::new(34, -9.4, 23.2, -88.238)
            [Prism]::new(76, -57.6, 0.0, 1.2)
            [Prism]::new(43, 7.0, 0.0, 116.565)
            [Prism]::new(20, 45.8, -0.2, 1.469)
            [Prism]::new(37, -16.6, 13.2, 84.785)
            [Prism]::new(58, -79.0, -0.2, 89.48099999999999)
            [Prism]::new(50, -24.2, 12.8, -86.98699999999999)
            [Prism]::new(64, 59.2, 10.2, -92.203)
            [Prism]::new(61, -72.0, 26.4, -83.66)
            [Prism]::new(47, 45.4, 5.8, -82.992)
            [Prism]::new(17, -52.2, 17.8, -52.938)
            [Prism]::new(57, -61.8, 32.0, 84.627)
            [Prism]::new(29, 47.2, 28.2, 92.95399999999999)
            [Prism]::new(27, -4.6, 0.2, 87.39700000000001)
            [Prism]::new(55, -61.4, 26.4, 94.086)
            [Prism]::new(73, -40.4, 13.4, -62.229)
            [Prism]::new(19, 53.2, 20.6, -87.181)
        )

        $got = Get-PrismSequence -Laser $laser -Prisms $prisms
        $got | Should -BeExactly @(
            43, 44, 66, 45, 52, 35, 49, 13, 3, 69, 46, 28, 20, 11, 24, 38, 19, 42, 15, 10, 63, 25, 59, 1, 6,
            2, 4, 67, 22, 29, 65, 64, 12, 47, 54, 68, 23, 75, 8, 26, 18, 9, 60, 17, 31, 7, 70, 40, 5, 51, 61,
            55, 57, 14, 58, 76, 56, 16, 21, 30, 73, 62, 74, 41, 39, 36, 50, 37, 33, 71, 72, 34, 32, 27, 48, 53
        )
    }
}
