module Data.Lights exposing (home)

import Color exposing (rgba)
import Types.Light exposing (Light, Status(..))


home : List Light
home =
    let
        light status ( x, y ) tags =
            { status = status
            , tags = tags
            , position = { x = x, y = y }
            , color = rgba 0 0 0 0
            }
    in
    [ light Enabled ( 60, 215 ) [ "office", "desk" ]
    , light Enabled ( 60, 375 ) [ "office", "desk" ]
    , light Enabled ( 200, 215 ) [ "office", "lamp" ]
    , light Enabled ( 172, 302 ) [ "office", "fan" ]
    , light Enabled ( 165, 315 ) [ "office", "fan" ]
    , light Enabled ( 180, 315 ) [ "office", "fan" ]
    , light Enabled ( 180, 655 ) [ "bathroom" ]
    , light Enabled ( 170, 655 ) [ "bathroom" ]
    , light Enabled ( 160, 655 ) [ "bathroom" ]
    , light Enabled ( 150, 655 ) [ "bathroom" ]
    , light Enabled ( 60, 725 ) [ "guest", "nightstand" ]
    , light Enabled ( 60, 860 ) [ "guest", "nightstand" ]
    , light Enabled ( 167, 780 ) [ "guest", "fan" ]
    , light Enabled ( 160, 793 ) [ "guest", "fan" ]
    , light Enabled ( 174, 793 ) [ "guest", "fan" ]
    , light Enabled ( 295, 350 ) [ "living", "table" ]
    , light Enabled ( 295, 530 ) [ "living", "table" ]
    , light Enabled ( 380, 290 ) [ "living", "fireplace" ]
    , light Enabled ( 425, 290 ) [ "living", "fireplace" ]
    , light Enabled ( 485, 250 ) [ "living", "lamp" ]
    , light Enabled ( 445, 425 ) [ "living", "fan" ]
    , light Enabled ( 436, 440 ) [ "living", "fan" ]
    , light Enabled ( 454, 440 ) [ "living", "fan" ]
    , light Enabled ( 490, 590 ) [ "living", "tv" ]
    , light Enabled ( 515, 573 ) [ "living", "tv" ]
    , light Enabled ( 395, 790 ) [ "living", "entry" ]
    , light Enabled ( 250, 530 ) [ "hallway" ]
    , light Enabled ( 540, 790 ) [ "laundry" ]
    , light Enabled ( 655, 335 ) [ "dining" ]
    , light Enabled ( 647, 350 ) [ "dining" ]
    , light Enabled ( 665, 350 ) [ "dining" ]
    , light Enabled ( 645, 660 ) [ "kitchen", "cabinets" ]
    , light Enabled ( 672, 638 ) [ "kitchen", "cabinets" ]
    , light Enabled ( 700, 620 ) [ "kitchen", "cabinets" ]
    , light Enabled ( 778, 510 ) [ "kitchen", "storage" ]
    , light Enabled ( 640, 500 ) [ "kitchen", "bar" ]
    , light Enabled ( 590, 530 ) [ "kitchen", "bar" ]
    , light Enabled ( 490, 680 ) [ "kitchen", "pantry" ]
    , light Enabled ( 760, 305 ) [ "master", "desk" ]
    , light Enabled ( 1040, 245 ) [ "master", "nightstand" ]
    , light Enabled ( 1040, 430 ) [ "master", "nightstand" ]
    , light Enabled ( 900, 325 ) [ "master", "fan" ]
    , light Enabled ( 891, 341 ) [ "master", "fan" ]
    , light Enabled ( 909, 341 ) [ "master", "fan" ]
    , light Enabled ( 880, 630 ) [ "master", "bathroom" ]
    , light Enabled ( 995, 550 ) [ "master", "closet" ]
    , light Enabled ( 335, 870 ) [ "outside", "door" ]
    , light Enabled ( 453, 870 ) [ "outside", "door" ]
    , light Enabled ( 660, 1105 ) [ "outside", "garage" ]
    , light Enabled ( 1018, 1105 ) [ "outside", "garage" ]
    , light Enabled ( 525, 227 ) [ "outside", "patio" ]
    , light Enabled ( 715, 800 ) [ "garage", "left" ]
    , light Enabled ( 705, 817 ) [ "garage", "left" ]
    , light Enabled ( 723, 817 ) [ "garage", "left" ]
    , light Enabled ( 965, 800 ) [ "garage", "right" ]
    , light Enabled ( 955, 817 ) [ "garage", "right" ]
    , light Enabled ( 973, 817 ) [ "garage", "right" ]
    , light Enabled ( 840, 940 ) [ "garage", "motor" ]
    ]
