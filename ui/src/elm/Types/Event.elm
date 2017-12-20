module Types.Event
    exposing
        ( Audio
        , Call
        , Event
        , Speaker
        , TimeSpan
        , Timing(..)
        , Transcription
        , Word
        )

import Time exposing (Time)


type alias Event a =
    { timing : Timing, data : a }


type Timing
    = Instant Time
    | Interval TimeSpan


type alias TimeSpan =
    { start : Time
    , end : Time
    }


type alias Call =
    Event { from : String, to : String }


type alias Audio =
    Event { uri : String }


type alias Transcription =
    Event { transcript : String, confidence : Float }


type alias Speaker =
    Event { index : Int, confidence : Float }


type alias Word =
    Event { text : String, confidence : Float }
