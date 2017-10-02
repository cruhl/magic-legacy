module State.Model exposing (Model, init)

import Utils.Tuple exposing (..)


type alias Model =
    String


init : ( Model, Cmd msg )
init =
    "Test" => Cmd.none
