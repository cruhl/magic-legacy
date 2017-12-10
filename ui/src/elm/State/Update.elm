module State.Update exposing (update)

import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import Utils.Tuple exposing ((=>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model => Cmd.none
