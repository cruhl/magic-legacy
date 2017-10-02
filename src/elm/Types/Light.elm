module Types.Light exposing (Light, Position)

import Color exposing (Color)


type alias Light =
    { tags : List String
    , position : Position
    , color : Color
    }


type alias Position =
    { x : Float
    , y : Float
    }
