module Types.Event exposing (Span)

import Time exposing (Time)


type alias Span =
    { start : Time
    , end : Time
    }
