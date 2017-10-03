module State.Msg exposing (Msg(..))

import Color exposing (Color)


type Msg
    = SetLights (List String) Color
