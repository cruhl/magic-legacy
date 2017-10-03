module State.Update exposing (update)

import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import Utils.Tuple exposing ((=>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetLights tags color ->
            let
                tagsMatch light =
                    light.tags
                        |> List.filter (flip List.member tags)
                        |> List.isEmpty
                        |> not

                setLight light lights =
                    if tagsMatch light then
                        { light | color = color } :: lights
                    else
                        light :: lights

                lights =
                    model.lights
                        |> List.foldr setLight []
            in
            { model | lights = lights } => Cmd.none



-- for all lights
-- for all tags
-- check if tag is in list
