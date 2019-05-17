module Msg exposing
    ( Msg(..)
    , decode
    )

import Json.Decode as Decode exposing (Decoder)



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type Msg
    = FieldUpdated String
    | EnterHappened
    | ReceivedSquare Int
    | MsgDecodeFailed Decode.Error



--------------------------------------------------------------------------------
-- DECODE --
--------------------------------------------------------------------------------


decode : Decode.Value -> Msg
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
            (Decode.field "payload" << payloadDecoder)


payloadDecoder : String -> Decoder Msg
payloadDecoder type_ =
    case type_ of
        "square computed" ->
            Decode.int
                |> Decode.map ReceivedSquare

        _ ->
            Decode.fail ("Unrecognized Msg type -> " ++ type_)
