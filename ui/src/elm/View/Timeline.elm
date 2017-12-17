module View.Timeline exposing (view)

import Date exposing (Date)
import Date.Format as Date
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import State.Msg exposing (Msg(ZoomOut))
import Time exposing (Time)
import Types.Timeline exposing (Timeline)
import View.Event as Event


view : Timeline -> Html Msg
view ({ start, end, data } as timeline) =
    let
        duration =
            end - start

        source =
            div << (++) [ class "source" ]
    in
    div [ class "timeline" ]
        [ div [ class "events" ]
            [ data.calls
                |> List.map (Event.call timeline)
                |> source [ class "calls" ]
            , data.audio
                |> List.map (Event.audio timeline)
                |> source [ class "audio" ]
            , data.transcriptions
                |> List.map (Event.transcription timeline)
                |> source [ class "transcriptions" ]
            , data.speakers
                |> List.map (Event.speaker timeline)
                |> source [ class "speakers" ]
            , data.words
                |> List.map (Event.word timeline)
                |> source [ class "words" ]
            ]
        , timestamps start duration
        ]



-- source : String ->


timestamps : Time -> Time -> Html Msg
timestamps start duration =
    [ start
    , start + duration / 2
    , start + duration
    ]
        |> List.map (Date.fromTime >> timestamp)
        |> div [ class "timestamps", onClick ZoomOut ]


timestamp : Date -> Html msg
timestamp date =
    div [ class "timestamp" ]
        [ div [ class "date" ] [ text (Date.format "%A, %B %e, %Y" date) ]
        , div [ class "time" ] [ text (Date.format "%l:%M:%S %P" date) ]
        ]
