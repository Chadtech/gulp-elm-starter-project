module Util.Cmd exposing
    ( mapBoth
    , withNoCmd
    )


withNoCmd : model -> ( model, Cmd msg )
withNoCmd model =
    ( model, Cmd.none )


mapBoth : (subModel -> model) -> (subMsg -> msg) -> ( subModel, Cmd subMsg ) -> ( model, Cmd msg )
mapBoth modelF msgF ( subModel, cmd ) =
    ( modelF subModel
    , Cmd.map msgF cmd
    )
