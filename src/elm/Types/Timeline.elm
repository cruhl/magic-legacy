module Types.Timeline exposing (Timeline)

import Types.Property exposing (Property)
import Types.User exposing (User)
import Types.Event as Event


type alias Timeline =
    { state : Event.State
    , property : Property
    , sellers : List User
    , agents : List User
    }
