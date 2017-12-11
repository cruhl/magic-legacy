module Types.Event exposing (Span)

import Time exposing (Time)


type alias Event a =
    { a | timing : Span }


type alias Span =
    { start : Time
    , end : Time
    }


type alias Call =
    Event { from : String, to : String }


type alias Audio =
    Event { timing : Span }


type alias Transcription =
    Event { transcript : String, confidence : Float }


type alias Speaker =
    Event { index : Int, confidence : Float }


type alias Word =
    Event { text : String, confidence : Float }
