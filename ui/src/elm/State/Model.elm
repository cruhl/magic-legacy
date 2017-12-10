module State.Model exposing (Model, init)

import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import State.Msg exposing (Msg)
import Types.Event as Event
import Utils.Tuple exposing ((=>))


type alias Model =
    List Event.Span


init : String -> ( Model, Cmd Msg )
init callsJson =
    case callsJson |> Decode.decodeString (Decode.list decodeSpan) of
        Ok calls ->
            calls
                |> List.reverse
                |> List.drop 1600
                |> List.take 500
                => Cmd.none

        Err err ->
            Debug.crash err


decodeSpan : Decoder Event.Span
decodeSpan =
    Decode.map2 Event.Span
        (Decode.field "start" decodeDate)
        (Decode.field "end" decodeDate)


decodeDate : Decoder Date
decodeDate =
    Decode.float |> Decode.map Date.fromTime



-- decodeCall : Decoder Call
-- decodeCall =
--     Decode.map2 Call
--         (Decode.field "price" Decode.float)
--         (Decode.field "audio" decodeAudio)
-- decodeAudio : Decoder Audio
-- decodeAudio =
--     Decode.map2 Audio
--         (Decode.field "uri" Decode.string)
--         (Decode.field "speech" decodeSpeech)
-- decodeSpeech : Decoder Speech
-- decodeSpeech =
--     Decode.map2 Speech
--         (Decode.field "transcriptions" Decode.list decodeTranscription)
--         (Decode.field "speech" decodeSpeech)
-- decodeTranscription : Decoder Transcription
-- decodeTranscription =
--     Decode.map2 Transcription
--         (Decode.field "confidence" Decode.float)
--         (Decode.field "text" Decode.string)
--
