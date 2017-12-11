module State.Model exposing (Model, init)

import Date
import Json.Decode as Decode exposing (Decoder)
import State.Msg exposing (Msg)
import Types.Event as Event
import Types.Timeline exposing (Timeline)
import Utils.Tuple exposing ((=>))


type alias Model =
    { timeline : Timeline }


init : String -> ( Model, Cmd Msg )
init callsJson =
    case callsJson |> Decode.decodeString (Decode.list decodeSpan) of
        Ok calls ->
            let
                ( start, end ) =
                    ( toDate "October 4, 2017"
                    , toDate "December 10, 2017"
                    )

                toDate =
                    Date.fromString
                        >> Result.withDefault (Date.fromTime 0)
                        >> Date.toTime

                timeline =
                    Timeline start end (List.reverse calls)
            in
            Model timeline => Cmd.none

        Err err ->
            Debug.crash err


decodeSpan : Decoder Event.Span
decodeSpan =
    Decode.map2 Event.Span
        (Decode.field "start" Decode.float)
        (Decode.field "end" Decode.float)
