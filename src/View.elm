module View exposing (view)

import Html exposing (Attribute, Html, div, input, p, text)
import Html.Attributes exposing (class, placeholder, spellcheck, value)
import Html.Events exposing (onInput)
import Types exposing (Model, Msg(..))
import Util exposing (onEnter)


-- VIEW --


view : Model -> Html Msg
view model =
    div
        [ class "main" ]
        [ title
        , inputField model.field
        , p
            [ class "point" ]
            [ text (toString model.timesEnterWasPressed) ]
        ]



-- COMPONENTS --


title : Html Msg
title =
    p
        [ class "point big" ]
        [ text "Elm Project : Go!" ]


inputField : String -> Html Msg
inputField str =
    input
        [ class "input-field"
        , value str
        , onInput UpdateField
        , placeholder "Press enter to console log msg"
        , spellcheck False
        , onEnter EnterHappened
        ]
        []
