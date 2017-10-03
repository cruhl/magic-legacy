module State.Model exposing (Model, init)

import Color exposing (rgba)
import Data.Lights
import State.Msg exposing (Msg)
import Time
import Types.Light exposing (Light, Status(..))
import Types.Script as Script exposing (Action(..), Script, Timing(..))
import Utils.Tuple exposing ((=>))


type alias Model =
    { lights : List Light }


init : ( Model, Cmd Msg )
init =
    { lights = Data.Lights.home } => Script.toCmd script


script : Script
script =
    let
        all =
            [ "office"
            , "hallway"
            , "bathroom"
            , "guest"
            , "living"
            , "dining"
            , "kitchen"
            , "master"
            , "laundry"
            , "garage"
            , "outside"
            ]

        time =
            1 * Time.second

        off =
            rgba 0 0 0 0

        set index tag =
            let
                color =
                    case index % 3 of
                        0 ->
                            rgba 255 0 0 1

                        1 ->
                            rgba 0 255 0 1

                        _ ->
                            rgba 0 0 255 1
            in
            After time => Set [ tag ] color
    in
    all
        |> List.indexedMap set
        |> List.intersperse (After time => Set all off)
        |> List.append [ Now => Set all off ]
