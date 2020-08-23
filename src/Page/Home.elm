module Page.Home exposing
    ( Model
    , Msg
    , getSession
    , incomingPortsListener
    , init
    , update
    , view
    )

import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attrs
import Html.Styled.Events as Events
import Json.Decode as Decode
import Layout exposing (Document)
import Ports.Incoming
import Ports.Outgoing
import Session exposing (Session)
import Style
import Util.Cmd as CmdUtil
import Util.Html as HtmlUtil



---------------------------------------------------------------
-- TYPES --
---------------------------------------------------------------


type alias Model =
    { session : Session
    , field : String
    , timesEnterWasPressed : Int
    , squareOfEnterPresses : Int
    }


type Msg
    = FieldUpdated String
    | EnterHappened
    | ReceivedSquare Int



--------------------------------------------------------------------------------
-- INIT --
--------------------------------------------------------------------------------


init : Session -> Model
init session =
    { session = session
    , field = ""
    , timesEnterWasPressed = 0
    , squareOfEnterPresses = 0
    }



--------------------------------------------------------------------------------
-- INTERNAL HELPERS --
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
-- API --
--------------------------------------------------------------------------------


getSession : Model -> Session
getSession model =
    model.session



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


logAndSquare : Model -> Cmd Msg
logAndSquare model =
    [ Ports.Outgoing.fromType_ "consoleLog"
        |> Ports.Outgoing.stringBody model.field
        |> Ports.Outgoing.send
    , Ports.Outgoing.fromType_ "square"
        |> Ports.Outgoing.intBody model.timesEnterWasPressed
        |> Ports.Outgoing.send
    ]
        |> Cmd.batch



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


view : Model -> Document Msg
view model =
    Layout.document
        "Gulp Elm Boilerplate"
        [ title
        , inputField model
        , enterCount model
        , squareOfCount model
        ]


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
-- PORTS --
--------------------------------------------------------------------------------


incomingPortsListener : Ports.Incoming.Listener Msg
incomingPortsListener =
    Ports.Incoming.listen "square computed"
        (Decode.map ReceivedSquare Decode.int)
