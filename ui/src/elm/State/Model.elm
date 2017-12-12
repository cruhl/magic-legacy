module State.Model exposing (Model, init)

import Date
import Decode.Timeline
import Json.Decode as Decode exposing (Decoder)
import State.Msg exposing (Msg)
import Time exposing (Time)
import Types.Timeline as Timeline exposing (Timeline)
import Utils.Tuple exposing ((=>))


type alias Model =
    { timeline : Timeline }


init : String -> ( Model, Cmd Msg )
init callsJson =
    let
        timeline =
            callsJson
                |> Decode.decodeString Decode.Timeline.data
                |> Result.withDefault (Timeline.Data [] [] [] [] [])
                |> Timeline start end

        -- 2017-12-10T04:40:53.000Z.wav
        ( start, end ) =
            ( 1512880850000
            , 1512880850000 + 30 * Time.second
            )
    in
    Model timeline => Cmd.none


toTime : String -> Time
toTime =
    Date.fromString
        >> Result.withDefault (Date.fromTime 0)
        >> Date.toTime
