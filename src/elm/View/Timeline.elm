module View.Timeline exposing (view)

import State.Msg exposing (Msg)
import State.Model exposing (Model)
import Types.Remote as Remote exposing (Remote)
import Types.Timeline as Timeline exposing (Timeline)
import Types.Event as Event
import View.Event as Event
import View.Utils as Utils
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


view : Model -> Remote Timeline -> Html Msg
view model timeline =
    Utils.page [ class "timeline" ] <|
        case timeline of
            Remote.Loading ->
                [ text "Loading" ]

            Remote.Loaded (Err err) ->
                [ text (toString err) ]

            Remote.Loaded (Ok timeline) ->
                [ timelineLoaded timeline ]


timelineLoaded : Timeline -> Html Msg
timelineLoaded { state } =
    div [ class "events" ] <|
        case state of
            Event.NotStarted { events } ->
                events |> List.map Event.view

            Event.Started { startDate, completed, active, upcoming } ->
                [ completed
                    |> List.map Event.view
                    |> div [ class "completed" ]
                , Event.view active
                , upcoming
                    |> List.map Event.view
                    |> div [ class "upcoming" ]
                ]

            Event.Completed { startDate, completeDate, events } ->
                events |> List.map Event.view
