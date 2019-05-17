module Main exposing (main)

import Browser
import Json.Decode as Decode
import Model exposing (Model)
import Msg exposing (Msg(..))
import Ports
import Util.Cmd as CmdUtil
import View exposing (view)



--------------------------------------------------------------------------------
-- MAIN --
--------------------------------------------------------------------------------


main : Program Decode.Value Model Msg
main =
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
        |> Browser.document


init : Decode.Value -> ( Model, Cmd Msg )
init _ =
    { field = ""
    , timesEnterWasPressed = 0
    , squareOfEnterPresses = 0
    }
        |> CmdUtil.withNoCmd



--------------------------------------------------------------------------------
-- SUBSCRIPTIONS --
--------------------------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions _ =
    Ports.fromJs Msg.decode



--------------------------------------------------------------------------------
-- UPDATE --
--------------------------------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FieldUpdated str ->
            model
                |> Model.setField str
                |> CmdUtil.withNoCmd

        EnterHappened ->
            let
                newModel : Model
                newModel =
                    Model.incrementTimesEnterWasPressed model
            in
            ( newModel
            , logAndSquare newModel
            )

        ReceivedSquare newSquare ->
            model
                |> Model.setSquareOfEnterPresses newSquare
                |> CmdUtil.withNoCmd

        MsgDecodeFailed _ ->
            model
                |> CmdUtil.withNoCmd


logAndSquare : Model -> Cmd Msg
logAndSquare model =
    [ Ports.send (Ports.ConsoleLog model.field)
    , Ports.send (Ports.Square model.timesEnterWasPressed)
    ]
        |> Cmd.batch
