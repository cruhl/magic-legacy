module Types.Light exposing (Light, Position, Status(..))

import Color exposing (Color)


type alias Light =
    { status : Status
    , position : Position
    , color : Color
    }


type Status
    = Enabled
    | Disabled


type alias Position =
    { x : Float
    , y : Float
    }
