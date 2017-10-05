module Data.Scripts exposing (showRooms)

import Color exposing (rgba)
import Time exposing (second)
import Types.Script exposing (Action(..), Script, Timing(..))
import Utils.Tuple exposing ((=>))


showRooms : Script
showRooms =
    [ Now => Set [ "office-lamp" ] (rgba 255 255 255 1)
    , After (1 * Time.second) => Set [ "office-lamp" ] (rgba 255 0 0 1)
    , After (1 * Time.second) => Set [ "desk-lamp" ] (rgba 255 255 255 1)
    , Now => Set [ "office-lamp" ] (rgba 0 255 255 1)
    , After (1 * Time.second) => Set [ "entry" ] (rgba 255 255 255 1)
    ]
