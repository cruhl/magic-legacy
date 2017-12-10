module Types.Event exposing (Span)

import Date exposing (Date)


type alias Span =
    { start : Date
    , end : Date
    }



-- type Id
--     = Id String
-- type Timing
--     = Occurence Date
--     | Duration { start : Date, end : Date }
-- type alias Call =
--     Event
--         { price : Float
--         , audio : Audio
--         }
-- type alias Audio =
--     Event
--         { uri : String
--         , speech : Speech
--         }
-- type alias Speech =
--     Event { transcriptions : List Transcription }
-- type alias Transcription =
--     { confidence : Float, text : String }
