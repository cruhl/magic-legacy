module State.Msg exposing (Msg(..))

import Types.Timeline exposing (Timeline)
import Types.User exposing (User)
import Http


type Msg
    = TimelineLoaded (Result Http.Error Timeline)
    | OpenUserPage User
    | ExitUserPage
    | OpenDescriptionPage String
    | ExitDescriptionPage
