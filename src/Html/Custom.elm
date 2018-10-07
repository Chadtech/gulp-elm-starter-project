module Html.Custom exposing (onEnter)

import Html.Styled exposing (Attribute)
import Html.Styled.Events exposing (keyCode, on)
import Json.Decode as D exposing (Decoder)


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
