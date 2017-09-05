module View.Navigation exposing (view)

import State.Msg exposing (Msg(ExitUserPage, ExitDescriptionPage))
import State.Model exposing (Model)
import View.Utils as Utils
import Html exposing (Html, div, h1, a, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    div [ class "navigation" ]
        [ div [ class "back" ] [ backButton model ]
        , h1 [ class "title" ] [ Utils.icon [ "home" ], text "eureka" ]
        , a [ class "menu" ] [ Utils.icon [ "ellipsis-v" ] ]
        ]


backButton : Model -> Html Msg
backButton { selectedUser, selectedDescriptionId } =
    let
        button backTo =
            a [ class "back", onClick backTo ]
                [ Utils.icon [ "chevron-left" ], text "back" ]
    in
        case ( selectedUser, selectedDescriptionId ) of
            ( Just _, _ ) ->
                button ExitUserPage

            ( _, Just _ ) ->
                button ExitDescriptionPage

            _ ->
                Utils.nothing
