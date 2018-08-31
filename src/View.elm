module View exposing (view)

import Browser
import Css exposing (..)
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        , div
        , input
        , p
        )
import Html.Styled.Attributes as Attrs exposing (css)
import Html.Styled.Events exposing (onInput)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Style
import Util exposing (onEnter)


view : Model -> Browser.Document Msg
view model =
    { title = "Gulp Elm Boilerplate"
    , body =
        [ title
        , inputField model
        , enterCount model
        , squareOfCount model
        ]
            |> List.map Html.toUnstyled
    }


title : Html Msg
title =
    p
        [ css
            [ Style.bigFont
            , Style.pBasic
            ]
        ]
        [ Html.text "Elm Project : Go!" ]


inputField : Model -> Html Msg
inputField model =
    input
        [ css [ Style.inputBasic ]
        , Attrs.value model.field
        , onInput FieldUpdated
        , Attrs.placeholder "Press enter to console log msg"
        , Attrs.spellcheck False
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
    , String.fromInt model.timesEnterWasPressed
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
    , String.fromInt model.squareOfEnterPresses
    ]
        |> String.join " "
