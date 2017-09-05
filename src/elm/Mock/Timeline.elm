module Mock.Timeline exposing (sell)

import Types.Timeline as Timeline exposing (Timeline)
import Types.Event as Event exposing (Event)
import Types.User as User
import Mock.Property
import Mock.User
import Date exposing (Date)


sell : Timeline
sell =
    let
        events =
            [ -- toMilestone "Listing Agreement"
              -- , toMilestone "Photo Shoot"
              toStep "schedule the photo shoot"
            , toStep "get the house ready, inside and out"
            , toStep "take pictures"
            , toStep "edit photos and post"
              -- , toMilestone "Municipal Inspection"
              -- , toMilestone "Offer Negotiation"
              -- , toMilestone "Inspection"
            , toStep "schedule the home inspection"
            , toStep "inspections occurs"
            , toStep "review home inspection"
              -- , toMilestone "Appraisal"
            , toStep "schedule the appraisal"
            , toStep "appraisal occurs"
            , toStep "review appraisal"
              -- , toMilestone "Walk-Through"
            , toStep "schedule the walk-through"
            , toStep "respond to any concerns"
              -- , toMilestone "Closing"
            , toStep "gather closing items and bring wire instructions"
            , toStep "sign documents and wait for lender funding"
            ]

        toStep title =
            let
                state =
                    Event.NotStarted { events = [] }
            in
                Event.Step state { title = title, descriptionId = Nothing }

        { completed, active, upcoming } =
            case events of
                first :: second :: third :: forth :: rest ->
                    { completed = []
                    , active = first
                    , upcoming = second :: third :: forth :: rest
                    }

                _ ->
                    Debug.crash "Not enough mock events!"

        state =
            Event.Started
                { startDate = date
                , completed = completed
                , active = active
                , upcoming = upcoming
                }
    in
        { state = state
        , property = Mock.Property.bayPointe
        , sellers = [ Mock.User.conner, Mock.User.joe ]
        , agents = [ Mock.User.kim ]
        }


date : Date
date =
    "2017/5/17"
        |> Date.fromString
        |> Result.withDefault (Date.fromTime 0)
