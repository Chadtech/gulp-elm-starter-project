module View exposing (view)

import Browser
import Css exposing (..)
import Html.Custom
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attrs
import Html.Styled.Events as Events
import Model exposing (Model)
import Msg exposing (Msg(..))
import Style


view : Model -> Browser.Document Msg
view model =
    { title = "Gulp Elm Boilerplate"
    , body =
        [ Style.globals
        , title
        , inputField model
        , enterCount model
        , squareOfCount model
        ]
            |> List.map Html.toUnstyled
    }


title : Html Msg
title =
    Html.p
        [ Attrs.css [ Style.bigFont ] ]
        [ Html.text "Elm Project : Go!" ]


inputField : Model -> Html Msg
inputField model =
    Html.input
        [ Attrs.value model.field
        , Events.onInput FieldUpdated
        , Attrs.placeholder "Press enter to console log msg"
        , Attrs.spellcheck False
        , Html.Custom.onEnter EnterHappened
        ]
        []


enterCount : Model -> Html Msg
enterCount model =
    Html.p
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
    Html.p
        []
        [ Html.text (squareText model) ]


squareText : Model -> String
squareText model =
    [ "The square of the number of times enter was pressed is"
    , String.fromInt model.squareOfEnterPresses
    ]
        |> String.join " "
