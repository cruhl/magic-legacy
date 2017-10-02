module State.Model exposing (Model, init)

import Color exposing (rgba)
import Types.Light exposing (Light)
import Utils.Tuple exposing ((=>))


type alias Model =
    List Light


init : ( Model, Cmd msg )
init =
    [ ( 60, 215 ) => [ "office", "desk" ]
    , ( 60, 375 ) => [ "office", "desk" ]
    , ( 200, 215 ) => [ "office", "lamp" ]
    , ( 172, 302 ) => [ "office", "fan" ]
    , ( 165, 315 ) => [ "office", "fan" ]
    , ( 180, 315 ) => [ "office", "fan" ]
    , ( 180, 655 ) => [ "bathroom" ]
    , ( 170, 655 ) => [ "bathroom" ]
    , ( 160, 655 ) => [ "bathroom" ]
    , ( 150, 655 ) => [ "bathroom" ]
    , ( 60, 725 ) => [ "guest", "nightstand" ]
    , ( 60, 860 ) => [ "guest", "nightstand" ]
    , ( 167, 780 ) => [ "guest", "fan" ]
    , ( 160, 793 ) => [ "guest", "fan" ]
    , ( 174, 793 ) => [ "guest", "fan" ]
    , ( 295, 350 ) => [ "living", "table" ]
    , ( 295, 530 ) => [ "living", "table" ]
    , ( 405, 290 ) => [ "living", "fireplace" ]
    , ( 480, 290 ) => [ "living", "fireplace" ]
    , ( 445, 425 ) => [ "living", "fan" ]
    , ( 436, 440 ) => [ "living", "fan" ]
    , ( 454, 440 ) => [ "living", "fan" ]
    , ( 490, 590 ) => [ "living", "tv" ]
    , ( 515, 573 ) => [ "living", "tv" ]
    , ( 395, 790 ) => [ "living", "entry" ]
    , ( 250, 530 ) => [ "hallway" ]
    , ( 540, 790 ) => [ "laundry" ]
    , ( 655, 335 ) => [ "kitchen", "table" ]
    , ( 647, 350 ) => [ "kitchen", "table" ]
    , ( 665, 350 ) => [ "kitchen", "table" ]
    , ( 645, 660 ) => [ "kitchen", "cabinets" ]
    , ( 672, 638 ) => [ "kitchen", "cabinets" ]
    , ( 700, 620 ) => [ "kitchen", "cabinets" ]
    , ( 778, 510 ) => [ "kitchen", "storage" ]
    , ( 640, 500 ) => [ "kitchen", "bar" ]
    , ( 590, 530 ) => [ "kitchen", "bar" ]
    , ( 490, 680 ) => [ "kitchen", "pantry" ]
    , ( 760, 305 ) => [ "master", "desk" ]
    , ( 1040, 245 ) => [ "master", "nightstand" ]
    , ( 1040, 430 ) => [ "master", "nightstand" ]
    , ( 900, 325 ) => [ "master", "fan" ]
    , ( 891, 341 ) => [ "master", "fan" ]
    , ( 909, 341 ) => [ "master", "fan" ]
    , ( 880, 630 ) => [ "master", "bathroom" ]
    , ( 995, 550 ) => [ "master", "closet" ]
    ]
        |> List.map toLight
        => Cmd.none


toLight : ( ( Float, Float ), List String ) -> Light
toLight ( ( x, y ), tags ) =
    { tags = tags
    , position = { x = x, y = y }
    , color = rgba 255 255 255 0.5
    }
