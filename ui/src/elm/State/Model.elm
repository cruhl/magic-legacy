module State.Model exposing (Model, init)

import Data.Lights
import Data.Scripts
import Dict exposing (Dict)
import State.Msg exposing (Msg)
import Types.Light exposing (Light)
import Types.Script as Script exposing (Script)
import Utils.Tuple exposing ((=>))


type alias Model =
    { lights : Dict String Light }


init : ( Model, Cmd Msg )
init =
    { lights = Data.Lights.default }
        => Script.toCmd Data.Scripts.showRooms
