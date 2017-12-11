module View.App exposing (view)

import Date exposing (Date)
import Date.Format as Date
import Html exposing (..)
import Html.Attributes exposing (..)
import State.Model exposing (Model)
import Time exposing (Time)
import Types.Event as Event
import Types.Timeline exposing (Timeline)
import Utils.Tuple exposing ((=>))


view : Model -> Html msg
view { timeline } =
    div [ class "app" ] [ viewTimeline timeline ]


viewTimeline : Timeline -> Html msg
viewTimeline { start, end, spans } =
    let
        duration =
            end - start
    in
    div [ class "timeline" ]
        [ spans
            |> List.map (span start duration)
            |> div [ class "spans" ]
        , spans
            |> List.map (span start duration)
            |> div [ class "spans" ]
        , spans
            |> List.map (span start duration)
            |> div [ class "spans" ]
        , timestamps start duration
        ]


span : Time -> Time -> Event.Span -> Html msg
span timelineStart timelineDuration { start, end } =
    let
        positioning =
            [ "left" => (start - timelineStart) / timelineDuration
            , "width" => (end - start) / timelineDuration
            ]
                |> List.map (Tuple.mapSecond toPercent)
                |> style

        toPercent ratio =
            toString (ratio * 100) ++ "%"
    in
    div [ class "span", positioning ] []


timestamps : Time -> Time -> Html msg
timestamps start duration =
    [ start
    , start + duration / 2
    , start + duration
    ]
        |> List.map (Date.fromTime >> timestamp)
        |> div [ class "timestamps" ]


timestamp : Date -> Html msg
timestamp date =
    div [ class "timestamp" ]
        [ div [ class "date" ] [ text (Date.format "%A, %B %e, %Y" date) ]
        , div [ class "time" ] [ text (Date.format "%l:%M:%S %P" date) ]
        ]
