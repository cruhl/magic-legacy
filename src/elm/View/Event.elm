module View.Event exposing (view)

import State.Msg exposing (Msg(OpenDescriptionPage))
import Types.Event as Event exposing (Event)
import Types.User as User exposing (User)
import View.User as User
import View.Utils as Utils
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Event -> Html Msg
view event =
    case event of
        Event.Stage state details ->
            step state details

        Event.Step state details ->
            step state details


step : Event.State -> Event.Details -> Html Msg
step state { title, descriptionId } =
    wrapper [ class "step" ]
        [ text title, readMore descriptionId ]



-- case state of
--     Event.NotStarted { events } ->
--         events |> List.map view
--
--     Event.Started { startDate } ->
--         [ completed
--             |> List.map view
--             |> div [ class "completed" ]
--         , view active
--         , upcoming
--             |> List.map view
--             |> div [ class "upcoming" ]
--         ]
--
--     Event.Completed { startDate, completeDate, events } ->
--         events |> List.map view


wrapper : List (Html.Attribute msg) -> List (Html msg) -> Html msg
wrapper attributes =
    div <| [ class "event" ] ++ attributes


readMore : Maybe String -> Html Msg
readMore descriptionId =
    let
        descriptionLink id =
            Utils.textLinkIconRight [ onClick (OpenDescriptionPage id) ]
                [ text "read more", Utils.icon [ "chevron-right" ] ]
    in
        descriptionId
            |> Maybe.map descriptionLink
            |> Maybe.withDefault Utils.nothing
