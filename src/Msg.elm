module Msg
    exposing
        ( Msg(..)
        , decode
        )

import Json.Decode as Decode exposing (Decoder, Value)


type Msg
    = UpdateField String
    | EnterHappened
    | ReceivedSquare Int
    | MsgDecodeFailed String


decode : Value -> Msg
decode json =
    case Decode.decodeValue decoder json of
        Ok msg ->
            msg

        Err err ->
            MsgDecodeFailed err


decoder : Decoder Msg
decoder =
    Decode.string
        |> Decode.field "type"
        |> Decode.andThen
            (Decode.field "payload" << toMsg)


toMsg : String -> Decoder Msg
toMsg type_ =
    case type_ of
        "square computed" ->
            Decode.int
                |> Decode.map ReceivedSquare

        _ ->
            Decode.fail ("Unrecognized Msg type -> " ++ type_)
