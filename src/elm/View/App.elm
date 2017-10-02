module View.App exposing (view)

import Color
import Html exposing (..)
import Html.Attributes exposing (..)
import State.Model exposing (Model)


view : Model -> Html msg
view model =
    div [ class "app" ]
        [ div [ class "light" ] [] ]
