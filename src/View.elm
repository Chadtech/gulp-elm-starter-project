module View exposing (view)

import Html exposing (Attribute, Html, div, input, p, text)
import Html.Attributes exposing (placeholder, spellcheck, value)
import Html.CssHelpers
import Html.Events exposing (onInput)
import Styles
import Styles.Shared exposing (Classes(..), appNameSpace)
import Types exposing (Model, Msg(..))
import Util exposing (onEnter)


{ id, class, classList } =
    Html.CssHelpers.withNamespace appNameSpace



-- VIEW --


view : Model -> Html Msg
view model =
    div
        []
        [ title
        , inputField model.field
        , p
            [ class [ Point ] ]
            [ text (toString model.timesEnterWasPressed) ]
        ]



-- COMPONENTS --


title : Html Msg
title =
    p
        [ class [ Point, Big ] ]
        [ text "Elm Project : Go!" ]


inputField : String -> Html Msg
inputField str =
    input
        [ class [ Field ]
        , value str
        , onInput UpdateField
        , placeholder "Press enter to console log msg"
        , spellcheck False
        , onEnter EnterHappened
        ]
        []
