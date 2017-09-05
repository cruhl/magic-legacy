module State.Model exposing (Model, init)

import State.Utils as Utils
import Types.Remote as Remote exposing (Remote)
import Types.User exposing (User)
import Types.Timeline exposing (Timeline)
import Mock.User
import Mock.Timeline


type alias Model =
    { user : User
    , timeline : Remote Timeline
    , selectedDescriptionId : Maybe String
    , selectedUser : Maybe User
    }


init : ( Model, Cmd msg )
init =
    { user = Mock.User.conner
    , timeline = Remote.Loaded (Ok Mock.Timeline.sell)
    , selectedUser = Nothing
    , selectedDescriptionId = Nothing
    }
        |> Utils.noCmd
