module Main exposing (main)

import Html exposing (program)
import State.Model exposing (Model, init)
import State.Msg exposing (Msg)
import State.Update exposing (update)
import View.App exposing (view)


main : Program Never Model Msg
main =
    program
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = \_ -> view
        }
