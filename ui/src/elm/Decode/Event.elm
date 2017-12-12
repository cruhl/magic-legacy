module Decode.Event
    exposing
        ( audio
        , call
        , speaker
        , transcription
        , word
        )

import Json.Decode as Decode exposing (Decoder)
import Types.Event as Event


call : Decoder Event.Call
call =
    Decode.map3 Event.Call
        timing
        (Decode.field "from" Decode.string)
        (Decode.field "to" Decode.string)


audio : Decoder Event.Audio
audio =
    Decode.map2 Event.Audio
        timing
        (Decode.field "uri" Decode.string)


transcription : Decoder Event.Transcription
transcription =
    Decode.map3 Event.Transcription
        timing
        (Decode.field "transcript" Decode.string)
        (Decode.field "confidence" Decode.float)


speaker : Decoder Event.Speaker
speaker =
    Decode.map3 Event.Speaker
        timing
        (Decode.field "index" Decode.int)
        (Decode.field "confidence" Decode.float)


word : Decoder Event.Word
word =
    Decode.map3 Event.Word
        timing
        (Decode.field "text" Decode.string)
        (Decode.field "confidence" Decode.float)


timing : Decoder Event.Span
timing =
    Decode.field "timing" span


span : Decoder Event.Span
span =
    Decode.map2 Event.Span
        (Decode.field "start" Decode.float)
        (Decode.field "end" Decode.float)
