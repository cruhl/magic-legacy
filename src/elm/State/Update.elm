module State.Update exposing (update)

import State.Model as Model exposing (Model)
import State.Msg exposing (Msg(..))
import State.Utils as Utils
import Types.Remote as Remote


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TimelineLoaded timeline ->
            { model | timeline = Remote.Loaded timeline }
                |> Utils.noCmd

        OpenUserPage user ->
            { model | selectedUser = Just user }
                |> Utils.noCmd

        ExitUserPage ->
            { model | selectedUser = Nothing }
                |> Utils.noCmd

        OpenDescriptionPage descriptionId ->
            { model | selectedDescriptionId = Just descriptionId }
                |> Utils.noCmd

        ExitDescriptionPage ->
            { model | selectedDescriptionId = Nothing }
                |> Utils.noCmd
