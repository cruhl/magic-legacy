module View.App exposing (view)

import Color exposing (Color)
import Html exposing (..)
import Html.Attributes exposing (..)
import State.Model exposing (Model)
import String
import Types.Light exposing (Light, Position)
import Utils.Tuple exposing ((=>))


view : Model -> Html msg
view model =
    div [ class "app" ]
        [ model
            |> List.map light
            |> List.concat
            |> div [ class "scene" ]
        ]


light : Light -> List (Html msg)
light { position, color } =
    let
        positioning =
            style
                [ "top" => toString position.y ++ "px"
                , "left" => toString position.x ++ "px"
                ]

        { red, blue, green, alpha } =
            Color.toRgb color

        colorCss =
            [ toFloat red
            , toFloat green
            , toFloat blue
            , alpha
            ]
                |> List.map toString
                |> List.intersperse ", "
                |> String.concat
                |> (\values -> "rgba(" ++ values ++ ")")
    in
    [ div [ class "bulb", positioning, style [ "background" => colorCss ] ] []
    , div [ class "glow", positioning, glow colorCss ] []
    , div [ class "overlay", positioning ] []
    ]


glow : String -> Html.Attribute msg
glow colorCss =
    let
        shadowRadius =
            170

        spreadAmount =
            0.3

        shadowPositioning =
            "0 0 "
                ++ toString shadowRadius
                ++ "px "
                ++ toString (shadowRadius * spreadAmount)
                ++ "px"
    in
    style [ "box-shadow" => shadowPositioning ++ " " ++ colorCss ]
