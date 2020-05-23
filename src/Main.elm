port module Main exposing (main)

import Browser
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attrs
import Html.Styled.Events as Events
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Style
import Util.Cmd as CmdUtil
import Util.Html as HtmlUtil



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type alias Model =
    { field : String
    , timesEnterWasPressed : Int
    , squareOfEnterPresses : Int
    }


type Msg
    = FieldUpdated String
    | EnterHappened
    | ReceivedSquare Int
    | MsgDecodeFailed Decode.Error


type JsMsg
    = ConsoleLog String
    | Square Int



--------------------------------------------------------------------------------
-- HELPERS --
--------------------------------------------------------------------------------


setField : String -> Model -> Model
setField newField model =
    { model | field = newField }


setSquareOfEnterPresses : Int -> Model -> Model
setSquareOfEnterPresses newSquare model =
    { model | squareOfEnterPresses = newSquare }


incrementTimesEnterWasPressed : Model -> Model
incrementTimesEnterWasPressed model =
    { model | timesEnterWasPressed = model.timesEnterWasPressed + 1 }



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
-- UPDATE --
--------------------------------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FieldUpdated str ->
            model
                |> setField str
                |> CmdUtil.withNoCmd

        EnterHappened ->
            let
                newModel : Model
                newModel =
                    incrementTimesEnterWasPressed model
            in
            ( newModel
            , logAndSquare newModel
            )

        ReceivedSquare newSquare ->
            model
                |> setSquareOfEnterPresses newSquare
                |> CmdUtil.withNoCmd

        MsgDecodeFailed _ ->
            model
                |> CmdUtil.withNoCmd


logAndSquare : Model -> Cmd Msg
logAndSquare model =
    [ sendToJs (ConsoleLog model.field)
    , sendToJs (Square model.timesEnterWasPressed)
    ]
        |> Cmd.batch



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


view : Model -> Browser.Document Msg
view model =
    { title = "Gulp Elm Boilerplate"
    , body =
        [ Style.globals
        , title
        , inputField model
        , enterCount model
        , squareOfCount model
        ]
            |> List.map Html.toUnstyled
    }


title : Html Msg
title =
    Html.p
        [ Attrs.css [ Style.bigFont ] ]
        [ Html.text "Elm Project : Go!" ]


inputField : Model -> Html Msg
inputField model =
    Html.input
        [ Attrs.value model.field
        , Events.onInput FieldUpdated
        , Attrs.placeholder "Press enter to console log msg"
        , Attrs.spellcheck False
        , HtmlUtil.onEnter EnterHappened
        ]
        []


enterCount : Model -> Html Msg
enterCount model =
    Html.p
        []
        [ Html.text (enterText model) ]


enterText : Model -> String
enterText model =
    [ "Enter was pressed"
    , String.fromInt model.timesEnterWasPressed
    , "times"
    ]
        |> String.join " "


squareOfCount : Model -> Html Msg
squareOfCount model =
    Html.p
        []
        [ Html.text (squareText model) ]


squareText : Model -> String
squareText model =
    [ "The square of the number of times enter was pressed is"
    , String.fromInt model.squareOfEnterPresses
    ]
        |> String.join " "



--------------------------------------------------------------------------------
-- SUBSCRIPTIONS --
--------------------------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions _ =
    fromJs decodeMsg


decodeMsg : Decode.Value -> Msg
decodeMsg json =
    let
        decoder : Decoder Msg
        decoder =
            Decode.string
                |> Decode.field "type"
                |> Decode.andThen
                    (Decode.field "payload" << payloadDecoder)
    in
    case Decode.decodeValue decoder json of
        Ok msg ->
            msg

        Err err ->
            MsgDecodeFailed err


payloadDecoder : String -> Decoder Msg
payloadDecoder type_ =
    case type_ of
        "square computed" ->
            Decode.int
                |> Decode.map ReceivedSquare

        _ ->
            Decode.fail ("Unrecognized Msg type -> " ++ type_)



--------------------------------------------------------------------------------
-- PORTS --
--------------------------------------------------------------------------------


port toJs : Encode.Value -> Cmd msg


port fromJs : (Encode.Value -> msg) -> Sub msg


sendToJs : JsMsg -> Cmd msg
sendToJs msg =
    let
        toCmd : String -> Encode.Value -> Cmd msg
        toCmd type_ payload =
            [ ( "type", Encode.string type_ )
            , ( "payload", payload )
            ]
                |> Encode.object
                |> toJs
    in
    case msg of
        ConsoleLog str ->
            toCmd "consoleLog" (Encode.string str)

        Square int ->
            toCmd "square" (Encode.int int)
