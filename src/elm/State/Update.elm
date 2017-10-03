module State.Update exposing (update)

import Color
import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import Types.Light exposing (Light)
import Utils.Tuple exposing ((=>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeColor ->
            let
                changeCount =
                    model.changeCount + 1

                lights =
                    model.lights
                        |> List.indexedMap (changeColor changeCount)
            in
            { model
                | lights = lights
                , changeCount = changeCount
            }
                => Cmd.none


changeColor : Int -> Int -> Light -> Light
changeColor changeCount index light =
    let
        color =
            case (changeCount + index) % 3 of
                0 ->
                    Color.rgb 255 0 0

                1 ->
                    Color.rgb 0 255 0

                _ ->
                    Color.rgb 0 0 255
    in
    { light | color = color }
