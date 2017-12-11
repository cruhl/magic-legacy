module State.Model exposing (Model, init)

import Date
import Json.Decode as Decode exposing (Decoder)
import State.Msg exposing (Msg)
import Time exposing (Time)
import Types.Event as Event
import Types.Timeline exposing (Timeline)
import Utils.Tuple exposing ((=>))


type alias Model =
    { timeline : Timeline }


init : String -> ( Model, Cmd Msg )
init callsJson =
    let
        timeline =
            callsJson
                |> Decode.decodeString (Decode.list decodeSpan)
                |> Result.withDefault []
                |> List.reverse
                |> Timeline start end

        -- 2017-12-10T04:40:53.000Z.wav
        ( start, end ) =
            ( 1512880850000
            , 1512880850000 + 1 * Time.minute
            )
    in
    Model timeline => Cmd.none


toTime : String -> Time
toTime =
    Date.fromString
        >> Result.withDefault (Date.fromTime 0)
        >> Date.toTime


decodeSpan : Decoder Event.Span
decodeSpan =
    Decode.map2 Event.Span
        (Decode.field "start" Decode.float)
        (Decode.field "end" Decode.float)
