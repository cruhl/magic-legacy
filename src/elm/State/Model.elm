module State.Model exposing (Model, init)

import Color
import Tuple
import Types.Light exposing (Light)
import Utils.Tuple exposing (..)


type alias Model =
    Light


init : ( Model, Cmd msg )
init =
    Color.hsla 0 207 100 50
        |> Light
        => Cmd.none
