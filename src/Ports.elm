port module Ports
    exposing
        ( JsMsg(..)
        , fromJs
        , send
        )

import Json.Encode as Encode exposing (Value)


type JsMsg
    = ConsoleLog String
    | Square Int


toCmd : String -> Value -> Cmd msg
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


port toJs : Value -> Cmd msg


port fromJs : (Value -> msg) -> Sub msg
