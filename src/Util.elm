module Util exposing (..)

import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Events exposing (keyCode, on)
import Json.Decode as Decode exposing (Decoder)


-- MAYBE --


maybeCons : Maybe a -> List a -> List a
maybeCons maybe list =
    case maybe of
        Just item ->
            item :: list

        Nothing ->
            list



-- LIST --


contains : List a -> a -> Bool
contains =
    flip List.member



-- HTML --


onEnter : msg -> Attribute msg
onEnter msg =
    on "keydown" (Decode.andThen (enterDecoder msg) keyCode)


enterDecoder : msg -> Int -> Decoder msg
enterDecoder msg code =
    if code == 13 then
        Decode.succeed msg
    else
        Decode.fail "Not enter"


viewIf : Bool -> Html msg -> Html msg
viewIf condition html =
    if condition then
        html
    else
        Html.text ""
