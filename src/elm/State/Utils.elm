module State.Utils exposing (delay)

import Process
import Task
import Time exposing (Time)


delay : Time -> msg -> Cmd msg
delay time msg =
    Process.sleep time
        |> Task.perform (always msg)
