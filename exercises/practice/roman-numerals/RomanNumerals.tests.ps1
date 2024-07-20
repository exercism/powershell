BeforeAll {
    . ".\RomanNumerals.ps1"
}
Describe "Roman Numerals Test Cases" {
    Context "Passing Tests" {
        It "Given <Number> it outputs <Result>" -TestCases @(
        @{ Number = 1;      Result = "I"        }
        @{ Number = 2;      Result = "II"       },
        @{ Number = 3;      Result = "III"      },
        @{ Number = 4;      Result = "IV"       },
        @{ Number = 5;      Result = "V"        },
        @{ Number = 6;      Result = "VI"       },
        @{ Number = 9;      Result = "IX"       },
        @{ Number = 16;     Result = "XVI"      },
        @{ Number = 27;     Result = "XXVII"    },
        @{ Number = 48;     Result = "XLVIII"   },
        @{ Number = 49;     Result = "XLIX"     },
        @{ Number = 59;     Result = "LIX"      },
        @{ Number = 66;     Result = "LXVI"     },
        @{ Number = 93;     Result = "XCIII"    },
        @{ Number = 141;    Result = "CXLI"     },
        @{ Number = 163;    Result = "CLXIII"   },
        @{ Number = 166;    Result = "CLXVI"    },
        @{ Number = 402;    Result = "CDII"     },
        @{ Number = 575;    Result = "DLXXV"    },
        @{ Number = 666;    Result = "DCLXVI"   },
        @{ Number = 911;    Result = "CMXI"     },
        @{ Number = 1024;   Result = "MXXIV"    },
        @{ Number = 1666;   Result = "MDCLXVI"  },
        @{ Number = 3000;   Result = "MMM"      },
        @{ Number = 3001;   Result = "MMMI"     },
        @{ Number = 3888;   Result = "MMMDCCCLXXXVIII"},
        @{ Number = 3999;   Result = "MMMCMXCIX"}
        ) {
            Param(
                [int]$Number,
                [string]$Result
		    )
            Get-RomanNumerals -Number $Number | Should -BeExactly $Result
        }
    }

    Context "Invalid Inputs" {
        It "Number is zero" {
            { Get-RomanNumerals -Number    0 }  | Should -Throw "*Number has to be positive integer in range of 1-3999.*"
        }

        It "Negative number" {
            { Get-RomanNumerals -Number  -12 }  | Should -Throw "*Number has to be positive integer in range of 1-3999.*"
        }

        It "Number larger than 3999" {
            { Get-RomanNumerals -Number 9999 }  | Should -Throw "*Number has to be positive integer in range of 1-3999.*"
        }
    }
}