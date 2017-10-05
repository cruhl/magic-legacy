module Types.Script exposing (Action(..), Script, Timing(..), toCmd)

import Color exposing (Color)
import State.Msg exposing (Msg(SetLights))
import State.Utils exposing (delay)
import Time exposing (Time)
import Tuple
import Types.Light exposing (Light)
import Utils.Tuple exposing ((=>))


type alias Script =
    List ( Timing, Action )


type Timing
    = Now
    | After Time


type Action
    = Set (List String) Color


toCmd : Script -> Cmd Msg
toCmd script =
    let
        toCmd ( timing, Set tags color ) ( cmds, time ) =
            let
                wait =
                    case timing of
                        After time ->
                            time

                        _ ->
                            0

                updatedTime =
                    time + wait
            in
            delay updatedTime (SetLights tags color) :: cmds => updatedTime
    in
    script
        |> List.foldl toCmd ( [], 0 )
        |> Tuple.first
        |> Cmd.batch
