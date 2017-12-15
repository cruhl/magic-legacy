module Types.Event
    exposing
        ( Audio
        , Call
        , Span
        , Speaker
        , Transcription
        , Word
        )

import Time exposing (Time)


type alias Call =
    { timing : Span
    , from : String
    , to : String
    }


type alias Audio =
    { timing : Span
    , uri : String
    }


type alias Transcription =
    { timing : Span
    , transcript : String
    , confidence : Float
    }


type alias Speaker =
    { timing : Span
    , index : Int
    , confidence : Float
    }


type alias Word =
    { timing : Span
    , text : String
    , confidence : Float
    }


type alias Span =
    { start : Time
    , end : Time
    }
