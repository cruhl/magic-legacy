module Types.Timeline exposing (Data, Timeline)

import Time exposing (Time)
import Types.Event as Event


type alias Timeline =
    { start : Time
    , end : Time
    , data : Data
    }


type alias Data =
    { calls : List Event.Call
    , audio : List Event.Audio
    , transcriptions : List Event.Transcription
    , speakers : List Event.Speaker
    , words : List Event.Word
    }
