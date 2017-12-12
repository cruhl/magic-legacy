module Decode.Timeline exposing (data)

import Decode.Event
import Json.Decode as Decode exposing (Decoder)
import Types.Timeline as Timeline


data : Decoder Timeline.Data
data =
    Decode.map5 Timeline.Data
        (Decode.field "calls" (Decode.list Decode.Event.call))
        (Decode.field "audio" (Decode.list Decode.Event.audio))
        (Decode.field "transcriptions" (Decode.list Decode.Event.transcription))
        (Decode.field "speakers" (Decode.list Decode.Event.speaker))
        (Decode.field "words" (Decode.list Decode.Event.word))
