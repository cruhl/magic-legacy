module View.User exposing (view, small, medium, textLink, profile)

import State.Msg exposing (Msg(OpenUserPage))
import Types.User as User exposing (User)
import View.Utils as Utils
import Html exposing (Html, div, a, text)
import Html.Attributes exposing (class, style, href)
import Html.Events exposing (onClick)


view : User -> Html msg
view ({ name, phone, email } as user) =
    Utils.page [ class "user" ]
        [ profile user
        , div [ class "name" ] [ text (name.first ++ " " ++ name.last) ]
        , div [ class "contact" ]
            [ Utils.buttonIconLeft [] [ Utils.icon [ "phone" ], text phone ]
            , Utils.buttonIconLeft [ class "blue" ]
                [ Utils.icon [ "envelope" ], text email ]
            ]
        ]


small : List (Html.Attribute Msg) -> User -> Html Msg
small attributes =
    profileAndNameLink <| [ class "small" ] ++ attributes


medium : List (Html.Attribute Msg) -> User -> Html Msg
medium attributes =
    profileAndNameLink <| [ class "medium" ] ++ attributes


profileAndNameLink : List (Html.Attribute Msg) -> User -> Html Msg
profileAndNameLink attributes ({ name } as user) =
    a ([ class "user", onClick (OpenUserPage user) ] ++ attributes)
        [ profile user, div [ class "name" ] [ text name.first ] ]


textLink : User -> Html Msg
textLink ({ name } as user) =
    Utils.textLink [ onClick (OpenUserPage user) ] [ text name.first ]


profile : User -> Html msg
profile ({ profileUrl } as user) =
    let
        wrapper attributes =
            div <| [ class "user profile" ] ++ attributes

        background url =
            style [ ( "background-image", "url(" ++ url ++ ")" ) ]

        profileWithImage url =
            wrapper [ background url ] []

        profileWithEmoji =
            wrapper [ class "no-image" ]
                [ div [ class "initials " ] [ text (User.initials user) ] ]
    in
        profileUrl
            |> Maybe.map profileWithImage
            |> Maybe.withDefault profileWithEmoji
