module Footer.View
    exposing
        ( Props
        , view
        )

import Html.Events exposing (onClick)
import Html.Provider as Html exposing (Html, button, div, p)
import Model exposing (Model)
import Msg exposing (Msg(..))


type alias Props =
    { disabled : Bool
    , message : Maybe String
    }


view : Props -> Html Model Msg
view props =
    div
        []
        [ messageView props.message
        , button
            [ onClick Submit ]
            [ Html.text (disabledText props.disabled) ]
        ]


messageView : Maybe String -> Html Model Msg
messageView maybeMsg =
    case maybeMsg of
        Just str ->
            p [] [ Html.text str ]

        Nothing ->
            Html.text ""


disabledText : Bool -> String
disabledText disabled =
    if disabled then
        "please dont submit"
    else
        "submit"
