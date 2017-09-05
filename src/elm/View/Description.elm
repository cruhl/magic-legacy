module View.Description exposing (view)

import State.Model exposing (Model)
import Types.Description as Description exposing (Description)
import View.Utils as Utils
import Html exposing (Html, div, article, span, text)
import Html.Attributes exposing (class)
import Markdown


view : Model -> String -> Html msg
view model descriptionId =
    Utils.page [ class "description" ] [ text "TODO" ]


descriptionFound : Description -> Html msg
descriptionFound description =
    case description of
        Description.Basic descriptionText ->
            span [ class "basic" ] [ text descriptionText ]

        Description.Markdown markdown ->
            article [] [ markdown |> Markdown.toHtml [ class "markdown" ] ]
