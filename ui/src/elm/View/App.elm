module View.App exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import State.Model exposing (Model)
import State.Msg exposing (Msg)
import View.Timeline as Timeline


view : Model -> Html Msg
view { timeline } =
    div [ class "app" ] [ Timeline.view timeline ]
