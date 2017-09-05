module Mock.Property exposing (bayPointe, neptune, papillon)

import Types.Property exposing (Property)


bayPointe : Property
bayPointe =
    { street = "455 Nom Nom Ln"
    , city = "Bobberton"
    , state = "CA"
    , zip = 35555
    }


papillon : Property
papillon =
    { street = "Extra Juicy Dr"
    , city = "Trash Town"
    , state = "IL"
    , zip = 55566
    }


neptune : Property
neptune =
    { street = "5807 Neptune Dr"
    , city = "Normal Juice Ct"
    , state = "MO"
    , zip = 445566
    }
