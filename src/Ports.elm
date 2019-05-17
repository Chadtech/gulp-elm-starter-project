port module Ports exposing
    ( JsMsg(..)
    , fromJs
    , send
    )

import Json.Encode as Encode



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type JsMsg
    = ConsoleLog String
    | Square Int


toCmd : String -> Encode.Value -> Cmd msg
toCmd type_ payload =
    [ ( "type", Encode.string type_ )
    , ( "payload", payload )
    ]
        |> Encode.object
        |> toJs


noPayload : String -> Cmd msg
noPayload type_ =
    toCmd type_ Encode.null


send : JsMsg -> Cmd msg
send msg =
    case msg of
        ConsoleLog str ->
            toCmd "consoleLog" (Encode.string str)

        Square int ->
            toCmd "square" (Encode.int int)


port toJs : Encode.Value -> Cmd msg


port fromJs : (Encode.Value -> msg) -> Sub msg
