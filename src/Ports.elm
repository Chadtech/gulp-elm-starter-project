port module Ports exposing
    ( JsMsg(..)
    , fromJs
    , send
    )

import Json.Encode as E exposing (Value)


type JsMsg
    = ConsoleLog String
    | Square Int


toCmd : String -> Value -> Cmd msg
toCmd type_ payload =
    [ ( "type", E.string type_ )
    , ( "payload", payload )
    ]
        |> E.object
        |> toJs


noPayload : String -> Cmd msg
noPayload type_ =
    toCmd type_ E.null


send : JsMsg -> Cmd msg
send msg =
    case msg of
        ConsoleLog str ->
            toCmd "consoleLog" (E.string str)

        Square int ->
            toCmd "square" (E.int int)


port toJs : Value -> Cmd msg


port fromJs : (Value -> msg) -> Sub msg
