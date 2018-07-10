module Header.View
    exposing
        ( Props
        , view
        )

import Html.Provider as Html exposing (Html, div, p)
import Model exposing (Model)
import Msg exposing (Msg)


type alias Props =
    { greeting : String }


view : Props -> Html Model Msg
view props =
    div
        []
        [ p
            []
            [ Html.text props.greeting ]
        ]
