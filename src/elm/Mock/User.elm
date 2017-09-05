module Mock.User exposing (brian, conner, joe, kim)

import Types.User exposing (User)


conner : User
conner =
    { id = "qet357"
    , name = { first = "Conner", last = "Ruhl" }
    , phone = "+16183334444"
    , email = "connerruhl@youmewho.com"
    , profileUrl = Just "http://i.imgur.com/hA3lEvs.jpg"
    }


joe : User
joe =
    { id = "djk488"
    , name = { first = "Joe", last = "Bradish" }
    , phone = "+15556667777"
    , email = "jbrad@gmail.com"
    , profileUrl = Nothing
    }


brian : User
brian =
    { id = "dht553"
    , name = { first = "Brian", last = "Fitzgerald" }
    , phone = "+10009997777"
    , email = "bf-alibaba-moist@gmail.com"
    , profileUrl = Nothing
    }


kim : User
kim =
    { id = "cbm579"
    , name = { first = "Kim", last = "Ruhl" }
    , phone = "+16181113333"
    , email = "kruhl@gmail.com"
    , profileUrl = Just "http://i.imgur.com/qCW0Jep.jpg"
    }
