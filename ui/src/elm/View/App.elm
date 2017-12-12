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
viewTimeline ({ start, end, data } as timeline) =
    let
        duration =
            end - start
    in
    div [ class "timeline" ]
        [ div [ class "events" ]
            [ transcriptions timeline data.transcriptions
            , speakers timeline data.speakers
            , words timeline data.words
            ]
        , timestamps start duration
        ]


transcriptions : Timeline -> List Event.Transcription -> Html msg
transcriptions timeline =
    let
        speaker { timing, transcript, confidence } =
            event
                [ class "transcription"
                , positioning timeline timing
                , fade confidence
                ]
                [ div [ class "text" ] [ text transcript ] ]
    in
    div [ class "transcriptions" ] << List.map speaker


speakers : Timeline -> List Event.Speaker -> Html msg
speakers timeline =
    let
        speaker { timing, index, confidence } =
            event [ class "speaker", positioning timeline timing ]
                [ div [ class "text" ] [ text (toString index) ] ]
    in
    div [ class "speakers" ] << List.map speaker


words : Timeline -> List Event.Word -> Html msg
words timeline =
    let
        word { timing, text, confidence } =
            event
                [ class "word"
                , positioning timeline timing
                , fade confidence
                ]
                [ div [ class "text" ] [ Html.text text ] ]
    in
    div [ class "words" ] << List.map word


event : List (Html.Attribute msg) -> List (Html msg) -> Html msg
event =
    div << (++) [ class "event" ]


fade : Float -> Html.Attribute msg
fade confidence =
    style [ "opacity" => toString confidence ]


positioning : Timeline -> Event.Span -> Html.Attribute msg
positioning timeline { start, end } =
    let
        duration =
            timeline.end - timeline.start

        toPercent ratio =
            toString (ratio * 100) ++ "%"
    in
    [ "left" => (start - timeline.start) / duration
    , "width" => (end - start) / duration
    ]
        |> List.map (Tuple.mapSecond toPercent)
        |> style


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
