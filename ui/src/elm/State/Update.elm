module State.Update exposing (update)

import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import Time
import Utils.Tuple exposing ((=>))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ timeline } as model) =
    case msg of
        ZoomOut ->
            let
                { start, end } =
                    timeline

                duration =
                    (end - start) * 2

                newTimeline =
                    { timeline
                        | start = start - duration
                        , end = end + duration
                    }
            in
            { model | timeline = newTimeline } => Cmd.none
