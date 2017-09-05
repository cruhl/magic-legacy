module View.App exposing (view)

import State.Model exposing (Model)
import State.Msg exposing (Msg)
import View.Navigation as Navigation
import View.User as User
import View.Timeline as Timeline
import View.Description as Description
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


view : Model -> Html Msg
view ({ timeline, selectedUser, selectedDescriptionId } as model) =
    div [ class "app" ]
        [ Navigation.view model
        , case ( selectedDescriptionId, selectedUser ) of
            ( _, Just user ) ->
                User.view user

            ( Just descriptionId, _ ) ->
                descriptionId |> Description.view model

            _ ->
                Timeline.view model timeline
        ]
