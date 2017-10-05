module Data.Lights exposing (default)

import Color exposing (rgba)
import Dict exposing (Dict)
import Types.Light exposing (Light, Status(..))
import Utils.Tuple exposing ((=>))


light : Status -> ( Float, Float ) -> Light
light status ( x, y ) =
    { status = status
    , position = { x = x, y = y }
    , color = rgba 0 0 0 0
    }


default : Dict String Light
default =
    [ "office-desk-window" => light Enabled ( 60, 215 )
    , "office-desk-treadmill" => light Enabled ( 60, 375 )
    , "office-lamp" => light Enabled ( 200, 215 )
    , "office-fan-1" => light Enabled ( 172, 302 )
    , "office-fan-2" => light Enabled ( 165, 315 )
    , "office-fan-3" => light Enabled ( 180, 315 )
    , "bathroom-1" => light Enabled ( 180, 655 )
    , "bathroom-2" => light Enabled ( 170, 655 )
    , "bathroom-3" => light Enabled ( 160, 655 )
    , "bathroom-4" => light Enabled ( 150, 655 )
    , "guest-nightstand-left" => light Enabled ( 60, 725 )
    , "guest-nightstand-right" => light Enabled ( 60, 860 )
    , "guest-fan-1" => light Enabled ( 167, 780 )
    , "guest-fan-2" => light Enabled ( 160, 793 )
    , "guest-fan-3" => light Enabled ( 174, 793 )
    , "living-table-right" => light Enabled ( 295, 350 )
    , "living-table-left" => light Enabled ( 295, 530 )
    , "living-fireplace-left" => light Enabled ( 380, 290 )
    , "living-fireplace-right" => light Enabled ( 425, 290 )
    , "living-lamp" => light Enabled ( 485, 250 )
    , "living-fan-1" => light Enabled ( 445, 425 )
    , "living-fan-2" => light Enabled ( 436, 440 )
    , "living-fan-3" => light Enabled ( 454, 440 )
    , "living-tv-right" => light Enabled ( 490, 590 )
    , "living-tv-left" => light Enabled ( 515, 573 )
    , "living-entry" => light Enabled ( 395, 790 )
    , "hallway" => light Enabled ( 250, 530 )
    , "laundry" => light Enabled ( 540, 790 )
    , "dining-fan-1" => light Enabled ( 655, 335 )
    , "dining-fan-2" => light Enabled ( 647, 350 )
    , "dining-fan-3" => light Enabled ( 665, 350 )
    , "kitchen-cabinets-1" => light Enabled ( 645, 660 )
    , "kitchen-cabinets-2" => light Enabled ( 672, 638 )
    , "kitchen-cabinets-3" => light Enabled ( 700, 620 )
    , "kitchen-storage" => light Enabled ( 778, 510 )
    , "kitchen-bar-1" => light Enabled ( 640, 500 )
    , "kitchen-bar-2" => light Enabled ( 590, 530 )
    , "kitchen-pantry" => light Enabled ( 490, 680 )
    , "master-desk" => light Enabled ( 760, 305 )
    , "master-nightstand-left" => light Enabled ( 1040, 245 )
    , "master-nightstand-right" => light Enabled ( 1040, 430 )
    , "master-fan-1" => light Enabled ( 900, 325 )
    , "master-fan-2" => light Enabled ( 891, 341 )
    , "master-fan-3" => light Enabled ( 909, 341 )
    , "master-bathroom" => light Enabled ( 880, 630 )
    , "master-closet" => light Enabled ( 995, 550 )
    , "outside-door-left" => light Enabled ( 335, 870 )
    , "outside-door-right" => light Enabled ( 453, 870 )
    , "outside-garage-left" => light Enabled ( 660, 1105 )
    , "outside-garage-right" => light Enabled ( 1018, 1105 )
    , "outside-patio" => light Enabled ( 525, 227 )
    , "garage-fan-left-1" => light Enabled ( 715, 800 )
    , "garage-fan-left-2" => light Enabled ( 705, 817 )
    , "garage-fan-left-3" => light Enabled ( 723, 817 )
    , "garage-fan-right-1" => light Enabled ( 965, 800 )
    , "garage-fan-right-2" => light Enabled ( 955, 817 )
    , "garage-fan-right-3" => light Enabled ( 973, 817 )
    , "garage-motor" => light Enabled ( 840, 940 )
    ]
        |> Dict.fromList
