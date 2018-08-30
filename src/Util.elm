module Util exposing (contains, enterDecoder, maybeCons, onEnter, viewIf)

import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Events exposing (keyCode, on)
import Json.Decode as D exposing (Decoder)



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
contains list element =
    List.member element list



-- HTML --


onEnter : msg -> Attribute msg
onEnter msg =
    keyCode
        |> D.andThen (enterDecoder msg)
        |> on "keydown"


enterDecoder : msg -> Int -> Decoder msg
enterDecoder msg code =
    if code == 13 then
        D.succeed msg

    else
        D.fail "Not enter"


viewIf : Bool -> Html msg -> Html msg
viewIf condition html =
    if condition then
        html

    else
        Html.text ""
