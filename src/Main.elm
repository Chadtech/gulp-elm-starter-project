module Main exposing (main)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Global exposing (Global)
import Html.Styled as Html exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import Layout exposing (Document)
import Page.Home as Home
import Ports.Incoming
import Route exposing (Route)
import Url exposing (Url)
import Util.Cmd as CmdUtil



--------------------------------------------------------------------------------
-- MAIN --
--------------------------------------------------------------------------------


main : Program Decode.Value Model Msg
main =
    { init = init
    , view = Layout.toBrowserDocument << view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = UrlRequested
    , onUrlChange = RouteChanged << Route.fromUrl
    }
        |> Browser.application



--------------------------------------------------------------------------------
-- TYPES --
--------------------------------------------------------------------------------


type Model
    = PageNotFound Global
    | Home Home.Model


type Msg
    = MsgDecodeFailed Ports.Incoming.Error
    | UrlRequested UrlRequest
    | RouteChanged (Maybe Route)
    | HomeMsg Home.Msg



--------------------------------------------------------------------------------
-- INIT --
--------------------------------------------------------------------------------


init : Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init json url navKey =
    let
        global : Global
        global =
            Global.init navKey
    in
    PageNotFound global
        |> handleRouteChange (Route.fromUrl url)



--------------------------------------------------------------------------------
-- INTERNAL HELPERS --
--------------------------------------------------------------------------------


getGlobal : Model -> Global
getGlobal model =
    case model of
        PageNotFound global ->
            global

        Home subModel ->
            subModel.global



--------------------------------------------------------------------------------
-- UPDATE --
--------------------------------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MsgDecodeFailed _ ->
            model
                |> CmdUtil.withNoCmd

        UrlRequested urlRequest ->
            model
                |> CmdUtil.withNoCmd

        RouteChanged maybeRoute ->
            handleRouteChange maybeRoute model

        HomeMsg subMsg ->
            case model of
                Home subModel ->
                    Home.update subMsg subModel
                        |> CmdUtil.mapBoth Home HomeMsg

                _ ->
                    ( model, Cmd.none )


handleRouteChange : Maybe Route -> Model -> ( Model, Cmd Msg )
handleRouteChange maybeRoute model =
    let
        global =
            getGlobal model
    in
    case maybeRoute of
        Nothing ->
            PageNotFound global
                |> CmdUtil.withNoCmd

        Just route ->
            case route of
                Route.Landing ->
                    ( Home <| Home.init global
                    , Cmd.none
                    )



--------------------------------------------------------------------------------
-- VIEW --
--------------------------------------------------------------------------------


view : Model -> Document Msg
view model =
    case model of
        PageNotFound _ ->
            Layout.document
                "Page not found"
                [ Html.text "Page not found!" ]

        Home subModel ->
            Home.view subModel
                |> Layout.map HomeMsg



--------------------------------------------------------------------------------
-- SUBSCRIPTIONS --
--------------------------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.Incoming.subscription
        MsgDecodeFailed
        (incomingPortsListeners model)


incomingPortsListeners : Model -> Ports.Incoming.Listener Msg
incomingPortsListeners model =
    case model of
        PageNotFound _ ->
            Ports.Incoming.none

        Home _ ->
            Ports.Incoming.map HomeMsg Home.incomingPortsListener
