module Main exposing (init, main, subscriptions, update)

import Browser
import Html.Styled
import Json.Decode as D
import Model exposing (Model)
import Msg exposing (Msg(..))
import Ports exposing (JsMsg)
import Return2 as R2
import View exposing (view)



-- MAIN --


main : Program D.Value Model Msg
main =
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
        |> Browser.document


init : D.Value -> ( Model, Cmd Msg )
init json =
    { field = ""
    , timesEnterWasPressed = 0
    , squareOfEnterPresses = 0
    }
        |> R2.withNoCmd



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
                |> R2.withNoCmd

        EnterHappened ->
            let
                newCount =
                    model.timesEnterWasPressed + 1
            in
            { model
                | timesEnterWasPressed = newCount
            }
                |> R2.withCmds
                    [ Ports.send (Ports.ConsoleLog model.field)
                    , Ports.send (Ports.Square newCount)
                    ]

        ReceivedSquare square ->
            { model | squareOfEnterPresses = square }
                |> R2.withNoCmd

        MsgDecodeFailed _ ->
            model
                |> R2.withNoCmd
