module Util.Html exposing (onEnter)

import Html.Styled exposing (Attribute)
import Html.Styled.Events as Events
import Json.Decode as Decode exposing (Decoder)


onEnter : msg -> Attribute msg
onEnter msg =
    let
        fromKeyCode : Int -> Decoder msg
        fromKeyCode code =
            if code == 13 then
                Decode.succeed msg

            else
                Decode.fail "KeyCode is not 13 (enter code)"
    in
    Events.keyCode
        |> Decode.andThen fromKeyCode
        |> Events.on "keydown"
