module Types.User exposing (User, initials)


type alias User =
    { id : String
    , name : Name
    , phone : String
    , email : String
    , profileUrl : Maybe String
    }


type alias Name =
    { first : String
    , last : String
    }


initials : User -> String
initials { name } =
    String.left 1 name.first ++ String.left 1 name.last
