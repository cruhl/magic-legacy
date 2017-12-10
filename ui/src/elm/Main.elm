module Main exposing (main)

import Html
import State.Model exposing (Model, init)
import State.Msg exposing (Msg)
import State.Update exposing (update)
import View.App exposing (view)


main : Program String Model Msg
main =
    Html.programWithFlags
        { init = init
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }
