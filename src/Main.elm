module Main exposing (..)

import Html
import Html.Styled exposing (toUnstyled)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Ports exposing (JsMsg(ConsoleLog, Square))
import Return2 exposing (withCmds, withNoCmd)
import View exposing (view)


-- MAIN --


main : Program Never Model Msg
main =
    { init = init
    , view = toUnstyled << view
    , update = update
    , subscriptions = subscriptions
    }
        |> Html.program


init : ( Model, Cmd Msg )
init =
    { field = ""
    , timesEnterWasPressed = 0
    , squareOfEnterPresses = 0
    }
        |> withNoCmd



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions _ =
    Ports.fromJs Msg.decode



-- UPDATE --


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        UpdateField str ->
            { model | field = str }
                |> withNoCmd

        EnterHappened ->
            let
                newCount =
                    model.timesEnterWasPressed + 1
            in
            { model
                | timesEnterWasPressed = newCount
            }
                |> withCmds
                    [ Ports.send (ConsoleLog model.field)
                    , Ports.send (Square newCount)
                    ]

        ReceivedSquare square ->
            { model | squareOfEnterPresses = square }
                |> withNoCmd

        MsgDecodeFailed _ ->
            model |> withNoCmd
