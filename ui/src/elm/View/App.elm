module View.App exposing (view)

import Date exposing (Date)
import Date.Format as Date
import Html exposing (..)
import Html.Attributes exposing (..)
import List.Extra as List
import State.Model exposing (Model)
import Time exposing (Time)
import Types.Event as Event
import Utils.Tuple exposing ((=>))


view : Model -> Html msg
view spans =
    case ( List.head spans, List.last spans ) of
        ( Just first, Just last ) ->
            let
                start =
                    first
                        |> .start
                        |> Date.toTime

                end =
                    last
                        |> .end
                        |> Date.toTime

                duration =
                    end - start
            in
            div [ class "app" ]
                [ div [ class "timeline" ]
                    [ spans
                        |> List.map (span start duration)
                        |> div [ class "spans" ]
                    , timestamps start duration
                    ]
                ]

        _ ->
            text "No spans!"


span : Time -> Time -> Event.Span -> Html msg
span timelineStart timelineDuration { start, end } =
    let
        startTime =
            Date.toTime start

        left =
            (startTime - timelineStart) / timelineDuration

        width =
            (Date.toTime end - startTime) / timelineDuration

        toPercent ratio =
            toString (ratio * 100) ++ "%"

        positioning =
            style
                [ "left" => toPercent left
                , "width" => toPercent width
                ]
    in
    div [ class "span", positioning ] []


timestamps : Time -> Time -> Html msg
timestamps timelineStart timelineDuration =
    [ timelineStart
    , timelineStart + timelineDuration / 2
    , timelineStart + timelineDuration
    ]
        |> List.map (Date.fromTime >> timestamp)
        |> div [ class "timestamps" ]


timestamp : Date -> Html msg
timestamp date =
    div []
        [ div [ class "date" ] [ text (Date.format "%A, %B %e, %Y" date) ]
        , div [ class "time" ] [ text (Date.format "%l:%M:%S %P" date) ]
        ]
