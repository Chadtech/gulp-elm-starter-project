port module Ports.Incoming exposing
    ( Error
    , Listener
    , batch
    , errorToString
    , listen
    , map
    , none
    , subscription
    )

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)



---------------------------------------------------------------
-- TYPES --
---------------------------------------------------------------


type Listener msg
    = Batch (Dict String (Decoder msg))
    | Single String (Decoder msg)


type Error
    = NotFound String
    | BodyDecodeFail Decode.Error
    | StructureDecodeFail Decode.Error



---------------------------------------------------------------
-- API --
---------------------------------------------------------------


subscription : (Error -> msg) -> Listener msg -> Sub msg
subscription errorMsg listener =
    fromJs
        (\json ->
            case decode json listener of
                Ok msg ->
                    msg

                Err error ->
                    errorMsg error
        )


errorToString : Error -> String
errorToString error =
    case error of
        NotFound str ->
            "Message came in that we werent listening for : " ++ str

        BodyDecodeFail subError ->
            "Body decode error : " ++ Decode.errorToString subError

        StructureDecodeFail subError ->
            "Structure decode error : " ++ Decode.errorToString subError


listen : String -> Decoder msg -> Listener msg
listen type_ decoder =
    Single type_ decoder


batch : List (Listener msg) -> Listener msg
batch listeners =
    let
        batchFunctions : List (Listener msg) -> Dict String (Decoder msg)
        batchFunctions remainingListeners =
            case remainingListeners of
                first :: [] ->
                    case first of
                        Batch batchListeners ->
                            batchListeners

                        Single type_ decoder ->
                            Dict.singleton type_ decoder

                first :: rest ->
                    case first of
                        Batch batchListeners ->
                            Dict.union batchListeners (batchFunctions rest)

                        Single type_ decoder ->
                            Dict.insert type_ decoder (batchFunctions rest)

                [] ->
                    Dict.empty
    in
    Batch (batchFunctions listeners)


none : Listener msg
none =
    Batch Dict.empty


map : (a -> msg) -> Listener a -> Listener msg
map toMsg listener =
    case listener of
        Batch batchListeners ->
            Batch <| Dict.map (always <| Decode.map toMsg) batchListeners

        Single type_ decoder ->
            Single type_ <| Decode.map toMsg decoder



---------------------------------------------------------------
-- INTERNAL HELPERS --
---------------------------------------------------------------


decode : Decode.Value -> Listener msg -> Result Error msg
decode json listener =
    let
        incomingMsgDecoder : Decoder ( String, Decode.Value )
        incomingMsgDecoder =
            Decode.map2 Tuple.pair
                (Decode.field "type" Decode.string)
                (Decode.field "body" Decode.value)
    in
    case
        Decode.decodeValue
            incomingMsgDecoder
            json
    of
        Ok ( type_, body ) ->
            case listener of
                Batch batchListeners ->
                    case Dict.get type_ batchListeners of
                        Just decoder ->
                            Decode.decodeValue decoder body
                                |> Result.mapError BodyDecodeFail

                        Nothing ->
                            Err (NotFound type_)

                Single listenerType_ decoder ->
                    if listenerType_ == type_ then
                        Decode.decodeValue decoder body
                            |> Result.mapError BodyDecodeFail

                    else
                        Err (NotFound type_)

        Err error ->
            Err <| StructureDecodeFail error


port fromJs : (Decode.Value -> msg) -> Sub msg
