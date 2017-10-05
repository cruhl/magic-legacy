module State.Update exposing (update)

import Dict
import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import Utils.Tuple exposing ((=>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLights ids color ->
            let
                lights =
                    ids |> List.foldl updateLightIfFound model.lights

                updateLightIfFound id lights =
                    lights |> Dict.update id (Maybe.map changeColor)

                changeColor light =
                    { light | color = color }
            in
            { model | lights = lights } => Cmd.none
