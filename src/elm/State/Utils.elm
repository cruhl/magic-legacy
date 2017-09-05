module State.Utils exposing (noCmd, withCmd)


noCmd : model -> ( model, Cmd msg )
noCmd model =
    ( model, Cmd.none )


withCmd : Cmd msg -> model -> ( model, Cmd msg )
withCmd cmd model =
    ( model, cmd )
