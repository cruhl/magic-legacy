module State.Model exposing (Model, init)

import Color exposing (rgba)
import Types.Light exposing (Light, Status(..))
import Utils.Tuple exposing ((=>))


type alias Model =
    { lights : List Light
    , changeCount : Int
    }


init : ( Model, Cmd msg )
init =
    { lights = lights
    , changeCount = 0
    }
        => Cmd.none


lights : List Light
lights =
    [ light Enabled ( 60, 215 ) [ "office", "desk" ]
    , light Enabled ( 60, 375 ) [ "office", "desk" ]
    , light Enabled ( 200, 215 ) [ "office", "lamp" ]
    , light Disabled ( 172, 302 ) [ "office", "fan" ]
    , light Disabled ( 165, 315 ) [ "office", "fan" ]
    , light Disabled ( 180, 315 ) [ "office", "fan" ]
    , light Disabled ( 180, 655 ) [ "bathroom" ]
    , light Disabled ( 170, 655 ) [ "bathroom" ]
    , light Disabled ( 160, 655 ) [ "bathroom" ]
    , light Disabled ( 150, 655 ) [ "bathroom" ]
    , light Disabled ( 60, 725 ) [ "guest", "nightstand" ]
    , light Disabled ( 60, 860 ) [ "guest", "nightstand" ]
    , light Disabled ( 167, 780 ) [ "guest", "fan" ]
    , light Disabled ( 160, 793 ) [ "guest", "fan" ]
    , light Disabled ( 174, 793 ) [ "guest", "fan" ]
    , light Enabled ( 295, 350 ) [ "living", "table" ]
    , light Enabled ( 295, 530 ) [ "living", "table" ]
    , light Disabled ( 380, 290 ) [ "living", "fireplace" ]
    , light Disabled ( 425, 290 ) [ "living", "fireplace" ]
    , light Enabled ( 485, 250 ) [ "living", "lamp" ]
    , light Disabled ( 445, 425 ) [ "living", "fan" ]
    , light Disabled ( 436, 440 ) [ "living", "fan" ]
    , light Disabled ( 454, 440 ) [ "living", "fan" ]
    , light Disabled ( 490, 590 ) [ "living", "tv" ]
    , light Disabled ( 515, 573 ) [ "living", "tv" ]
    , light Disabled ( 395, 790 ) [ "living", "entry" ]
    , light Disabled ( 250, 530 ) [ "hallway" ]
    , light Disabled ( 540, 790 ) [ "laundry" ]
    , light Disabled ( 655, 335 ) [ "kitchen", "table" ]
    , light Disabled ( 647, 350 ) [ "kitchen", "table" ]
    , light Disabled ( 665, 350 ) [ "kitchen", "table" ]
    , light Enabled ( 645, 660 ) [ "kitchen", "cabinets" ]
    , light Enabled ( 672, 638 ) [ "kitchen", "cabinets" ]
    , light Enabled ( 700, 620 ) [ "kitchen", "cabinets" ]
    , light Disabled ( 778, 510 ) [ "kitchen", "storage" ]
    , light Disabled ( 640, 500 ) [ "kitchen", "bar" ]
    , light Disabled ( 590, 530 ) [ "kitchen", "bar" ]
    , light Disabled ( 490, 680 ) [ "kitchen", "pantry" ]
    , light Enabled ( 760, 305 ) [ "master", "desk" ]
    , light Enabled ( 1040, 245 ) [ "master", "nightstand" ]
    , light Enabled ( 1040, 430 ) [ "master", "nightstand" ]
    , light Disabled ( 900, 325 ) [ "master", "fan" ]
    , light Disabled ( 891, 341 ) [ "master", "fan" ]
    , light Disabled ( 909, 341 ) [ "master", "fan" ]
    , light Enabled ( 880, 630 ) [ "master", "bathroom" ]
    , light Disabled ( 995, 550 ) [ "master", "closet" ]
    , light Disabled ( 335, 870 ) [ "outside", "door" ]
    , light Disabled ( 453, 870 ) [ "outside", "door" ]
    , light Disabled ( 660, 1105 ) [ "outside", "garage" ]
    , light Disabled ( 1018, 1105 ) [ "outside", "garage" ]
    , light Disabled ( 525, 227 ) [ "outside", "patio" ]
    , light Disabled ( 715, 800 ) [ "garage", "left" ]
    , light Disabled ( 705, 817 ) [ "garage", "left" ]
    , light Disabled ( 723, 817 ) [ "garage", "left" ]
    , light Disabled ( 965, 800 ) [ "garage", "right" ]
    , light Disabled ( 955, 817 ) [ "garage", "right" ]
    , light Disabled ( 973, 817 ) [ "garage", "right" ]
    , light Disabled ( 840, 940 ) [ "garage", "motor" ]
    ]


light : Status -> ( Float, Float ) -> List String -> Light
light status ( x, y ) tags =
    { status = status
    , tags = tags
    , position = { x = x, y = y }
    , color = rgba 255 255 255 1
    }
