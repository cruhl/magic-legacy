module View.Event exposing (audio, call, speaker, transcription, word)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types.Event as Event
import Types.Timeline exposing (Timeline)
import Utils.Tuple exposing ((=>))


call : Timeline -> Event.Call -> Html msg
call timeline { timing } =
    event [ class "call", positioning timeline timing ] []


audio : Timeline -> Event.Audio -> Html msg
audio timeline { timing } =
    event [ class "recording", positioning timeline timing ]
        []


transcription : Timeline -> Event.Transcription -> Html msg
transcription timeline { timing, transcript, confidence } =
    event
        [ class "transcription", positioning timeline timing ]
        []


speaker : Timeline -> Event.Speaker -> Html msg
speaker timeline { timing, index, confidence } =
    event [ class "speaker", positioning timeline timing ]
        []


word : Timeline -> Event.Word -> Html msg
word timeline { timing, text, confidence } =
    event [ class "word", positioning timeline timing ]
        []


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
