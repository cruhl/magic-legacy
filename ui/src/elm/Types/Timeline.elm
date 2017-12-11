module Types.Timeline exposing (Timeline)

import Time exposing (Time)
import Types.Event as Event


type alias Timeline =
    { start : Time
    , end : Time
    , spans : List Event.Span
    }
