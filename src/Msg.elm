module Msg exposing
    ( Msg(..)
    , decode
    )

import Json.Decode as D exposing (Decoder, Value)


type Msg
    = UpdateField String
    | EnterHappened
    | ReceivedSquare Int
    | MsgDecodeFailed D.Error


decode : Value -> Msg
decode json =
    case D.decodeValue decoder json of
        Ok msg ->
            msg

        Err err ->
            MsgDecodeFailed err


decoder : Decoder Msg
decoder =
    D.string
        |> D.field "type"
        |> D.andThen
            (D.field "payload" << toMsg)


toMsg : String -> Decoder Msg
toMsg type_ =
    case type_ of
        "square computed" ->
            D.int
                |> D.map ReceivedSquare

        _ ->
            D.fail ("Unrecognized Msg type -> " ++ type_)
