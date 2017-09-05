module Types.Event exposing (Event(..), Details, State(..))

import Types.User exposing (User)
import Date exposing (Date)


type
    Event
    -- = Milestone Details
    = Stage State Details
    | Step State Details


type alias Details =
    { title : String, descriptionId : Maybe String }


type State
    = NotStarted { events : List Event }
    | Started
        { startDate : Date
        , completed : List Event
        , active : Event
        , upcoming : List Event
        }
    | Completed
        { startDate : Date
        , completeDate : Date
        , events : List Event
        }
