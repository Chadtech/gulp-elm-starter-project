module Body.View
    exposing
        ( Props
        , view
        )

import Html.Events exposing (onClick, onInput)
import Html.Provider as Html exposing (Html, br, button, div, input, p)
import Model exposing (Model)
import Msg exposing (Msg(..))


type alias Props =
    { count : Int
    , nameField : String
    }


view : Props -> Html Model Msg
view props =
    div
        []
        [ input
            [ onInput NameFieldUpdated ]
            []
        , br [] []
        , br [] []
        , button
            [ onClick Increment ]
            [ Html.text "+1" ]
        , p
            []
            [ Html.text (toString props.count) ]
        , button
            [ onClick Decrement ]
            [ Html.text "-1" ]
        , br [] []
        , br [] []
        ]
