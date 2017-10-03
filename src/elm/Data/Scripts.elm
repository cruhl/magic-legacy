module Data.Scripts exposing (showRooms)

import Color exposing (rgba)
import Time exposing (second)
import Types.Script exposing (Action(..), Script, Timing(..))
import Utils.Tuple exposing ((=>))


showRooms : Script
showRooms =
    [ Now => Set [ "office-lamp" ] (rgba 255 255 255 1) ]
