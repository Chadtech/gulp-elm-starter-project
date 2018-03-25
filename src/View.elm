module View exposing (view)

import Css exposing (..)
import Html.Custom exposing (input, p)
import Html.Styled as Html exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css, placeholder, spellcheck, value)
import Html.Styled.Events exposing (onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Util exposing (onEnter)


-- STYLES --


big : Attribute Msg
big =
    [ fontSize (em 4) ]
        |> css



-- VIEW --


view : Model -> Html Msg
view model =
    div
        []
        [ title
        , inputField model
        , enterCount model
        , squareOfCount model
        ]


title : Html Msg
title =
    p
        [ big ]
        [ Html.text "Elm Project : Go!" ]


inputField : Model -> Html Msg
inputField model =
    input
        [ value model.field
        , onInput UpdateField
        , placeholder "Press enter to console log msg"
        , spellcheck False
        , onEnter EnterHappened
        ]
        []


enterCount : Model -> Html Msg
enterCount model =
    p
        []
        [ Html.text (enterText model) ]


enterText : Model -> String
enterText model =
    [ "Enter was pressed"
    , toString model.timesEnterWasPressed
    , "times"
    ]
        |> String.join " "


squareOfCount : Model -> Html Msg
squareOfCount model =
    p
        []
        [ Html.text (squareText model) ]


squareText : Model -> String
squareText model =
    [ "The square of the number of times enter was pressed is"
    , toString model.squareOfEnterPresses
    ]
        |> String.join " "
