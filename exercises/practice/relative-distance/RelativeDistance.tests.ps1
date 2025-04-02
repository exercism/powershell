BeforeAll {
    . "./RelativeDistance.ps1"
}

Describe "RelativeDistance test cases" {
    It "Direct parent-child relation" {
        $tree = @{
            "Vera"   = @("Tomoko")
            "Tomoko" = @("Aditi")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Vera" -PersonB "Tomoko"
        $got | Should -Be 1
    }

    It "Sibling relationship" {
        $tree = @{
            "Dalia" = @("Olga", "Yassin")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Olga" -PersonB "Yassin"
        $got | Should -Be 1
    }

    It "Two degrees of separation, grandchild" {
        $tree = @{
            "Khadija" = @("Mateo")
            "Mateo"   = @("Rami")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Khadija" -PersonB "Rami"
        $got | Should -Be 2
    }

    It "Unrelated individuals" {
        $tree = @{
            "Priya" = @("Rami")
            "Kaito" = @("Elif")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Priya" -PersonB "Kaito"
        $got | Should -Be $null
    }

    It "Complex graph, cousins" {
        $tree = @{
            "Aiko"      = @("Bao", "Carlos")
            "Bao"       = @("Dalia", "Elias")
            "Carlos"    = @("Fatima", "Gustavo")
            "Dalia"     = @("Hassan", "Isla")
            "Elias"     = @("Javier")
            "Fatima"    = @("Khadija", "Liam")
            "Gustavo"   = @("Mina")
            "Hassan"    = @("Noah", "Olga")
            "Isla"      = @("Pedro")
            "Javier"    = @("Quynh", "Ravi")
            "Khadija"   = @("Sofia")
            "Liam"      = @("Tariq", "Uma")
            "Mina"      = @("Viktor", "Wang")
            "Noah"      = @("Xiomara")
            "Olga"      = @("Yuki")
            "Pedro"     = @("Zane", "Aditi")
            "Quynh"     = @("Boris")
            "Ravi"      = @("Celine")
            "Sofia"     = @("Diego", "Elif")
            "Tariq"     = @("Farah")
            "Uma"       = @("Giorgio")
            "Viktor"    = @("Hana", "Ian")
            "Wang"      = @("Jing")
            "Xiomara"   = @("Kaito")
            "Yuki"      = @("Leila")
            "Zane"      = @("Mateo")
            "Aditi"     = @("Nia")
            "Boris"     = @("Oscar")
            "Celine"    = @("Priya")
            "Diego"     = @("Qi")
            "Elif"      = @("Rami")
            "Farah"     = @("Sven")
            "Giorgio"   = @("Tomoko")
            "Hana"      = @("Umar")
            "Ian"       = @("Vera")
            "Jing"      = @("Wyatt")
            "Kaito"     = @("Xia")
            "Leila"     = @("Yassin")
            "Mateo"     = @("Zara")
            "Nia"       = @("Antonio")
            "Oscar"     = @("Bianca")
            "Priya"     = @("Cai")
            "Qi"        = @("Dimitri")
            "Rami"      = @("Ewa")
            "Sven"      = @("Fabio")
            "Tomoko"    = @("Gabriela")
            "Umar"      = @("Helena")
            "Vera"      = @("Igor")
            "Wyatt"     = @("Jun")
            "Xia"       = @("Kim")
            "Yassin"    = @("Lucia")
            "Zara"      = @("Mohammed")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Dimitri" -PersonB "Fabio"
        $got | Should -Be 9
    }

    It "Complex graph, no shortcut, far removed nephew" {
        $tree = @{
            "Aiko"      = @("Bao", "Carlos")
            "Bao"       = @("Dalia", "Elias")
            "Carlos"    = @("Fatima", "Gustavo")
            "Dalia"     = @("Hassan", "Isla")
            "Elias"     = @("Javier")
            "Fatima"    = @("Khadija", "Liam")
            "Gustavo"   = @("Mina")
            "Hassan"    = @("Noah", "Olga")
            "Isla"      = @("Pedro")
            "Javier"    = @("Quynh", "Ravi")
            "Khadija"   = @("Sofia")
            "Liam"      = @("Tariq", "Uma")
            "Mina"      = @("Viktor", "Wang")
            "Noah"      = @("Xiomara")
            "Olga"      = @("Yuki")
            "Pedro"     = @("Zane", "Aditi")
            "Quynh"     = @("Boris")
            "Ravi"      = @("Celine")
            "Sofia"     = @("Diego", "Elif")
            "Tariq"     = @("Farah")
            "Uma"       = @("Giorgio")
            "Viktor"    = @("Hana", "Ian")
            "Wang"      = @("Jing")
            "Xiomara"   = @("Kaito")
            "Yuki"      = @("Leila")
            "Zane"      = @("Mateo")
            "Aditi"     = @("Nia")
            "Boris"     = @("Oscar")
            "Celine"    = @("Priya")
            "Diego"     = @("Qi")
            "Elif"      = @("Rami")
            "Farah"     = @("Sven")
            "Giorgio"   = @("Tomoko")
            "Hana"      = @("Umar")
            "Ian"       = @("Vera")
            "Jing"      = @("Wyatt")
            "Kaito"     = @("Xia")
            "Leila"     = @("Yassin")
            "Mateo"     = @("Zara")
            "Nia"       = @("Antonio")
            "Oscar"     = @("Bianca")
            "Priya"     = @("Cai")
            "Qi"        = @("Dimitri")
            "Rami"      = @("Ewa")
            "Sven"      = @("Fabio")
            "Tomoko"    = @("Gabriela")
            "Umar"      = @("Helena")
            "Vera"      = @("Igor")
            "Wyatt"     = @("Jun")
            "Xia"       = @("Kim")
            "Yassin"    = @("Lucia")
            "Zara"      = @("Mohammed")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Lucia" -PersonB "Jun"
        $got | Should -Be 14
    }

    It "Complex graph, some shortcuts, cross-down and cross-up, cousins several times removed, with unrelated family tree" {
        $tree = @{
            "Aiko"      = @("Bao", "Carlos")
            "Bao"       = @("Dalia")
            "Carlos"    = @("Fatima", "Gustavo")
            "Dalia"     = @("Hassan", "Isla")
            "Fatima"    = @("Khadija", "Liam")
            "Gustavo"   = @("Mina")
            "Hassan"    = @("Noah", "Olga")
            "Isla"      = @("Pedro")
            "Javier"    = @("Quynh", "Ravi")
            "Khadija"   = @("Sofia")
            "Liam"      = @("Tariq", "Uma")
            "Mina"      = @("Viktor", "Wang")
            "Noah"      = @("Xiomara")
            "Olga"      = @("Yuki")
            "Pedro"     = @("Zane", "Aditi")
            "Quynh"     = @("Boris")
            "Ravi"      = @("Celine")
            "Sofia"     = @("Diego", "Elif")
            "Tariq"     = @("Farah")
            "Uma"       = @("Giorgio")
            "Viktor"    = @("Hana", "Ian")
            "Wang"      = @("Jing")
            "Xiomara"   = @("Kaito")
            "Yuki"      = @("Leila")
            "Zane"      = @("Mateo")
            "Aditi"     = @("Nia")
            "Boris"     = @("Oscar")
            "Celine"    = @("Priya")
            "Diego"     = @("Qi")
            "Elif"      = @("Rami")
            "Farah"     = @("Sven")
            "Giorgio"   = @("Tomoko")
            "Hana"      = @("Umar")
            "Ian"       = @("Vera")
            "Jing"      = @("Wyatt")
            "Kaito"     = @("Xia")
            "Leila"     = @("Yassin")
            "Mateo"     = @("Zara")
            "Nia"       = @("Antonio")
            "Oscar"     = @("Bianca")
            "Priya"     = @("Cai")
            "Qi"        = @("Dimitri")
            "Rami"      = @("Ewa")
            "Sven"      = @("Fabio")
            "Tomoko"    = @("Gabriela")
            "Umar"      = @("Helena")
            "Vera"      = @("Igor")
            "Wyatt"     = @("Jun")
            "Xia"       = @("Kim")
            "Yassin"    = @("Lucia")
            "Zara"      = @("Mohammed")
        }

        $got = Invoke-RelativeDistance -FamilyTree $tree -PersonA "Wyatt" -PersonB "Xia"
        $got | Should -Be 12
    }
}
