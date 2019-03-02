module Util.Cmd exposing (withNoCmd)


withNoCmd : model -> ( model, Cmd msg )
withNoCmd model =
    ( model, Cmd.none )
