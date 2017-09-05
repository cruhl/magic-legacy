module View.Utils
    exposing
        ( page
        , nothing
        , icon
        , iconWrapped
        , textLink
        , textLinkIconLeft
        , textLinkIconRight
        , button
        , buttonIconLeft
        , buttonIconRight
        )

import Html exposing (Html, Attribute, div, i, a, span, text)
import Html.Attributes exposing (class, href)


page : List (Attribute msg) -> List (Html msg) -> Html msg
page attributes =
    div <| [ class "page" ] ++ attributes


nothing : Html msg
nothing =
    text ""


icon : List String -> Html msg
icon fontAwesomeClasses =
    i
        [ class "icon fa"
        , fontAwesomeClasses
            |> List.map (\class -> "fa-" ++ class)
            |> String.concat
            |> class
        ]
        []


iconWrapped : List String -> Html msg
iconWrapped fontAwesomeClasses =
    div [ class "icon-wrapper" ] [ icon fontAwesomeClasses ]


textLink : List (Attribute msg) -> List (Html msg) -> Html msg
textLink attributes =
    a <| [ class "text-link" ] ++ attributes


textLinkIconLeft : List (Attribute msg) -> List (Html msg) -> Html msg
textLinkIconLeft attributes =
    textLink <| [ class "icon-left" ] ++ attributes


textLinkIconRight : List (Attribute msg) -> List (Html msg) -> Html msg
textLinkIconRight attributes =
    textLink <| [ class "icon-right" ] ++ attributes


button : List (Attribute msg) -> List (Html msg) -> Html msg
button attributes =
    a <| [ class "button" ] ++ attributes


buttonIconLeft : List (Attribute msg) -> List (Html msg) -> Html msg
buttonIconLeft attributes =
    button <| [ class "icon-left" ] ++ attributes


buttonIconRight : List (Attribute msg) -> List (Html msg) -> Html msg
buttonIconRight attributes =
    button <| [ class "icon-right" ] ++ attributes
